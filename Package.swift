// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FadeInText",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "FadeInText",
            targets: ["FadeInText"]
        ),
    ],
    targets: [
        .target(
            name: "FadeInText"
        ),
        .testTarget(
            name: "FadeInTextTests",
            dependencies: [
                "FadeInText",
            ]
        ),
    ]
)
