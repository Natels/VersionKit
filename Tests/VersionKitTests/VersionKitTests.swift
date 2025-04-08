import Testing

@testable import VersionKit

@Suite("When validating a version string")
struct VersionKit_Validation_Tests {
    @Test("versions without MAJOR.MINOR.PATCH format are invalid")
    func testInvalidVersionString() {
        let invalidVersionString = "invalidVersionString"

        #expect(throws: VersionValidationError.self) {
            try Version(invalidVersionString)
        }
    }

    @Test("versions with a non-numeric MAJOR version are invalid")
    func testNonNumericMajorVersionString() {
        let nonNumericVersionString = "a.0.0"

        #expect(throws: VersionValidationError.self) {
            try Version(nonNumericVersionString)
        }
    }

    @Test("versions with a non-numeric MINOR version are invalid")
    func testNonNumericMinorVersionString() {
        let nonNumericMinorVersionString = "1.a.0"

        #expect(throws: VersionValidationError.self) {
            try Version(nonNumericMinorVersionString)
        }
    }

    @Test("versions with a non-numeric PATCH version are invalid")
    func testNonNumericPatchVersionString() {
        let nonNumericPatchVersionString = "1.0.a"

        #expect(throws: VersionValidationError.self) {
            try Version(nonNumericPatchVersionString)
        }
    }

}
