// swift-tools-version: 6.1.0

import PackageDescription

let package = Package(
  name: "VersionKit",
  platforms: [.iOS(.v16), .macOS(.v13)],
  products: [
    .library(
      name: "VersionKit",
      targets: ["VersionKit"]
    )
  ],
  targets: [
    .target(
      name: "VersionKit",
      dependencies: []
    ),
    .testTarget(
      name: "VersionKitTests",
      dependencies: ["VersionKit"]
    ),
  ]
)
