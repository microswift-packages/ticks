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
        .package(url: "https://github.com/microswift-packages/ticks", from: "1.0.0"),
        .package(url: "https://github.com/microswift-packages/serial", from: "1.0.0"),
        .package(url: "https://github.com/microswift-packages/ATmega328P", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "ticks",
            dependencies: [],
            path: ".",
            sources: ["main.swift"]),
    ]
)
