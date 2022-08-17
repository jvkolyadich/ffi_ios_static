# The Flutter tooling requires that developers have CMake 3.10 or later
# installed. You should not increase this version, as doing so will cause
# the plugin to fail to compile for some customers of the plugin.
cmake_minimum_required(VERSION 3.10 FATAL_ERROR)

project(ffi_ios_static_library VERSION 0.0.1 LANGUAGES C)

add_library(ffi_ios_static STATIC ffi_ios_static.c)

set_target_properties(ffi_ios_static PROPERTIES
  PUBLIC_HEADER ffi_ios_static.h
  OUTPUT_NAME "ffi_ios_static"
  XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY "${CODE_SIGN_IDENTITY}"
)
