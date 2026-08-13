#!/bin/bash

mydir=`dirname "$0"`


if [ -d "/run/rocknix" ]; then
    echo "rocknix is detected"
    ROOT_DIR="$HOME/.config"
    OS_NAME="rocknix"
elif [ "$HOME" = "/home/ark" ]; then
    echo "darkos is detected"
    ROOT_DIR="/opt"
    OS_NAME="darkos"
else
    echo "unknown os"

    exit 1
fi

#backup drastic folder
BACKUP_FILE=$ROOT_DIR/drastic.tar.gz
DEST_DIR=$ROOT_DIR/drastic
if [ ! -f "$BACKUP_FILE" ]; then
    echo "$BACKUP_FILE is not exists."

    cd $ROOT_DIR
    tar -cvzf $BACKUP_FILE drastic
fi


cd $mydir


#download from githhub

wget https://github.com/trngaje/advanced_drastic/archive/master.zip
unzip master.zip
mv advanced_drastic-master advanced_drastic
rm master.zip
wget https://github.com/trngaje/drastic_layout/archive/master.zip
unzip master.zip
pushd `pwd`
cd drastic_layout-master/
mv bg ../advanced_drastic/resources/
popd
rm -rf drastic_layout-master
rm master.zip

#Copy Remaining Files
cd advanced_drastic
cp -rv microphone/ resources/ drastic_v2522 drastic_v2520 $DEST_DIR/

mkdir -p $DEST_DIR/libs

if [ "$OS_NAME" = "darkos" ]; then
    cp -v libs/arkos/* $DEST_DIR/libs/
    cp launch.sh $DEST_DIR/drastic
    chmod a+x $DEST_DIR/drastic
elif [ "$OS_NAME" = "rocknix" ]; then
    cp -v libs/rocknix/* $DEST_DIR/libs/
    cp launch_rocknix.sh $DEST_DIR/drastic
    chmod a+x $DEST_DIR/drastic
fi

cd ..
rm -rf advanced_drastic

	
