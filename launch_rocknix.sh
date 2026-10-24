#!/bin/sh

mydir=`dirname "$0"`

echo $mydir
export LD_LIBRARY_PATH=$mydir/libs:$LD_LIBRARY_PATH
echo $LD_LIBRARY_PATH

cd $mydir

CURRENT_DIR=`pwd`

unset LD_PRELOAD
export LD_PRELOAD=$CURRENT_DIR/libs/libadvdrastic.so

killall -9 gptokeyb

./drastic_v2522 "$1" 
#> /dev/pts/0 2>&1
 




