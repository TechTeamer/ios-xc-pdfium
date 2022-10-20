#!/bin/bash

#Use: release.sh <version>
repo="https://github.com/TechTeamer/ios-xc-pdfium.git"

#---- Setup -----
function setup {
    scriptPath="$( cd "$(dirname "$0")" ; pwd -P )"
    rootPath=$(echo $(dirname $scriptPath))
    workPath=$scriptPath/tmp
    releasePath="${rootPath}/Pdfium/${version}"
    mkdir $workPath
    echo "RootPath: $rootPath"
    echo "ScriptPath: $scriptPath"
    echo "WorkPath: $workPath"
    cd $workPath
}

#---- Pull -----
function pull {
    cd $rootPath
    git pull
}

#---- Copy files -----
function copyFiles {
    rm -rf $releasePath
    mkdir $releasePath
    
    cd $workPath/out
    zip -r "Pdfium.xcframework.zip" "Pdfium.xcframework"
    mv Pdfium.xcframework.zip ${releasePath}
    
    releaseDate=$(date '+%Y-%m-%d %H:%M')
    releaseDescription="### $version\nBuild date: $releaseDate"
    sed -i "" "s/## Release/## Release\n\n$releaseDescription/" $rootPath/README.md
    
    sourceURL="https://github.com/TechTeamer/ios-xc-pdfium/raw/master/Pdfium/${version}/Pdfium.xcframework.zip"
    sourceChecksum=$(swift package compute-checksum "${releasePath}/Pdfium.xcframework.zip")
    sed "s|X.Y.Z|${version}|g; s|SOURCE_URL|${sourceURL}|g" <$scriptPath/templates/Pdfium.zip.podspec >$releasePath/Pdfium.podspec
    sed "s|SOURCE_CHECKSUM|${sourceChecksum}|g; s|SOURCE_URL|${sourceURL}|g" <$scriptPath/templates/Package.zip.swift >$rootPath/Package.swift
}

#---- Build -----
function build {
    $scriptPath/build.sh $version
}

#---- Clean -----
function clean {
    rm -rf $workPath
}

#---- Push the changes into the repository -----
function push {
    cd $rootPath
    
    #remove the last tag if exists
    tags="$(git tag --list)"

    if [ $(git tag -l "${version}") ]; then
        git tag -d ${version}
        git push --delete origin ${version}
    fi
    
    #add
    git add .
    
    #commit & push
    commitMSG="New release: v.${version}"
    commits="$(git reflog)"

    if [[ $commits == *"${commitMSG}"* ]]; then
        git tag ${version}
        git push --force origin master
    else
        if [ -n "$(git status --porcelain)" ]; then
            git commit -m "${commitMSG}"
        fi
    
        git tag ${version}
        git push origin master
    fi
    
    #push tags
    git push --tags origin
}

function run {

    setup
    pull
    build
    copyFiles
    clean
    push
}

if [[ $# -eq 0 ]] ; then
    echo 'Missing version, call it with param like: release.sh 1.0.0'
else
    version=$1
    run
fi
