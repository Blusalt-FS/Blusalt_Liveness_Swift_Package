// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "BlusaltLivenessPackage",
  platforms: [
    .iOS(.v13)
  ],
  products: [
    // Products define the executables and libraries a package produces, making them visible to other packages.
    .library(
      name: "BlusaltLivenessPackage",
      targets: ["BlusaltLivenessPackage"])
  ],
  dependencies: [
    // Add your package dependencies here
  ],
  targets: [
    .binaryTarget(
      name: "BlusaltLivenessOnly",  // Name your binary target
      path: "./Sources/BlusaltLivenessOnly.xcframework"  // Path to your XCFramework
    ),
  ]
)
