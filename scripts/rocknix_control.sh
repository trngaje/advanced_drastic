#!/bin/bash

. /etc/profile
. /etc/os-release

set_kill set "-9 drastic"

#load gptokeyb support files
control-gen_init.sh
source /storage/.config/gptokeyb/control.ini
get_controls


echo $HW_DEVICE
echo $QUIRK_DEVICE


set_control_a() {
    local index_key="$1"      # 예: CONTROL_INDEX_A
    local raw_value="$2"      # 예: 123 / 0x7B / 7B
    local cfg_file="$HOME/advanced_drastic/config/drastic.cfg"

    local dec_value

    # 1) 10진수
    if [[ "$raw_value" =~ ^[0-9]+$ ]]; then
        dec_value="$raw_value"

    # 2) 0x 접두 16진수
    elif [[ "$raw_value" =~ ^0[xX][0-9a-fA-F]+$ ]]; then
        dec_value=$((raw_value))

    # 3) 접두 없는 16진수(예: 7B, FF)
    elif [[ "$raw_value" =~ ^[0-9a-fA-F]+$ ]]; then
        dec_value=$((16#$raw_value))

    else
        echo "ERROR: invalid value '$raw_value' (decimal or hex expected)"
        return 1
    fi

    local new_line="controls_a[${index_key}] = ${dec_value}"
    echo "${new_line}"

    if grep -q "^controls_a\\[${index_key}\\][[:space:]]*=" "$cfg_file"; then
        sed -i "s|^controls_a\\[${index_key}\\][[:space:]]*=.*|${new_line}|" "$cfg_file"
    else
        printf '%s\n' "${new_line}" >> "$cfg_file"
    fi
}

set_control_b()
{
    local key_idx="$1"
    local control_name="$2"
    local cfg_file="$HOME/.config/drastic/config/drastic.cfg"

    CONTROL_VALUE=${!control_name}
    DRASTIC_INPUT=$((1024 + CONTROL_VALUE))

    local new_line="controls_b[${key_idx}] = ${DRASTIC_INPUT}"
    echo "${new_line}"

    if grep -q "^controls_b\\[${key_idx}\\][[:space:]]*=" "$cfg_file"; then
        sed -i "s|^controls_b\\[${key_idx}\\][[:space:]]*=.*|${new_line}|" "$cfg_file"
    else
        printf '%s\n' "${new_line}" >> "$cfg_file"
    fi
}
### Set up controls
for CONTROL in DEVICE_BTN_SOUTH DEVICE_BTN_EAST DEVICE_BTN_NORTH         \
               DEVICE_BTN_WEST DEVICE_BTN_TL DEVICE_BTN_TR               \
               DEVICE_BTN_TL2 DEVICE_BTN_TR2 DEVICE_BTN_SELECT           \
               DEVICE_BTN_START DEVICE_BTN_MODE DEVICE_BTN_THUMBL        \
               DEVICE_BTN_THUMBR DEVICE_BTN_DPAD_UP DEVICE_BTN_DPAD_DOWN \
               DEVICE_BTN_DPAD_LEFT DEVICE_BTN_DPAD_RIGHT
do
    CONTROL_VALUE=${!CONTROL}
    DRASTIC_INPUT=$((1024 + CONTROL_VALUE))
    echo ${CONTROL}=${DRASTIC_INPUT}
    #sed -i "s~@${CONTROL}@~${!CONTROL}~g" ${GMUINPUT} 

done

set_control_a CONTROL_INDEX_UP 0x152
set_control_a CONTROL_INDEX_DOWN 0x151   
set_control_a CONTROL_INDEX_LEFT 0x150
set_control_a CONTROL_INDEX_RIGHT 0x14f
set_control_a CONTROL_INDEX_A 0x20
set_control_a CONTROL_INDEX_B 0x1e0
set_control_a CONTROL_INDEX_X 0x7a
set_control_a CONTROL_INDEX_Y 0x78
set_control_a CONTROL_INDEX_L 0x1e1
set_control_a CONTROL_INDEX_R 99
set_control_a CONTROL_INDEX_START 0xd
set_control_a CONTROL_INDEX_SELECT 0x1e5
set_control_a CONTROL_INDEX_HINGE 0x68
set_control_a CONTROL_INDEX_MENU 0x6d
set_control_a CONTROL_INDEX_SAVE_STATE 0x13e
set_control_a CONTROL_INDEX_LOAD_STATE 0x140
set_control_a CONTROL_INDEX_FAST_FORWARD 8
set_control_a CONTROL_INDEX_SWAP_SCREENS 0x73
set_control_a ADVANCE_CONTROL_INDEX_CHANGE_LAYOUT_PREV 0x61
set_control_a ADVANCE_CONTROL_INDEX_CHANGE_LAYOUT_NEXT 100
set_control_a CONTROL_INDEX_UI_UP 0x152
set_control_a CONTROL_INDEX_UI_DOWN 0x151
set_control_a CONTROL_INDEX_UI_LEFT 0x150
set_control_a CONTROL_INDEX_UI_RIGHT 0x14f
set_control_a CONTROL_INDEX_UI_SELECT 0xd
set_control_a CONTROL_INDEX_UI_BACK 0x1b
set_control_a CONTROL_INDEX_UI_EXIT 8
set_control_a CONTROL_INDEX_UI_PAGE_UP 0x14b
set_control_a CONTROL_INDEX_UI_PAGE_DOWN 0x14e
set_control_a CONTROL_INDEX_UI_SWITCH 0x1e1

set_control_b CONTROL_INDEX_UP DEVICE_BTN_DPAD_UP
set_control_b CONTROL_INDEX_DOWN DEVICE_BTN_DPAD_DOWN
set_control_b CONTROL_INDEX_LEFT DEVICE_BTN_DPAD_LEFT
set_control_b CONTROL_INDEX_RIGHT DEVICE_BTN_DPAD_RIGHT
set_control_b CONTROL_INDEX_A DEVICE_BTN_EAST
set_control_b CONTROL_INDEX_B DEVICE_BTN_SOUTH
set_control_b CONTROL_INDEX_X DEVICE_BTN_NORTH
set_control_b CONTROL_INDEX_Y DEVICE_BTN_WEST
set_control_b CONTROL_INDEX_L DEVICE_BTN_TL
set_control_b CONTROL_INDEX_R DEVICE_BTN_TR
set_control_b CONTROL_INDEX_START DEVICE_BTN_START
set_control_b CONTROL_INDEX_SELECT DEVICE_BTN_SELECT
set_control_b CONTROL_INDEX_TOUCH_CURSOR_PRESS DEVICE_BTN_THUMBR
set_control_b CONTROL_INDEX_MENU DEVICE_BTN_THUMBL 
set_control_b CONTROL_INDEX_SWAP_SCREENS DEVICE_BTN_TR2
set_control_b CONTROL_INDEX_UI_UP DEVICE_BTN_DPAD_UP
set_control_b CONTROL_INDEX_UI_DOWN DEVICE_BTN_DPAD_DOWN
set_control_b CONTROL_INDEX_UI_LEFT DEVICE_BTN_DPAD_LEFT
set_control_b CONTROL_INDEX_UI_RIGHT DEVICE_BTN_DPAD_RIGHT
set_control_b CONTROL_INDEX_UI_SELECT DEVICE_BTN_EAST
set_control_b CONTROL_INDEX_UI_BACK DEVICE_BTN_NORTH
set_control_b CONTROL_INDEX_UI_EXIT DEVICE_BTN_SOUTH
set_control_b CONTROL_INDEX_UI_PAGE_UP DEVICE_BTN_TL
set_control_b CONTROL_INDEX_UI_PAGE_DOWN DEVICE_BTN_TR
set_control_b CONTROL_INDEX_UI_SWITCH DEVICE_BTN_WEST
set_control_b CONTROL_INDEX_HOT DEVICE_BTN_SELECT
set_control_b CONTROL_INDEX_CHANGE_LAYOUT_DEC DEVICE_BTN_DPAD_LEFT
set_control_b CONTROL_INDEX_CHANGE_LAYOUT_INC DEVICE_BTN_DPAD_RIGHT
set_control_b CONTROL_INDEX_TOGGLE_DPAD_MOUSE DEVICE_BTN_TL2
set_control_b CONTROL_INDEX_HOT_TOGGLE_BLUR_PIXEL DEVICE_BTN_SOUTH
set_control_b CONTROL_INDEX_HOT_CHANGE_THEME DEVICE_BTN_WEST
set_control_b CONTROL_INDEX_HOT_ENTER_MENU DEVICE_BTN_NORTH
set_control_b CONTROL_INDEX_HOT_SAVE_STATE DEVICE_BTN_TR
set_control_b CONTROL_INDEX_HOT_LOAD_STATE DEVICE_BTN_TL
set_control_b CONTROL_INDEX_HOT_QUIT DEVICE_BTN_START





