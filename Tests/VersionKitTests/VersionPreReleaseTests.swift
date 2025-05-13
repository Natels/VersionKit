//
//  VersionPreReleaseTests.swift
//  VersionKit
//
//  Created by Nathan Smith on 12/5/25.
//

import Testing

@testable import VersionKit

/// [Pre-release identifier spec](https://semver.org/#spec-item-9)
@MainActor
@Suite("Given version pre-release identifiers")
struct VersionPreReleaseTests {

  struct TestData {
    var versionString: String
    var expectedPreReleaseIdentifier: String?

    init(_ versionString: String, _ expectedPreReleaseIdentifier: String?) {
      self.versionString = versionString
      self.expectedPreReleaseIdentifier = expectedPreReleaseIdentifier
    }
  }

  @Test(
    "then must be included after the patch",
    arguments: [
      TestData("1.0.0-alpha", "alpha"),
      TestData("1.0.0-beta.1", "beta.1"),
      TestData("1.0.0-0.3.7", "0.3.7"),
      TestData("1.0.0-x.7.z.92", "x.7.z.92"),
      TestData("1.0.0-x-y-z.--", "x-y-z.--"),
      TestData("1.0.0", nil),
    ])
  func testPreReleaseIdentifier(test: TestData) throws {
    #expect(throws: Never.self) {
      try Version(test.versionString)
    }

    let version = try Version(test.versionString)

    #expect(version.preReleaseIdentifier == test.expectedPreReleaseIdentifier)
  }
}
