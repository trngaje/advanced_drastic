#!/bin/sh

if [ -d "/run/rocknix" ]; then
    echo "rocknix is detected"
    ROOT_DIR="$HOME/.config"
elif [ "$HOME" = "/home/ark" ]; then
    echo "darkos is detected"
    ROOT_DIR="/opt"
else
    echo "unknown os"

    exit 1
fi


BACKUP_FILE=$ROOT_DIR/drastic.tar.gz
DEST_DIR=$ROOT_DIR/drastic

if [ -f "$BACKUP_FILE" ]; then
    echo "$BACKUP_FILE exists."

    find $DEST_DIR -type l -delete
    rm -rf $DEST_DIR

    echo "$DEST_DIR was removed."
    tar -xvzf $BACKUP_FILE -C $ROOT_DIR
fi
