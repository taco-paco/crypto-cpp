#!/bin/bash

set -e

# install npm packages.
(cd libs/crypto/ffi/js; npm install)

# Compile the code.
mkdir -p build/Release
(cd build/Release; cmake -DCMAKE_BUILD_TYPE=Release ../..)
make -C build/Release

# Run tests.
CTEST_OUTPUT_ON_FAILURE=1 make -C build/Release test

# Run go testing (we assume golang-go is installed).
go test build/Release/libs/crypto/ffi/crypto_lib_test.go

clang-tidy-6.0 -header-filter=libs -p=build/Release $(find libs -name "*.cc" | grep -v node_modules)
cpplint --extensions=cc,h $(find libs | grep -v node_modules | grep -E '\.(cc|h)$')
