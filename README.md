arcade-configs
==============

This repo contains arcade-cabinet friendly config files for various emulators,
various useful scripts, plus a config and custom theme for an arcade-cabinet
frontend Wahcade.

Installing
----------

1. Clone the repo
2. Run ./symlink.sh (This script will place symbolic links inside your home
   folder pointing to the configuration files in this repo)
3. Place your games in ~/emulators/[console_name]/roms/ (configure paths via
   wahcade-setup)
4. Install (& configure any new) emulators that you want, on Ubuntu e.g:

```
sudo apt-get install dolphin-emu fceux zsnes pcsx vba vbam dgen mupen64plus mame
```

Misc notes
----------

There is a script for toggling between two sets of configuration files in
bin/toggle-controllers.sh. This script works by changing the default symbolic
links to point to the corresponding files inside of the
external-controller-configs/ directory. Any files that you wish to change when
the external controller configs are active can be put in this directory. (The
script just loops through these)

The controller toggle script also changes wahcade themes to indicate which
controller mode is active, and due to this it has to kill & restart the wahcade
process to refresh the theme. Since we've bound this script to a button on the
arcade machine, it meant that it was possible to restart wahcade while an
emulator was running, which then left the emulator running in the background
with no way to close it. So as a temporary fix, the script also kills any
emulators installed on the machine to make sure they aren't left running in the
background. (Read: do this in a better way or please add any new emulators to
the appropriate lines in the script also!).
