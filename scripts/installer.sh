#!/bin/bash

SOURCE_DIR=""$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"/.."
FILES=$SOURCE_DIR/*
INSTALL_DIR=$1

if [ $# -ne 1 ]; then
    echo 'Invalid arguments.'
fi

echo Installing files from $SOURCE_DIR into $INSTALL_DIR


for f in $FILES; do
    cp -R "$f"  "$INSTALL_DIR"/."$(basename $f)"
done

