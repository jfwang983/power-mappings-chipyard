#!/bin/bash

ctrl_c() {
     exit 1
}

trap ctrl_c INT

filename="custom.mk"
default_binary=$(grep -m 1 BINARY $filename | sed 's/^.*= //g')

if [ $# -eq 0 ]; then
    echo "not enough args"
    exit 1
else
    binary=$1
    echo "default binary: $default_binary"
    echo "binary: $binary"
    if [ "$1" = "0" ]; then
        binary=$default_binary
    fi

    if [ $# -eq 1 ]; then
        echo "make sim-rtl-debug BINARY=$binary"
        make sim-rtl-debug BINARY=$binary
    elif [ $# -eq 2 ]; then
        if [ "$2" = "-r" ]; then
            echo "make redo-sim-rtl-debug BINARY=$binary"
            make redo-sim-rtl-debug BINARY=$binary
        elif [ "$2" = "-l" ]; then
            echo "make sim-rtl-debug BINARY=$binary LOADMEM=$binary"
            make sim-rtl-debug BINARY=$binary LOADMEM=$binary
        else
            echo "invalid flag"
            exit 1
        fi
    elif [ $# -eq 3 ]; then
        binary="$1"
        if [ "$2" = "-r" ] && [ "$3" = "-l" ]; then
            echo "make redo-sim-rtl-debug BINARY=$binary LOADMEM=$binary"
            make redo-sim-rtl-debug BINARY=$binary LOADMEM=$binary
        elif [ "$2" = "-l" ] && [ "$3" = "-r" ]; then
            echo "make redo-sim-rtl-debug BINARY=$binary LOADMEM=$binary"
            make redo-sim-rtl-debug BINARY=$binary LOADMEM=$binary
        else
            echo "invalid flags"
            exit 1
        fi
    else
        echo "fail"
        exit 1
    fi
fi