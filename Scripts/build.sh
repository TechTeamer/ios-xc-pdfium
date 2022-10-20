#!/bin/bash

#Use: build.sh <version>

#---- Setup -----
function setup {
    scriptPath="$( cd "$(dirname "$0")" ; pwd -P )"
    rootPath=$(echo $(dirname $scriptPath))
    workPath=$scriptPath/tmp
    buildPath=$workPath/builder
    #rm -rf $workPath
    #mkdir $workPath
    #cp $scriptPath/builder $workPath
    echo "RootPath: $rootPath"
    echo "ScriptPath: $scriptPath"
    echo "WorkPath: $workPath"
    echo "BuildPath: $buildPath"
    cd $workPath
}


#---- Clean -----
function clean {

    rm -rf $workPath
}

#---- Make builds -----
function buildPdfium {

    rm -rf $buildPath/build
    mkdir $buildPath/build

    cd $buildPath
    
    # Build Arm64 Device
    ./build.sh ios arm64
    cp $buildPath/staging/lib/libpdfium.dylib $buildPath/build/libpdfium-arm64.dylib
    
    # Build Arm64 Simulator
    ./build.sh iossimulator arm64
    cp $buildPath/staging/lib/libpdfium.dylib $buildPath/build/libpdfium-arm64-simulator.dylib
    
    # Build X64 Simulator
    ./build.sh iossimulator x64
    cp $buildPath/staging/lib/libpdfium.dylib $buildPath/build/libpdfium-x64-simulator.dylib
    
    # Copy headers
    cp $buildPath/staging/include/fpdfview.h $buildPath/build/fpdfview.h
}


#---- Merge simulator builds -----
function mergeSimulatorBuilds {
   
    lipo -create "$buildPath/build/libpdfium-x64-simulator.dylib" "$buildPath/build/libpdfium-arm64-simulator.dylib" -o "$buildPath/build/libpdfium-arm64_x64-simulator.dylib"
}

#---- Generate XCFramework -----
function makeXCFramework {
    
    rm -rf "$workPath/out"
    mkdir "$workPath/out"
    
    cp -r "$scriptPath/templates/Pdfium.xcframework" "$workPath/out/Pdfium.xcframework"
    
    cp "$buildPath/build/fpdfview.h" "$workPath/out/Pdfium.xcframework/ios-arm64/Pdfium.framework/Headers/fpdfview.h"
    cp "$buildPath/build/libpdfium-arm64.dylib" "$workPath/out/Pdfium.xcframework/ios-arm64/Pdfium.framework/Pdfium"
    otool -L "$workPath/out/Pdfium.xcframework/ios-arm64/Pdfium.framework/Pdfium"
    echo "Patching ios-arm64"
    install_name_tool -id @rpath/Pdfium.framework/Pdfium "$workPath/out/Pdfium.xcframework/ios-arm64/Pdfium.framework/Pdfium"
    otool -L "$workPath/out/Pdfium.xcframework/ios-arm64/Pdfium.framework/Pdfium"
    
    cp "$buildPath/build/fpdfview.h" "$workPath/out/Pdfium.xcframework/ios-arm64_x86_64-simulator/Pdfium.framework/Headers/fpdfview.h"
    cp "$buildPath/build/libpdfium-arm64_x64-simulator.dylib" "$workPath/out/Pdfium.xcframework/ios-arm64_x86_64-simulator/Pdfium.framework/Pdfium"
    otool -L "$workPath/out/Pdfium.xcframework/ios-arm64_x86_64-simulator/Pdfium.framework/Pdfium"
    echo "Patching ios-arm64_x64 simulator"
    install_name_tool -id @rpath/Pdfium.framework/Pdfium "$workPath/out/Pdfium.xcframework/ios-arm64_x86_64-simulator/Pdfium.framework/Pdfium"
    otool -L "$workPath/out/Pdfium.xcframework/ios-arm64_x86_64-simulator/Pdfium.framework/Pdfium"
}

function run {
    setup
    buildPdfium
    mergeSimulatorBuilds
    makeXCFramework
}

if [[ $# -eq 0 ]] ; then
    echo 'Missing version, call it with param like: build.sh 1.0.0'
else
    version=$1
    run
fi
