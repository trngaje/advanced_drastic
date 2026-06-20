#### history

1. fix the error in which "Exit:save for this game" is selected even if "Exit without saving" is selected (11/27) <br>
2. fix the Issue that Fast forward hot key does not toggle off (11/29) <br>
3. Apply Log storage routine by c-logger(1/18) <br>
4. Add stylus cursor selection menu(2/8)<br>
5. Change setting of stylus pen type from settings.json to drastic.cfg(2/10)<br>
6. Change the name of the setting value predefined in drastic.cfg(2/15)<br>
    from CONTROL_INDEX_SWAP_ORIENTATION_A to CONTROL_INDEX_CHANGE_LAYOUT_PREV<br>
    from CONTROL_INDEX_SWAP_ORIENTATION_B to CONTROL_INDEX_CHANGE_LAYOUT_NEXT<br>
    from ADVANCE_CONTROL_INDEX_CHANGE_LAYOUT_DEC to ADVANCE_CONTROL_INDEX_HOT_CHANGE_LAYOUT_PREV<br>
    from ADVANCE_CONTROL_INDEX_CHANGE_LAYOUT_INC to ADVANCE_CONTROL_INDEX_HOT_CHANGE_LAYOUT_NEXT<br>
7. Add auto fire option menu (2/15)<br>
8. Add control1/2 display option of controller(2/18)<br>
9. Implement to distinguish whether to use wait or thread according to save state parameter(3/4)<br>
10. Add a routine (for zero40) that keeps the current vertical resolution layout folder if it exists instead of a routine that forces the verical resolution to horizontal resolution<br>
11. fix errors that kill when menu key is pressed and b key is pressed in Picross 3D(3/6) - Not all roms die under the same conditions<br>
12. modify touch action according to screen layout (3/8)<br>
13. modify the function to hook by LD_PRELOAD (3/8)<br>
14. fix to operate AD_menu_bios_warning function (3/27)<br>
15. fix to change current position according to g_advdrastic.strLoadFilePath value (3/30)<br>
16. fix error to show previous layout theme values normally (5/5)<br>
17. modify touch values to operate dynamically If QUIRK_DEVICE is "Anbernic RGDS"
:top screen(0~0.5, 0~0.5), bottom screen(0.5~1, 0~0.5) => (0~1, 0~1)<br>
18. If ctrl+c or kill, modify the data to be saved normally<br>
19. implement sharp bilinear shader (5/17)<br>
20. refactoringd the AD_platform_get_input function - analog stick processing routine (5/28)<br>
21. AD_cheat_menu : Correct of an error that is not displayed in DQ IX rom (5/29)<br>
22. Add to display the drastic version (v2522, v2520) (6/1)<br>
23. Add AD_platform_print_joycode function to display under a known NDS button name (6/2)<br>
24. Instead of ADVDRASTIC_V2522, according to iDrasticVersion, v2.5.2.2 and v2.5.2.0 are modified to operate dynamically (g_advdrastic.iDrasticVersion == 2522 conditions)  (6/9)<br>
25. Modify to operate normally even if you change the "drastic" name.<br>
26. fix issue in v2522:If the "thread 3d on" option is selected in the "Minna de Asobou" rom, the stylus cursor is displayed on the opposite side of the touch screen (issue that occurs in both 2.5.2.2, 2.5.2.0)<br>
27. fix the issue that requires 2 press of the screen swap button to change the screen in v2522 (6/13)
28. Add information(Gamecard title:/Game code) in logger (6/14)
29. fix the issue of terminating when press the L3/R3 button in v2520 (6/14)
30. fix the issue that do not show snapshots when you select "save_state" from the menu in v2522 (6/14)
31. fix the problem of terminating when entering the "About" menu in v2522 (6/14)
32. Implement so that the list of paths (theme/stylus pen) is sorted and displayed (6/14)
33. fix issue in v2520 : If the "thread 3d on" option is selected in the "Minna de Asobou" rom, the stylus cursor is displayed on the opposite side of the touch screen (issue that occurs in both 2.5.2.2 and 2.5.2.0) (6/14)
34. v2522:fix error displayed on screen1 black screen :  drastic.cfg: fix to change the "screen_orientation" value to 0 (dual screen) if it is 2 (single screen)
35. v2522:fix the issue of terminating when entering layout edit (6/16)
36. Fix issue where default setting((uiEnableautosavestate, uiSlotOfAutosavestate)) is stored incorrectly
37. v2522:remove logs in AD_initialize_system(6/19)
38. fix "settings.json" to set default color value if no color value exists (6/19)
39. remove unused items in settings.json (6/19)
40. v2522:Modify FPS display to display cumulatively (6/19)
41. fix issue that does not operate back key after entering about - Problem occurs when the menu hot key is assigned as b key (6/20)
42. update menu_About - current glibc version and supporters (6/20)
43. fix the issue that "Hotkey to save state does not work" (6/20)
44. v2522:fix the issue that "Hotkey for frame count does not work" (6/20)

---

###### Changed compared to patch-8

1. Fixed the problem of delay in screen display when returning to game screen after waiting 10 minutes on menu screen or waking up from sleep. (4/19), <br>
2. Add hdmi layout default mode (transparent / single / rotate) (4/24),<br>
3. Implemented to hold or toggle Fast forward button to adjust the speed (5/2),<br>
4. fixed the problem that the cursor moves even though the dpad releases(5/10)<br>
5. add watchdog to detect white or black screen at startup during 6sec (5/29)<br>
6. add "no-autoload-savestate" in run option to disable autoload (5/29)<br>
7. recalculate size of screen shot for save state in main menu<br>
8. fix problems that do not run on the drastic without rom (6/19)<br>
9. add AD_menu_assign_input (drastic --input-assign)<br>
10. add analog_deadzone option in drastic.cfg<br>
11. Add a menu for the assignment of input buttons.(7/6)<br>
12. fix the issue 'Switching wallpaper to "None" doesn't remove the background until Drastic is restarted'.(7/13)<br>
13. fix the issue '"Restart Game" doesn't close the menu automatically — you have to reopen the menu and quit manually.' (7/13)<br>
14. Add a new hotkey to toggle show_frame_counter. (7/18)<br>
15. rename "Menu Exit Menu" to "Menu Back" (7/19)<br>
16. rename "Menu Up Directory" to "Menu Unmap/Up Directory" (7/19)<br>
17. Improve Control Remapping screen: display controls in a table with thin lines (easier to read, especially for controls_b at the right). (7/20)<br>
18. If the menu and hot key are the same, if another key is pressed during press, fix not to call the menu even if it is released (7/21)<br>
19. Fix issues that stop when auto-save in certain games (7/24)<br>
20. Modify the username in "Configure Firmware" to display normally (7/26)<br>
21. Modify the Load state menu to display (No save) only if there is no saved slot (7/26)<br>
22. add 'loadfile_path' in drastic.cfg to adjust base path of loadfile. (9/3)<br>
23. fix to close the menu immediately regardless of the depth of the menu when the menu key is pressed (9/3)<br>
24. fix to display the current game screen in menus other than load state/save state in settings(8/8)<br>
25. fix the issue of "drastic" is terminated when returning to game screen from "Load new game" screen (8/11)<br>
26. implement a function to rotate left strick for stylus in vertical mode (8/12)<br>
27. apply overlay to shader<br>
28. fix to start watchdog after decompressing a file (8/30)<br>
29. Change menu order and group<br>
30. add a mode to edit Layout<br>
31. fix the issue the the menu button is pressed after calling the menu with hot key (11/4)<br>
32. fix to display savestate snapshot and timestamp (11/8)<br>
33. fix display error in firmware username (11/8)<br>

---
patch-8

1/30 <br>
- Replace 'system' with 'fopen' for rumble in crossmix os
- remove "Restore default controls" menu

1/29 <br>
- Modify to use libIMGegl.so in crossmix os

patch-7

1/20 <br>
- fix to save the index of high resolution mode

1/19 <br>
- fix the problem that do not automatically save/load
- Add wayland routine to build option

1/18 <br>
- Add version notation
- Modified to work rumble in crossmix os (not currently working in knulios)

1/13 <br>
- add ADVDRASTIC_SDL

1/10 <br>
- Remove routine to automatically copy bios in the system
