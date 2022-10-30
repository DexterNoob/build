#!/bin/bash

dexter="$(pwd)/dexter"

if [ ! -d $dexter ]; then
    wget "$(curl -s https://raw.githubusercontent.com/noobbeast/dexter-clang/main/16.0.0/link.txt)" -O "DexterNoob-Clang-16.0.0-20221029.tar.gz"
    mkdir dexter && tar -xf DexterNoob-Clang-16.0.0-20221029.tar.gz -C dexter && rm -rf DexterNoob-Clang-16.0.0-20221029.tar.gz link.txt 
fi
