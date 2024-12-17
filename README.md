### advanced_drastic

This project was launched to overcome the limitations of screen output and input fixed as base with the drastic-steward 32-bit source developed for miyoomini by steward-fu.

For normal operation, you must use the drastic file below.<br>
md5sum:59a7711eff41c640b8861b4d869c747d  drastic<br>

- The parts that differ from drastic-steward are as follows.

1. Hooked based on 64 bit drastic.
2. You can still use the drastic default input settings menu (keyboard/mouse/vibration support)
3. Configure the settings screen and layout screen based on the detected resolution.
4. You can configure a separate layout.json file to change the background image to define it.
5. Supports writing .sav files.

Supports all devices that support mali, gles and egl environments.

- The devices that have been verified for operation are as follows.<br>
h700 : rgxxxx, rgcubexx <br>
a133 : tsp, trimui brick <br>

Checked normal operation in various os. (knulli / muos / crossmix)

test files for crossmix, trimui smart pro <br>
- step1.back up /mnt/SDCARD/Emus/NDS folder
- step2.download a below file
[https://github.com/trngaje/tsp_binary/releases/download/test/NDS.tar.gz](https://github.com/trngaje/tsp_binary/releases/download/test/NDS.tar.gz)
- step3.unzip the file in device

>Key settings

key | assign
---------------|--------
l2 | toggle stylus / dpad
r2 | swap screen0/1
menu | call setting menu
select | hot key
select + left | dec index of layout
select + right | inc index of layout
select + y | change themes
select + b | toggle blur / pixel mode
select + start | display steward custom settings
select + l | quick load
select + r | quick save


> Configure folders
~~~
├── libs (external)
├── config
│   ├── drastic.cf2
│   └── drastic.cfg
├── devices
│   ├── rg28xx
│   │   ├── config
│   │   │   ├── drastic.cf2
│   │   │   └── drastic.cfg
│   │   └── resources
│   │       └── settings.json
│   ├── rg35xx-sp
│   │   ├── config
│   │   │   ├── drastic.cf2
│   │   │   └── drastic.cfg
│   │   └── resources
│   │       └── settings.json
│   ├── trimui-brick
│   │   └── config
│   │       ├── drastic.cf2
│   │       └── drastic.cfg
│   └── trimui-smart-pro
│       └── config
│           ├── drastic.cf2
│           └── drastic.cfg
├── drastic
├── launch.sh
├── microphone
│   └── microphone.wav
├── resources
│   ├── bg (external)
│   ├── font
│   ├── lang
│   ├── menu
│   ├── pen
│   └── settings.json
├── system
│   ├── drastic_bios_arm7.bin
│   ├── drastic_bios_arm9.bin
│   ├── nds_bios_arm7.bin
│   ├── nds_bios_arm9.bin
│   └── nds_firmware.bin
└── usrcheat.dat
~~~

The layout resources are managed in the following path.<br>
[https://github.com/trngaje/drastic_layout](https://github.com/trngaje/drastic_layout)

Direct support for devices or sponsorship for purchasing new devices is always welcome.
[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/G2G5DV6J4)
