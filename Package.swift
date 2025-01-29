// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "VersionKit",
    products: [
        .plugin(name: "VersionKit", targets: ["VersionKit"]),
        .executable(name: "VersionKitTest", targets: ["VersionKitTest"]),
    ],
    targets: [
        .plugin(
            name: "VersionKit",
            capability: .buildTool()
        ),
        .executableTarget(
            name: "VersionKitTest",
            plugins: [
                .plugin(name: "VersionKit")
            ]
        ),
    ]
)
