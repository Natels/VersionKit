import Testing

@testable import VersionKit

@Suite("When validating a version string")
struct VersionKit_Validation_Tests {
    @Test("versions without MAJOR.MINOR.PATCH format are invalid")
    func testInvalidVersionString() {
        let invalidVersionString = "invalidVersionString"

        #expect(throws: Error.self) { try Version(invalidVersionString) }
    }
}
