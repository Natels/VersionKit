enum VersionValidationError: Error {
  case invalidFormat(String)
}

struct Version {
  init(_ input: String) throws {
    var versionString = input
    // Handle the case where the version string starts with the letters "v"
    // or "V"
    if versionString.hasPrefix("v") || versionString.hasPrefix("V") {
      versionString.removeFirst()
    }

    let versionComponents = versionString.split(separator: ".")

    guard versionComponents.count == 3 else {
      throw VersionValidationError.invalidFormat(
        "Version string must contaion MAJOR.MINOR.PATCH format"
      )
    }

    guard versionComponents.allSatisfy({ $0.allSatisfy(\.isNumber) }) else {
      throw VersionValidationError.invalidFormat(
        "Version string must contain only numbers"
      )
    }
  }
}
