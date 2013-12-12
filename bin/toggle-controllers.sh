#!/bin/bash

external_controllers=$(cat ~/controller_state)

if [[ $external_controllers == 0 ]]; then
	echo external controllers off
	echo 1 > ~/controller_state
else
	echo external controllers on
	echo 0 > ~/controller_state
fi
