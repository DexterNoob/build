#!/bin/bash

dexter="$(pwd)/dexter"

if [ ! -d $dexter ]; then
    wget "$(curl -s https://raw.githubusercontent.com/noobbeast/dexter-clang/main/16.0.0/link.txt)" -O "Dexter-Clang-16.0.0.tar.gz"
    mkdir dexter && tar -xf Dexter-Clang-16.0.0.tar.gz -C dexter && rm -rf Dexter-Clang-16.0.0.tar.gz link.txt 
fi
