#!/bin/bash

mkdir -p build-x64
cd build-x64

cmake --version
cmake -DCONFIG_PACKAGE_MODE=ON -DWARNINGS_AS_ERRORS=true -DCMAKE_C_COMPILER=gcc -DCMAKE_CXX_COMPILER=g++ -DDCMAKE_EXPORT_COMPILE_COMMANDS=ON ..

make --version
make -j4 || make VERBOSE=1

# # makes configuration packages due to CONFIG_PACKAGE_MODE being set on above
# make package || make package VERBOSE=1
