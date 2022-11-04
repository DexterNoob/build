#!/bin/bash

dtc="$(pwd)/DragonTC"
gcc64="$(pwd)/gcc64"
gcc="$(pwd)/gcc"

if [ ! -d $dtc ]; then
    git clone --depth=1 https://github.com/TeraaBytee/DragonTC $dtc
fi
if [ ! -d $gcc64 ]; then
    git clone --depth=1 https://github.com/TeraaBytee/aarch64-linux-android-4.9 $gcc64
fi
if [ ! -d $gcc ]; then
    git clone --depth=1 https://github.com/TeraaBytee/arm-linux-androideabi-4.9 $gcc
fi
