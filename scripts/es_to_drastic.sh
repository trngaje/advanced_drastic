#!/usr/bin/env bash
set -euo pipefail

ES_CFG="${1:-$HOME/.emulationstation/es_input.cfg}"
DRASTIC_CFG="${2:-$HOME/advanced_drastic/config/drastic.cfg}"
DEVICE_NAME="${3:-}"   # optional

# 플랫폼별로 다를 수 있어 환경변수로 조정 가능하게 둠
# button: raw id
# axis  : AXIS_BASE + id*2 + dir(neg=0,pos=1)
# hat   : HAT_BASE  + id*4 + dir(up=0,right=1,down=2,left=3)
AXIS_BASE="${AXIS_BASE:-256}"
HAT_BASE="${HAT_BASE:-512}"
DRASTIC_BASE="${DRASTIC_BASE:-1024}"

touch "${DRASTIC_CFG}"

set_control_a() {
    local index_key="$1"      # 예: CONTROL_INDEX_A
    local raw_value="$2"      # 예: 123 / 0x7B / 7B
    local cfg_file="$DRASTIC_CFG"

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

set_control_b() {
  local index_key="$1"
  local control_code="$2"
  local drastic_input="$((DRASTIC_BASE + control_code))"
  local new_line="controls_b[${index_key}] = ${drastic_input}"

  if grep -q "^controls_b\\[${index_key}\\][[:space:]]*=" "${DRASTIC_CFG}"; then
    sed -i "s|^controls_b\\[${index_key}\\][[:space:]]*=.*|${new_line}|" "${DRASTIC_CFG}"
  else
    printf '%s\n' "${new_line}" >> "${DRASTIC_CFG}"
  fi
}

# name(up/down/left/right/a/b/...)의 입력을 읽어 내부 control code로 변환
# 출력 형식: "<code>|<type>|id=<id>|value=<value>"
get_es_input_code() {
  local want_name="$1"

  awk -v want="${want_name}" -v dev="${DEVICE_NAME}" -v AXB="${AXIS_BASE}" -v HTB="${HAT_BASE}" '
    function attr(s, key,   r, v) {
      r = key "=\"[^\"]*\""
      if (match(s, r)) {
        v = substr(s, RSTART + length(key) + 2, RLENGTH - length(key) - 3)
        return v
      }
      return ""
    }

    function hat_dir(v) {
      # ES hat value: up=1 right=2 down=4 left=8
      if (v == "1") return 0
      if (v == "2") return 1
      if (v == "4") return 2
      if (v == "8") return 3
      return -1
    }

    function axis_dir(v) {
      # ES axis value: -1 / 1
      if (v == "-1") return 0
      if (v == "1")  return 1
      return -1
    }

    BEGIN { in_block=0; picked=0 }

    /<inputConfig[[:space:]]/ {
      if (dev != "") {
        dn = attr($0, "deviceName")
        in_block = (dn == dev)
      } else {
        if (picked == 0) { in_block=1; picked=1 } else { in_block=0 }
      }
    }

    in_block && /<input[[:space:]]/ {
      n = attr($0, "name")
      t = attr($0, "type")
      id = attr($0, "id")
      val = attr($0, "value")

      if (n != want || id == "") next

      # 1) 일반 버튼
      if (t == "button") {
        code = id + 0
        print code "|" t "|id=" id "|value=" val
        exit
      }

      # 2) 축 입력
      if (t == "axis") {
        d = axis_dir(val)
        if (d >= 0) {
          code = AXB + (id * 2) + d
          print code "|" t "|id=" id "|value=" val
          exit
        }
      }

      # 3) 햇 입력
      if (t == "hat") {
        d = hat_dir(val)
        if (d >= 0) {
          code = HTB + (id * 4) + d
          print code "|" t "|id=" id "|value=" val
          exit
        }
      }
    }
  ' "${ES_CFG}"
}

declare -A MAP=(
  [CONTROL_INDEX_UP]="up"
  [CONTROL_INDEX_DOWN]="down"
  [CONTROL_INDEX_LEFT]="left"
  [CONTROL_INDEX_RIGHT]="right"
  [CONTROL_INDEX_A]="a"
  [CONTROL_INDEX_B]="b"
  [CONTROL_INDEX_X]="x"
  [CONTROL_INDEX_Y]="y"
  [CONTROL_INDEX_L]="leftshoulder"
  [CONTROL_INDEX_R]="rightshoulder"
  [CONTROL_INDEX_START]="start"
  [CONTROL_INDEX_SELECT]="select"
  [CONTROL_INDEX_TOUCH_CURSOR_UP]="leftanalogup"
  [CONTROL_INDEX_TOUCH_CURSOR_DOWN]="leftanalogdown"
  [CONTROL_INDEX_TOUCH_CURSOR_LEFT]="leftanalogleft"
  [CONTROL_INDEX_TOUCH_CURSOR_RIGHT]="leftanalogright"
  [CONTROL_INDEX_TOUCH_CURSOR_PRESS]="rightthumb"
  [CONTROL_INDEX_SWAP_SCREENS]="righttrigger"
  [CONTROL_INDEX_MENU]="leftthumb"
  [CONTROL_INDEX_UI_UP]="up"
  [CONTROL_INDEX_UI_DOWN]="down"
  [CONTROL_INDEX_UI_LEFT]="left"
  [CONTROL_INDEX_UI_RIGHT]="right"
  [CONTROL_INDEX_UI_SELECT]="a"
  [CONTROL_INDEX_UI_BACK]="x"
  [CONTROL_INDEX_UI_EXIT]="b"
  [CONTROL_INDEX_UI_PAGE_UP]="leftshoulder"
  [CONTROL_INDEX_UI_PAGE_DOWN]="rightshoulder"
  [CONTROL_INDEX_UI_SWITCH]="y"
  [CONTROL_INDEX_HOT]="select"
  [CONTROL_INDEX_CHANGE_LAYOUT_DEC]="left"
  [CONTROL_INDEX_CHANGE_LAYOUT_INC]="right"
  [CONTROL_INDEX_TOGGLE_DPAD_MOUSE]="lefttrigger"
  [CONTROL_INDEX_HOT_TOGGLE_BLUR_PIXEL]="b"
  [CONTROL_INDEX_HOT_CHANGE_THEME]="y"
  [CONTROL_INDEX_HOT_ENTER_MENU]="x"
  [CONTROL_INDEX_HOT_SAVE_STATE]="rightshoulder"
  [CONTROL_INDEX_HOT_LOAD_STATE]="leftshoulder"
  [CONTROL_INDEX_HOT_QUIT]="start"
)

for idx in "${!MAP[@]}"; do
  es_name="${MAP[$idx]}"
  line="$(get_es_input_code "${es_name}" || true)"

  if [[ -z "${line}" ]]; then
    echo "WARN  ${idx} <= ${es_name} : not found"
    continue
  fi

  code="${line%%|*}"
  meta="${line#*|}"
  set_control_b "${idx}" "${code}"
  echo "OK    ${idx} <= ${es_name} -> code=${code} (${meta})"
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


    
