#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint ffi_ios_static.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'ffi_ios_static'
  s.version          = '0.0.1'
  s.summary          = 'Test project to use a static library for iOS in dart'
  s.description      = <<-DESC
Test project to use a static library for iOS in dart
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }

  # This will ensure the source files in Classes/ are included in the native
  # builds of apps using this FFI plugin. Podspec does not support relative
  # paths, so Classes contains a forwarder C file that relatively imports
  # `../src/*` so that the C sources can be shared among all target platforms.
  s.source           = { :path => '.' }
  # s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '9.0'

  s.public_header_files = 'Classes/**/*.h'
  s.static_framework = true

  # s.vendored_libraries = 'Frameworks/ffi_ios_static.xcframework/ios-arm64_armv7/libffi_ios_static.a'
  # s.vendored_libraries = 'Frameworks/ffi_ios_static.xcframework/ios-arm64_x86_64-simulator/libffi_ios_static.a'
  
  s.vendored_frameworks = 'Frameworks/ffi_ios_static.xcframework'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = {
    'DEFINES_MODULE' => 'YES',
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386',
    'OTHER_LDFLAGS[sdk=iphoneos*]' => '-force_load $(PODS_TARGET_SRCROOT)/Frameworks/ffi_ios_static.xcframework/ios-arm64_armv7/libffi_ios_static.a',
    'OTHER_LDFLAGS[sdk=iphonesimulator*]' => '-force_load $(PODS_TARGET_SRCROOT)/Frameworks/ffi_ios_static.xcframework/ios-arm64_x86_64-simulator/libffi_ios_static.a'
  }
  s.swift_version = '5.0'
end
