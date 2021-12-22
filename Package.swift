// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "QuickLookPreview",
    platforms: [
        .macCatalyst(.v15)],
    products: [
        .library(
            name: "QuickLookPreview",
            targets: ["QuickLookPreview"]),
    ],
    targets: [
        .target(
            name: "QuickLookPreview",
            dependencies: []),
    ]
)
