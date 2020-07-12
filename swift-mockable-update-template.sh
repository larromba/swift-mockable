#!/bin/bash

if [ "$#" -ne 1 ]; then
    NAME=$(basename "$0" .sh)
    echo "usage: sh $NAME PATH_TO_TEMPLATE_FILE"
    exit
fi

read -n 1 -p "download stencil to: $1? y/n"$'\n' INPUT
if [ "$INPUT" = "y" ]; then
    echo ""
    
    TMP_DIR=/tmp/swift-mockable
    if [ -d "$TMP_DIR" ]; then
        rm -rf "$TMP_DIR"
    fi
    
    git clone https://github.com/larromba/swift-mockable /tmp/swift-mockable
    mv /tmp/swift-mockable/mocks.stencil "$1"

    if [ -d "$1" ]; then
        echo "updated mocks.stencil at $1"
    else
        echo "updated stencil at $1"
    fi
fi
