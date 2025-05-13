import Testing

@testable import VersionKit

@MainActor
@Suite("When validating a version core string")
struct VersionKit_VersionCoreValidation_Tests {
  @Test("versions without MAJOR.MINOR.PATCH format are invalid")
  func testInvalidVersionString() {
    let invalidVersionString = "invalidVersionString"

    #expect(throws: VersionValidationError.self) {
      try Version(invalidVersionString)
    }
  }

  @Test(
    "versions with a non-numeric MAJOR version are invalid",
    arguments: [
      "a.0.0",
      "+.0.0",
      "-.0.0",
      "^.0.0",
    ])
  func testNonNumericMajorVersionString(nonNumericVersionString: String) {
    #expect(throws: VersionValidationError.self) {
      try Version(nonNumericVersionString)
    }
  }

  @Test(
    "versions with a non-numeric MINOR version are invalid",
    arguments: [
      "0.a.0",
      "0.+.0",
      "0.-.0",
      "0.^.0",
    ])
  func testNonNumericMinorVersionString(nonNumericVersionString: String) {
    #expect(throws: VersionValidationError.self) {
      try Version(nonNumericVersionString)
    }
  }

  @Test(
    "versions with a non-numeric PATCH version are invalid",
    arguments: [
      "0.0.a",
      "0.0.+",
      "0.0.-",
      "0.0.^",
    ])
  func testNonNumericPatchVersionString(nonNumericVersionString: String) {
    #expect(throws: VersionValidationError.self) {
      try Version(nonNumericVersionString)
    }
  }

  @Test(
    "versions may start with a leading `v`",
    arguments: [
      "1.0.0",
      "v1.0.0",
      "V1.0.0",
    ])
  func testLeadingV(versionString: String) {
    #expect(throws: Never.self) {
      try Version(versionString)
    }
  }
}
