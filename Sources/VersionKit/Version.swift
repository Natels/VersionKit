enum VersionValidationError: Error {
    case invalidFormat(String)
}

struct Version {
    init(_ input: String) throws {
        let segments = input.split(separator: ".")

        guard segments.count == 3 else {
            throw VersionValidationError.invalidFormat(
                "Version string must be in MAJOR.MINOR.PATCH format"
            )
        }
    }
}
