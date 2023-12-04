# Pdfium
![Platform](https://img.shields.io/badge/Platform-iOS-orange.svg)
![Apple Silicon compatible](https://img.shields.io/badge/Apple%20Silicon-compatible-green.svg)
![CocoaPods compatible](https://img.shields.io/badge/CocoaPods-compatible-green.svg)
![SPM compatible](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-green.svg)<br/>
![Catalyst compatible](https://img.shields.io/badge/Catalyst-incompatible-red.svg)


## Release

### 1.1.0
Build date: 2023-07-28 14:26

### 1.0.0
Build date: 2022-11-09 00:03


## Minimum runtime requirements
iOS 15+


## Installation
### Swift Package Manager
In your Xcode project go to: File -> Swift Packages -> Add Package Dependency<br/>
https://github.com/TechTeamer/ios-xc-pdfium.git


### Cocoapods
Just copy into your podfile, looks like this.<br/>

<br/>------------------------ Podfile ------------------------

source 'https://github.com/CocoaPods/Specs.git'<br/>
source 'https://github.com/TechTeamer/ios-xc-pdfium.git'

  use_frameworks!<br/>
  target 'YourApp' do<br/>
    pod 'Pdfium'<br/>
  end
  
<br/>---------------------------------------------------------

run:<br/>
pod repo update<br/>
pod install<br/>

## Description
This is a new generation xcframework is built for Apple machines including iOS/iPadOS/Simulators(arm64 & x86_64).

We are using the bblanchon's builder scripts for building, but we extended it with ios-simulator for arm64 and x86_64 resolved the simulator build issues. 

You can find the release commits here:
https://pdfium.googlesource.com/pdfium

You can find the official source here:
https://pdfium.googlesource.com/pdfium/+/refs/heads/main

