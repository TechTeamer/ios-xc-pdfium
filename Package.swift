// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Pdfium",
    platforms: [ .iOS(.v14) ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Pdfium",
            targets: ["Pdfium"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        
        .binaryTarget(
            name: "Pdfium",
            url: "https://github.com/TechTeamer/ios-xc-pdfium/raw/1.2.0/Pdfium/Pdfium.xcframework.zip",
            checksum: "f50d58eb4a1a6fcab189292c51a19ac8c1eaec66cb63c7c02ded90baeedc33e5")
    ]
)
