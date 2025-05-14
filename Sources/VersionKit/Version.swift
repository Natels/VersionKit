import RegexBuilder

enum VersionComponent {
  case major
  case minor
  case patch
}

enum VersionValidationError: Error {
  case invalidFormat
  case invalidComponent(VersionComponent)
}

@MainActor
struct Version {
  let major: Int
  let minor: Int
  let patch: Int

  let preReleaseIdentifier: String?

  init(_ input: String) throws {
    guard let match = input.wholeMatch(of: Version.versionExpression) else {
      throw VersionValidationError.invalidFormat
    }

    self.major = match[Version.major]
    self.minor = match[Version.minor]
    self.patch = match[Version.patch]
    self.preReleaseIdentifier = match[Version.preReleaseTag]
  }
}

extension Version {
  static let major = Reference(Int.self)
  static let minor = Reference(Int.self)
  static let patch = Reference(Int.self)
  static let preReleaseTag = Reference(String?.self)

  static let letter = CharacterClass("a"..."z", "A"..."Z")

  static let nonDigit = Regex {
    ChoiceOf {
      "-"
      Version.letter
    }
  }

  static let identifierCharacter = Regex {
    ChoiceOf {
      .digit
      Version.nonDigit
    }
  }

  static let numericIdentifier = Regex {
    ChoiceOf {
      One("0")
      Regex {
        NegativeLookahead {
          "0"
        }
        OneOrMore(.digit)
      }
    }
  }

  static let alphaNumericIdentifier = Regex {
    NegativeLookahead {
      "0"
    }
    OneOrMore {
      Version.identifierCharacter
    }
  }

  static let dotSeperatedIdentifier = Regex {
    ChoiceOf {
      Version.numericIdentifier
      Version.alphaNumericIdentifier
    }
    ZeroOrMore {
      "."
      ChoiceOf {
        Version.numericIdentifier
        Version.alphaNumericIdentifier
      }
    }
  }

  static let versionExpression = Regex {
    Anchor.wordBoundary
    Optionally {
      One(.anyOf("vV"))
    }
    Capture(as: Version.major) {
      Version.numericIdentifier
    } transform: {
      Int($0)!
    }
    "."
    Capture(as: Version.minor) {
      Version.numericIdentifier
    } transform: {
      Int($0)!
    }
    "."
    Capture(as: Version.patch) {
      Version.numericIdentifier
    } transform: {
      Int($0)!
    }
    Optionally {
      "-"
      Capture(as: Version.preReleaseTag) {
        Version.dotSeperatedIdentifier
      } transform: {
        String($0)
      }
    }
  }
}
