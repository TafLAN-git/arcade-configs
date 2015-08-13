#!/bin/bash

#external_controllers=$(cat ~/controller_state)

#if [[ $external_controllers == 0 ]]; then
if [[ $1 == 'xbox360' ]]; then
    # enable external controllers
	~/arcade-configs/external-controller-symlink.sh 1
	echo 1 > ~/controller_state
	killall -9 python2 retroarch dolphin-emu fceux mednafen pcsx gvbam dgen mupen64plus mame # TODO: pids! groups?
	DISPLAY=:0 wahcade &
else
    # enable arcade controllers
	~/arcade-configs/external-controller-symlink.sh 0
	echo 0 > ~/controller_state
	killall -9 python2 retroarch dolphin-emu fceux mednafen pcsx gvbam dgen mupen64plus mame # TODO: pids! groups?
	DISPLAY=:0 wahcade &
fi
