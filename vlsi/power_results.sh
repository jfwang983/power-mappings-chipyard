#!/bin/bash
filename="custom.mk"
binary=$(grep -m 1 BINARY $filename | sed 's/^.*= //g')

if [ $# -eq 0 ]; then
    echo "make sim-rtl-debug"
    make sim-rtl-debug
elif [ $# -eq 1 ]; then
    if [ "$1" = "-r" ]; then
        echo "make redo-sim-rtl-debug"
        make redo-sim-rtl-debug
    elif [ "$1" = "-l" ]; then
        echo "make sim-rtl-debug LOADMEM=$binary"
        make sim-rtl-debug LOADMEM=$binary
    else
        echo "invalid flag"
        exit 1
    fi
elif [ $# -eq 2 ]; then
    if [ "$1" = "-r" ] && [ "$2" = "-l" ]; then
        echo "make redo-sim-rtl-debug LOADMEM=$binary"
        make redo-sim-rtl-debug LOADMEM=$binary
    elif [ "$1" = "-l" ] && [ "$2" = "-r" ]; then
        echo "make redo-sim-rtl-debug LOADMEM=$binary"
        make redo-sim-rtl-debug LOADMEM=$binary
    else
        echo "invalid flags"
        exit 1
    fi
else
    echo "fail"
    exit 1
fi