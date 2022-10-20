// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Pdfium",
    platforms: [ .iOS(.v11) ],
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
            url: "https://github.com/TechTeamer/ios-xc-pdfium/raw/master/Pdfium/1.0.0/Pdfium.xcframework.zip",
            checksum: "619e573b9bf604633db46ff7857c4540cf545ab3ec1b622184c3e5d556c4b24f")
    ]
)
