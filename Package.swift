// swift-tools-version: 6.1.0

import PackageDescription

let package = Package(
    name: "VersionKit",
    products: [
        .library(
            name: "VersionKit",
            targets: ["VersionKit"]
        ),
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
