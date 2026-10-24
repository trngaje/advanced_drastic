### Installation Guide

#### general script
common basic script to run drastic : launch.sh <br>
need to use LD_PRELOAD instead of libSDL2* to hook drastic functions
~~~
#!/bin/sh

mydir=`dirname "$0"`

export LD_LIBRARY_PATH=$mydir/libs:$LD_LIBRARY_PATH

cd $mydir

CURRENT_DIR=`pwd`

unset LD_PRELOAD
export LD_PRELOAD=$CURRENT_DIR/libs/libadvdrastic.so

./drastic "$1"
~~~

#### for muos
in muos <br>
/opt/muos/share/emulator/drastic-trngaje/libs/rg/
/opt/muos/share/emulator/drastic-trngaje/libs/tui/

need `libadvdrastic.so` only, remove `libSDL2-2.0.so.0` file
[/opt/muos/share/emulator/drastic-trngaje/libs/rg]# ls
libSDL2-2.0.so.0.org  libadvdrastic.so      libjson-c.so.5

launch.sh in muos
~~~
#!/bin/sh

. /opt/muos/script/var/func.sh

DRASTIC_DIR=$(dirname "$0")
DRASTIC_LIB="$DRASTIC_DIR/libs"

case "$(GET_VAR "device" "board/name")" in
        rg*) DRASTIC_LIB="${DRASTIC_LIB}/rg" ;;
        tui*) DRASTIC_LIB="${DRASTIC_LIB}/tui" ;;
esac

export LD_LIBRARY_PATH=$DRASTIC_LIB:$LD_LIBRARY_PATH


cd "$DRASTIC_DIR" || exit 1

LD_PRELOAD=${DRASTIC_LIB}/libadvdrastic.so  ./drastic_v2522 "$1"

U_DATA="/userdata"
[ -d "$U_DATA" ] && rm -rf "$U_DATA"
~~~

#### for spruce os

spruce os : tsp / trmui brick, tsps

The location of the library is as below. Replace with the distribution library.
`/mnt/SDCARD/Emu/NDS/lib64_A133P_trngaje/libadvdrastic.so`

The script for running is as follows.
`/mnt/SDCARD/spruce/scripts/emu/lib/drastic_functions.sh`

~~~
LD_PRELOAD=$EMU_DIR/libs/libadvdrastic.so  $EMU_DIR/drastic "$*"


run_drastic_trngaje_a133p() {
        ready_arch_64_states
        export LD_LIBRARY_PATH="$HOME/lib64_A133P_trngaje:$LD_LIBRARY_PATH:$HOME/lib64"
        [ ! -e ./drastic ] && cp ./drastic64 ./drastic
        LD_PRELOAD=$HOME/lib64_A133P_trngaje/libadvdrastic.so ./drastic "$ROM_FILE" > ${LOG_DIR}/${CORE}-${PLATFORM}.log 2>&1
        stash_arch_64_states
}
~~~

#### for crossmix
The information below is old information. It will be updated further.

test files for crossmix, trimui smart pro <br>
- step1.back up /mnt/SDCARD/Emus/NDS folder
- step2.download a below file
~~[https://github.com/trngaje/tsp_binary/releases/download/test/NDS.tar.gz](https://github.com/trngaje/tsp_binary/releases/download/test/NDS.tar.gz)~~
- step3.unzip the file in device

#### for knulli
Description based on the official version(gladiator-ii-20250813). <br>
##### To modify temporarily <br>
- step1. Run "nds rom" once to create "/userdata/system/configs/advanced_drastic/". <br>
- step2. Remove libSDL2-2.0.so.0 in /userdata/system/configs/advanced_drastic/libs. <br>
- step3. Copy libadvdrastic.so to /userdata/system/configs/advanced_drastic/libs/ <br>
- step4. replace launch.sh with general script (launch.sh) <br>

The key placement defined in the official version is different from what I have guided. Modify it as necessary. <br>

##### To modify permanently <br>
- step1. remove the folder()/userdata/system/configs/advanced_drastic/).
- step2. modify all in /usr/share/advanced_drastic/

##### Additional Information
ssh : root/linux <br>
hostname :KNULLI

#### for rocknix
Identified Devices : rg ds<br>

Run script to install from the officially released os.

##### to install advdrastic
step1. Copy "install_for_darkos_rocknix.sh" to the "/storage/roms/ports/" folder.<br>
~~~
cd ~/roms/ports

wget https://github.com/trngaje/advanced_drastic/raw/refs/heads/master/scripts/install_for_darkos_rocknix.sh

wget https://github.com/trngaje/advanced_drastic/raw/refs/heads/master/scripts/uninstall_for_darkos_rocknix.sh

wget https://github.com/trngaje/advanced_drastic/raw/refs/heads/master/scripts/drastic_assign_inputs.sh

wget https://github.com/trngaje/advanced_drastic/raw/refs/heads/master/scripts/rocknix_control.sh

chmod a+x *.sh
~~~
step2. update gamelists in es <br>
step3. run it. <br>

- After execution, a "drastic.tar.gz" backup file is created in the "/storage/.config/" folder and can be restored to the previous state at any time.<br>

##### to setup default input
There are three ways.<br>
Method 1. Set the default value using the input environment variable value used by rocknix. <br>
- Copy "rocknix_control.sh" to the "/storage/roms/ports/" folder and run it.<br>

Method 2. Enter the buttons sequentially. <br>
- Copy "drastic_assign_inputs.sh" to the ""/storage/roms/ports" folder and run it. Enter the key according to the instructions displayed on the screen.<br>

Method 3. Set default input with a value of es_input.cfg.<br>

step3. Run the game.<br>

##### To remove the installed "advdrastic"
Copy "uninstall_for_darkos_rocknix.sh" to the "/storage/roms/ports/" folder and run it.

##### Additional Information
ssh : root/rocknix <br>
Installation Path : /storage/.config/drastic <br>

#### for stockos (miyoo flip)

#### for stockos (trimui smart pro s)

1. unzip advanced_drastic.tar.gz in /mnt/sdcard/mmcblk1p1/Emus/NDS/
2. edit scripts

edit config.json
~~~
{
    "label":"NDS",
    "icontop":"../_theme/ic-nds.png",
    "icon":"",
    "background":"../_theme/bg-nds.png",
    "launch":"launch_advdrastic.sh",
    "themecolor":"FF8800",
    "iconsel":"",
    "rompath":"../../Roms/NDS",
    "imgpath":"../../Imgs/NDS",
    "useswap":0,
    "shortname":0,
    "hidebios":0,
    "launchlist": [
        {
            "name": "Drastic",
            "launch": "launch_advdrastic.sh"
        }
    ]
}
~~~

create launch_advdrastic.sh
~~~
#!/bin/sh
echo $0 $*

progdir=`dirname "$0"`/advanced_drastic

cd $progdir
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$progdir/libs

../cpufreq.sh
../cpuswitch.sh

echo 1 > /sys/class/drm/card0-DSI-1/rotate
echo 1 > /sys/class/drm/card0-DSI-1/force_rotate

CURRENT_DIR=`pwd`

unset LD_PRELOAD
export LD_PRELOAD=$CURRENT_DIR/libs/libadvdrastic.so

export HOME=/mnt/SDCARD
./drastic_v2522 "$1"
~~~

3. libadvdrastic.so can be overwritten in the path below.
/mnt/sdcard/mmcblk1p1/Emus/NDS/advanced_drastic/libs/

#### for dArkos

Identified Devices : rgb30<br>

##### to install advdrastic
step1. Copy "install_for_darkos_rocknix.sh" to the "/roms/ports/" folder and run it.<br>
- After execution, a "drastic.tar.gz" backup file is created in the "/opt/" folder and can be restored to the previous state at any time.<br>

step2. Copy "drastic_assign_inputs.sh" to the ""/roms/ports" folder and run it. Enter the key according to the instructions displayed on the screen.<br>
step3. Run the game.<br>

##### To remove the installed "advdrastic"
Copy "uninstall_for_darkos_rocknix.sh" to the "/roms/ports/" folder and run it.

##### Additional Information
ssh : ark/ark <br>
Installation Path : /opt/drastic/ <br>
The contents of the "config" folder remain unchanged and use the "dArkos" default setting.<br>

#### from es_input.cfg to drastic.cfg
./es_to_drastic.sh "/etc/emulationstation/es_input.cfg" "/opt/drastic/config/drastic.cfg" "retrogame_joypad" <br>

es_input.cfg
~~~
<inputConfig type="joystick" deviceName="retrogame_joypad" deviceGUID="190000004b4800000111000000010000">
        <input name="a" type="button" id="1" value="1" />
        <input name="b" type="button" id="0" value="1" />
        <input name="down" type="button" id="14" value="1" />
        <input name="hotkeyenable" type="key" id="0" value="1" />
        <input name="left" type="button" id="15" value="1" />
        <input name="leftanalogdown" type="axis" id="1" value="1" />
        <input name="leftanalogleft" type="axis" id="0" value="-1" />
        <input name="leftanalogright" type="axis" id="0" value="1" />
        <input name="leftanalogup" type="axis" id="1" value="-1" />
        <input name="leftshoulder" type="button" id="4" value="1" />
        <input name="leftthumb" type="button" id="11" value="1" />
        <input name="lefttrigger" type="button" id="6" value="1" />
        <input name="right" type="button" id="16" value="1" />
        <input name="rightanalogdown" type="axis" id="3" value="1" />
        <input name="rightanalogleft" type="axis" id="2" value="-1" />
        <input name="rightanalogright" type="axis" id="2" value="1" />
        <input name="rightanalogup" type="axis" id="3" value="-1" />
        <input name="rightshoulder" type="button" id="5" value="1" />
        <input name="rightthumb" type="button" id="12" value="1" />
        <input name="righttrigger" type="button" id="7" value="1" />
        <input name="select" type="button" id="8" value="1" />
        <input name="start" type="button" id="9" value="1" />
        <input name="up" type="button" id="13" value="1" />
        <input name="x" type="button" id="2" value="1" />
        <input name="y" type="button" id="3" value="1" />
        <input name="pagedown" type="button" id="5" value="1" />
        <input name="pageup" type="button" id="4" value="1" />
        <input name="system_hk" type="button" id="10" value="1" />
~~~
