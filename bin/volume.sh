#!/bin/bash

if [[ $1 == "u" ]]; then
	echo volume up
	amixer set Master 2dB+
elif [[ $1 == "d" ]]; then
	echo volume down
	amixer set Master 2dB-
fi

ogg123 /usr/share/sounds/freedesktop/stereo/audio-volume-change.oga

