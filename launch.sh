#!/bin/sh

mydir=`dirname "$0"`

export LD_LIBRARY_PATH=$mydir/libs:$LD_LIBRARY_PATH

cd $mydir

CURRENT_DIR=`pwd`

unset LD_PRELOAD
export LD_PRELOAD=$CURRENT_DIR/libs/libadvdrastic.so

./drastic_v2522 "$1"

