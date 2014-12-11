#!/bin/bash

external_controllers=$(cat ~/controller_state)

if [[ $external_controllers == 0 ]]; then
    # enable external controllers
	~/arcade-configs/external-controller-symlink.sh 1
	echo 1 > ~/controller_state
	killall -9 python2 dolphin-emu fceux mednafen pcsx vba vbam dgen mupen64plus mame # TODO: pids! groups?
	sleep 1
	wahcade &
else
    # disable external controllers
	~/arcade-configs/external-controller-symlink.sh 0
	echo 0 > ~/controller_state
	killall -9 python2 dolphin-emu fceux mednafen pcsx vba vbam dgen mupen64plus mame # TODO: pids! groups?
	sleep 1
	wahcade &
fi
