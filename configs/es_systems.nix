{ pkgs, writeText, ... }:

writeText "es_systems.cfg"
''
<systemList>
    <system>
        <name>nes</name>
        <fullname>Nintendo Entertainment System</fullname>
        <path>/roms/NES/roms</path>
        <extension>.nes</extension>
        <command>${pkgs.retroarch} --libretro ${pkgs.libretro.fceumm}/bin/retroarch-fceumm %ROM%</command>
        <platform>nes</platform>
        <theme>nes</theme>
    </system>
    <system>
        <name>arcade</name>
        <fullname>Arcade Games</fullname>
        <path>/roms/mame/roms</path>
        <extension>.zip</extension>
        <command>/usr/bin/retroarch-start --libretro ~/.config/retroarch/cores/mame_libretro.so %ROM%</command>
        <platform>arcade</platform>
        <theme>mame</theme>
    </system>
    <system>
        <name>genesis</name>
        <fullname>SEGA Genesis/MegaDrive</fullname>
        <path>/roms/Sega Mega Drive/roms</path>
        <extension>.zip</extension>
        <command>/usr/bin/retroarch-start --libretro ~/.config/retroarch/cores/genesis_plus_gx_libretro.so %ROM%</command>
        <platform>genesis</platform>
        <theme>genesis</theme>
    </system>
    <system>
        <name>gbc</name>
        <fullname>GameBoy Color</fullname>
        <path>/roms/Gameboy/roms</path>
        <extension>.gb</extension>
        <command>/usr/bin/retroarch-start --libretro ~/.config/retroarch/cores/gambatte_libretro.so %ROM%</command>
        <platform>gbc</platform>
        <theme>gbc</theme>
    </system>
    <system>
        <name>n64</name>
        <fullname>Nintendo 64</fullname>
        <path>/roms/Nintendo 64/roms</path>
        <extension>.v64 .z64</extension>
        <command>/usr/bin/retroarch-start --libretro ~/.config/retroarch/cores/mupen64plus_libretro.so %ROM%</command>
        <platform>n64</platform>
        <theme>n64</theme>
    </system>
    <system>
        <name>psx</name>
        <fullname>Playstation</fullname>
        <path>/roms/PSX/roms</path>
        <extension>.bin .img .mdf .iso</extension>
        <command>/usr/bin/retroarch-start --libretro ~/.config/retroarch/cores/pcsx_rearmed_libretro.so %ROM%</command>
        <platform>psx</platform>
        <theme>psx</theme>
    </system>
    <system>
        <name>gba</name>
        <fullname>GameBoy Advance</fullname>
        <path>/roms/Gameboy Advance/roms</path>
        <extension>.zip</extension>
        <command>/usr/bin/retroarch-start --libretro ~/.config/retroarch/cores/vba_next_libretro.so %ROM%</command>
        <platform>gba</platform>
        <theme>gba</theme>
    </system>
    <system>
        <name>snes</name>
        <fullname>Super Nintendo</fullname>
        <path>/roms/SNES/roms</path>
        <extension>.zip</extension>
        <command>/usr/bin/retroarch-start --libretro ~/.config/retroarch/cores/bsnes_balanced_libretro.so %ROM%</command>
        <platform>snes</platform>
        <theme>snes</theme>
    </system>
    <system>
        <name>gc</name>
        <fullname>Nintendo Gamecube</fullname>
        <path>/roms/Game Cube/roms</path>
        <extension>.iso</extension>
        <command>/usr/bin/dolphin-emu -b -e %ROM% -u ~/.dolphin-gc</command>
        <platform>gc</platform>
        <theme>gc</theme>
    </system>
    <system>
        <name>wii</name>
        <fullname>Nintendo Wii</fullname>
        <path>/roms/GCWii/roms</path>
        <extension>.iso .wbfs</extension>
        <command>/usr/bin/dolphin-emu -b -e %ROM% -u ~/.dolphin-gcwii</command>
        <platform>wii</platform>
        <theme>wii</theme>
    </system>
</systemList>


''