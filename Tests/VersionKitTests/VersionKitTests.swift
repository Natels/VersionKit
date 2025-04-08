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
  func testNonNumericVersionString() {
    let nonNumericVersionString = "a.0.0"

    #expect(throws: VersionValidationError.self) {
      try Version(nonNumericVersionString)
    }
  }
}
