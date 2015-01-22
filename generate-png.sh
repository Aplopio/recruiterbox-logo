#!/bin/bash

BUILD_PATH='build'

get_color() {
    if [ "$#" -gt 0 ]
    then
        echo $1
    else
        echo 'blue'
    fi
}

print_usage() {
    echo ''
    echo -e "Usage: ./generate-png.sh [folder_name]"
    echo ''
    echo "folder_name is relative to `$BUILD_PATH` folder in current directory"
}

ensure_folder() {
    if [[ ! -d "$BUILD_PATH/$1" ]]
    then
        echo 'folder "$BUILD_PATH/$1" does not exist. Creating it.'
        mkdir "$BUILD_PATH/$1"
    fi
}

if [[ $1 == '-h' ]]
then
    print_usage
else
    sizes=(16 32 64 128 256 512 1024)
    color=`get_color $@`

    ensure_folder $color

    for size in "${sizes[@]}"
    do
        inkscape --export-area-drawing --export-png "$BUILD_PATH/$color/$size.png" -w $size src/rbox-logo.svg
    done
fi
