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

  init(_ input: String) throws {
    guard let match = input.firstMatch(of: Version.versionExpression) else {
      throw VersionValidationError.invalidFormat
    }

    let (_, major, minor, patch) = match.output

    guard let major = Int(major) else {
      throw VersionValidationError.invalidComponent(.major)
    }
    self.major = major

    guard let minor = Int(minor) else {
      throw VersionValidationError.invalidComponent(.minor)
    }
    self.minor = minor

    guard let patch = Int(patch) else {
      throw VersionValidationError.invalidComponent(.patch)
    }
    self.patch = patch
  }
  
  static let versionExpression = Regex {
    Optionally {
      One(.anyOf("vV"))
    }
    Capture {
      OneOrMore(.digit)
    }
    "."
    Capture {
      OneOrMore(.digit)
    }
    "."
    Capture {
      OneOrMore(.digit)
    }
  }
}
