#!/bin/bash

if [ -d "/run/rocknix" ]; then
    echo "rocknix is detected"
    DRASTIC="$HOME/.config/drastic/drastic"
    OS_NAME="rocknix"
elif [ "$HOME" = "/home/ark" ]; then
    echo "darkos is detected"
    DRASTIC="/opt/drastic/drastic"
    OS_NAME="darkos"
elif [ $(hostname) = "KNULLI" ]; then
    echo "knulli is detected"
    DRASTIC="/userdata/system/configs/advanced_drastic/launch.sh"
    OS_NAME="knulli"
else
    echo "unknown os"

    exit 1
fi

$DRASTIC --input-assign
