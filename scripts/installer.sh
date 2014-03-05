#!/bin/bash

# Dragons...

SOURCE_DIR=$(readlink -f ""$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"/..")
FILES=$SOURCE_DIR/*
INSTALL_DIR=$1

CPFLAGS=-sRT

while getopts ":f:" opt; do
    case $opt in
	f)
	    echo "Forcing symlinks...";
	    CPFLAGS=-sRf
	    ;;
	\?)
	    echo "Invalid option: -$OPTARG"
	    ;;
    esac
done

if [ $# -ne 1 ]; then
    echo 'Invalid arguments.'
fi

echo Installing files from $SOURCE_DIR into $INSTALL_DIR

for f in $FILES; do
    INSTALL_LOC="$INSTALL_DIR"/."$(basename $f)"
    if [ -f "$INSTALL_LOC" ] && [ ! "$f" -ef "$INSTALL_LOC" ] ; then
 	echo File "$INSTALL_DIR"/."$(basename $f)" already exists.
 	echo Saving existing file to "$INSTALL_DIR"/."$(basename $f)".old
 	mv "$INSTALL_LOC" "$INSTALL_LOC".old
    fi

    # If they aren't the same file (link check)
    if [ ! "$f" -ef "$INSTALL_LOC" ]; then
	cp $CPFLAGS "$f" "$INSTALL_LOC" 2> /dev/null #DANGER ZONE
    fi

    
done

