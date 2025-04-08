enum VersionValidationError: Error {
    case invalidFormat(String)
}

struct Version {
    let preRelease: String?
    let build: String?

    init(_ input: String) throws {
        var versionString = input
        // Handle the case where the version string starts with the letters "v"
        // or "V"
        if versionString.hasPrefix("v") || versionString.hasPrefix("V") {
            versionString.removeFirst()
        }

        var versionCore: String

        if versionString.contains("-") && versionString.contains("+") {
            var components = versionString.split(separator: "-", maxSplits: 1)
            versionCore = String(components[0])

            components = components[1].split(separator: "+", maxSplits: 1)

            self.preRelease = String(components[0])
            self.build = String(components[1])
        } else if versionString.contains("-") {
            let components = versionString.split(separator: "-", maxSplits: 1)
            versionCore = String(components[0])

            self.preRelease = String(components[1])
            self.build = nil
        } else if versionString.contains("+") {
            let components = versionString.split(separator: "+", maxSplits: 1)
            versionCore = String(components[0])

            self.preRelease = nil
            self.build = String(components[1])
        } else {
            versionCore = versionString

            self.preRelease = nil
            self.build = nil
        }

        let versionComponents = versionCore.split(separator: ".")

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
