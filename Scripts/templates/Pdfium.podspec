Pod::Spec.new do |s|  
s.name              = 'Pdfium'
s.version           = 'X.Y.Z'
s.summary           = 'Pdfium Framework'
s.homepage          = 'https://facekom.net'

s.author            = { 'Name' => 'info@techteamer.com' }
s.license           = { :type => 'MIT', :file => 'LICENSE' }

s.source            = { :git => 'SOURCE_URL', :tag => s.version.to_s }

s.swift_version = '5.2'
s.platforms = { :ios => "11.0", :osx => "10.5" }
s.pod_target_xcconfig = { "SWIFT_VERSION" => "5.2" }

s.info_plist = {
    'CFBundleIdentifier' => 'com.facekom.Pdfium'
  }

s.vendored_frameworks = 'Pdfium.xcframework'
end  
