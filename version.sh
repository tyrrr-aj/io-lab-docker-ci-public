#!/bin/bash

if [ ! -f ./build-version.txt ]; then
    echo 0 > build-version.txt
fi

echo $(($(cat build-version.txt) + 1)) > build-version.txt

echo $(cat build-version.txt)

