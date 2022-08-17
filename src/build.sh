if [ $# -ne 1 ]; then
  echo "usage: ./build_lib.sh <CODE_SIGN_IDENTITY>"
  exit 1
fi

lib_name="ffi_ios_static"

/Applications/CMake.app/Contents/bin/cmake -B "$lib_name/out/ios_arm/" -GXcode -DCMAKE_SYSTEM_NAME=iOS -DCMAKE_OSX_DEPLOYMENT_TARGET=10.0 -DCMAKE_INSTALL_PREFIX=`pwd`/_install -DCMAKE_XCODE_ATTRIBUTE_ONLY_ACTIVE_ARCH=NO -DCMAKE_IOS_INSTALL_COMBINED=YES -DCMAKE_OSX_ARCHITECTURES=armv7 -DCODE_SIGN_IDENTITY="$1"
/Applications/CMake.app/Contents/bin/cmake -B "$lib_name/out/ios_arm64/" -GXcode -DCMAKE_SYSTEM_NAME=iOS -DCMAKE_OSX_DEPLOYMENT_TARGET=10.0 -DCMAKE_INSTALL_PREFIX=`pwd`/_install -DCMAKE_XCODE_ATTRIBUTE_ONLY_ACTIVE_ARCH=NO -DCMAKE_IOS_INSTALL_COMBINED=YES -DCMAKE_OSX_ARCHITECTURES=arm64 -DCODE_SIGN_IDENTITY="$1"
/Applications/CMake.app/Contents/bin/cmake -B "$lib_name/out/iossimulator_arm64/" -GXcode -DCMAKE_SYSTEM_NAME=iOS -DCMAKE_OSX_DEPLOYMENT_TARGET=10.0 -DCMAKE_INSTALL_PREFIX=`pwd`/_install -DCMAKE_XCODE_ATTRIBUTE_ONLY_ACTIVE_ARCH=NO -DCMAKE_IOS_INSTALL_COMBINED=YES -DCMAKE_OSX_ARCHITECTURES=arm64
/Applications/CMake.app/Contents/bin/cmake -B "$lib_name/out/iossimulator_x64/" -GXcode -DCMAKE_SYSTEM_NAME=iOS -DCMAKE_OSX_DEPLOYMENT_TARGET=10.0 -DCMAKE_INSTALL_PREFIX=`pwd`/_install -DCMAKE_XCODE_ATTRIBUTE_ONLY_ACTIVE_ARCH=NO -DCMAKE_IOS_INSTALL_COMBINED=YES -DCMAKE_OSX_ARCHITECTURES=x86_64

/Applications/CMake.app/Contents/bin/cmake --build "$lib_name/out/ios_arm/" --target "$lib_name" -- -sdk iphoneos
/Applications/CMake.app/Contents/bin/cmake --build "$lib_name/out/ios_arm64/" --target "$lib_name" -- -sdk iphoneos
/Applications/CMake.app/Contents/bin/cmake --build "$lib_name/out/iossimulator_arm64/" --target "$lib_name" -- -sdk iphonesimulator
/Applications/CMake.app/Contents/bin/cmake --build "$lib_name/out/iossimulator_x64/" --target "$lib_name" -- -sdk iphonesimulator

mkdir -p "$lib_name/out/iosiphoneos"
mkdir -p "$lib_name/out/iosiphonesimulator"

lipo -create "$lib_name/out/ios_arm/Debug-iphoneos/lib$lib_name.a" "$lib_name/out/ios_arm64/Debug-iphoneos/lib$lib_name.a" -output "$lib_name/out/iosiphoneos/lib$lib_name.a"
lipo -create "$lib_name/out/iossimulator_arm64/Debug-iphonesimulator/lib$lib_name.a" "$lib_name/out/iossimulator_x64/Debug-iphonesimulator/lib$lib_name.a" -output "$lib_name/out/iosiphonesimulator/lib$lib_name.a"

xcodebuild -create-xcframework -library "$lib_name/out/iosiphoneos/lib$lib_name.a" -library "$lib_name/out/iosiphonesimulator/lib$lib_name.a" -output "../ios/Frameworks/$lib_name.xcframework"
