#!/bin/bash

external_controllers=$(cat ~/controller_state)

if [[ $external_controllers == 0 ]]; then
	~/arcade-configs/external-controller-symlink.sh 1
	echo 1 > ~/controller_state
	killall python # TODO: pids!
	wahcade &
else
	~/arcade-configs/external-controller-symlink.sh 0
	echo 0 > ~/controller_state
	killall python
	wahcade &
fi
