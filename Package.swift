// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "copy-symbol",
	platforms: [.macOS(.v10_11)],
    products: [
        .executable(name: "copy-symbol", targets: ["copy-symbol"])
    ],
    targets: [
        .target(name: "copy-symbol", dependencies: [])
    ]
)
