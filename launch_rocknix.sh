#!/bin/sh

mydir=`dirname "$0"`

FLAG_READY="/tmp/drastic.ready"

if [ "$QUIRK_DEVICE" = "Anbernic RG DS" ]; then
    if [ ! -e "$FLAG_READY" ]; then
	touch $FLAG_READY
 	echo 'for_window [app_id="drastic"] output DSI-2 pos 0 0, output DSI-1 power on pos 0 480' >> /storage/.config/sway/config 
 	echo 'for_window [app_id="drastic"] floating enable, border none, fullscreen disable, resize set 640 960, move to output DSI-2, move absolute position 0 0' >> /storage/.config/sway/config 

	swaymsg reload
    fi
fi

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
 




