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

    let (_, major, minor, patch, preReleaseIdentifier) = match.output

    self.major = major
    self.minor = minor
    self.patch = patch
    self.preReleaseIdentifier = preReleaseIdentifier
  }

  static let numeric = Reference(Int.self)
  static let optionalStringIdentifier = Reference(String.self)

  static let letter = CharacterClass("a"..."z", "A"..."Z")
  static let positiveNumber = CharacterClass("1"..."9")

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

  /// Semver numeric identifier
  ///
  /// <numeric identifier> ::= "0"
  ///                        | <positive digit>
  ///                        | <positive digit> <digits>
  static let numericIdentifier = Regex {
    ChoiceOf {
      Regex {
        One("0")
        ChoiceOf {
          Lookahead(.anyOf(".-+"))
          Anchor.endOfSubject
        }
      }
      Regex {
        Version.positiveNumber
        ZeroOrMore(.digit)
      }
    }
  }

  static let dotSeperatedIdentifier = Regex {
    OneOrMore(Version.identifierCharacter)
    ZeroOrMore {
      "."
      OneOrMore(Version.identifierCharacter)
    }
  }

  static let versionExpression = Regex {
    Anchor.wordBoundary
    Optionally {
      One(.anyOf("vV"))
    }
    Capture(as: Version.numeric) {
      Version.numericIdentifier
    } transform: {
      Int($0)!
    }
    "."
    Capture(as: Version.numeric) {
      Version.numericIdentifier
    } transform: {
      Int($0)!
    }
    "."
    Capture(as: Version.numeric) {
      Version.numericIdentifier
    } transform: {
      Int($0)!
    }
    Optionally {
      "-"
      Capture(as: Version.optionalStringIdentifier) {
        Version.dotSeperatedIdentifier
      } transform: {
        String($0)
      }
    }
  }
}
