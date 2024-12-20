// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "ticks",
    products: [
        .executable(
            name: "ticks",
            targets: ["ticks"]),
    ],
    dependencies: [
        .package(url: "https://github.com/microswift-packages/ATmega328P", from: "2.0.0")
    ],
    targets: [
        .target(
            name: "ticks",
            dependencies: [],
            path: ".",
            sources: ["ticks.swift"]),
    ]
)
