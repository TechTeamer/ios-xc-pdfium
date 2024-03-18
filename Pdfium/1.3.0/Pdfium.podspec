Pod::Spec.new do |s|  
s.name              = 'Pdfium'
s.version           = '1.3.0'
s.summary           = 'Pdfium Framework'
s.homepage          = 'https://facekom.net'

s.author            = { 'Name' => 'info@techteamer.com' }
s.license           = { :type => 'MIT', :file => 'LICENSE' }

s.source            = { :http => 'https://github.com/TechTeamer/ios-xc-pdfium/raw/1.3.0/Pdfium/Pdfium.xcframework.zip' }

s.swift_version = '5.5'
s.platforms = { :ios => "15.0" }
s.pod_target_xcconfig = { "SWIFT_VERSION" => "5.5" }

s.info_plist = {
    'CFBundleIdentifier' => 'com.facekom.Pdfium'
  }

s.vendored_frameworks = 'Pdfium.xcframework'
end  
