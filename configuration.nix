{ config, pkgs, lib, ... }:

let
  hostname = "sorlag";
  user = "taflan";
in {
  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.nixos.stateVersion = "18.09"; # Did you read the comment?

  # Silent boot
  boot.consoleLogLevel = 0;
  boot.loader.timeout = pkgs.lib.mkForce 0;

  # Networking
  networking.hostName = hostname;
  networking.networkmanager.enable = true;

  # Time
  services.ntp.enable = true;
  time.timeZone = "Europe/Helsinki";

  # Enable OpenSSH server
  services.openssh = {
    enable = true;
    passwordAuthentication = lib.mkDefault false;
  };

  # Define a user account. Don't forget to change your password.
  users.extraUsers = {
    ${user} = {
      password = "change-me";
      isNormalUser = true;
      extraGroups = [ "audio" "input" "networkmanager" "video" "wheel" ];

      # Arcade cabinet maintainers' pubkeys go here.
      openssh.authorizedKeys.keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCxHyNeiwAzZoExz8iOWkxYmb/3xsN9QVwp/R0/SRUZlFQRPoXk4Ncwkt/U8aiSpm0XmrG1WWGYO9lf5UzAPX8LyHOfjaOyvCTok7RhyMSYZ1cBOJsEQ8MfMRKqjZ0vBaLjRDZoFBERT+/VBfazjTUB1Fv8dGHS8PLvdhMly2VinsSGTc/tApdigP61SJeLmo7NoDavBqTKHx1efJRAw4dRKilhl8fOvAsBCuOn9UzBdZAYX4WTpHvlZGFnkRvLteeAmHGuFPUq8ofc3X4HZfukIz1/l5Ya8l5srHAQEsSpKGcG7EuRHBz+cwEulfjDKlVyFK1Jx7UwJHFGKENtFbST FruitieX"
      ];
    };
  };

  # Graphics
  services.xserver = {
    enable = true;

    # Use libinput
    libinput.enable = true;

    # Disable VT switching with CTRL+ALT+F1-F12
    config = ''
      Section "ServerFlags"
        Option  "DontVTSwitch"  "True"
      EndSection
    '';

    # Dummy autologin display manager
    displayManager.auto = {
      enable = true;
      user = user;
    };

    # Openbox
    windowManager.default = "openbox";
    windowManager.openbox.enable = true;

    # TODO: investigate running a custom session instead of tweaking openbox to our needs
    # desktopManager.session = [{
    #   name = "arcade";
    #   start = ''
    #     ${pkgs.retroarch}/bin/retroarch --verbose &
    #     waitPID=$!
    #   '';
    # }]
  };

  # Audio
  hardware.pulseaudio.enable = true;

  # System packages
  environment.systemPackages = with pkgs; [
    emulationstation
    retroarch
  ];

  # Retroarch cores to enable
  #
  # List of supported cores:
  # https://github.com/NixOS/nixpkgs/blob/master/pkgs/misc/emulators/retroarch/cores.nix
  #
  # enableXXXX attribute found in:
  # https://nixos.org/releases/tmp/release-nixos-unstable-small/nixos-18.09pre146360.75942f96b3f/unpack/nixos-18.09pre146360.75942f96b3f/pkgs/top-level/all-packages.nix
  nixpkgs.config.retroarch = {
    # Playstation core
    enableBeetlePSX = true;

    # Super Nintendo Entertainment System core
    enableBsnesMercury = true;

    # Wii / GameCube core
    #enableDolphin = true;

    # Nintendo Entertainment System core
    enableFceumm = true;

    # Game Boy / Game Boy Color core
    enableGambatte = true;

    # Genesis core
    enableGenesisPlusGX = true;

    # Arcade core
    enableMAME = true;

    # Game Boy Advance core
    enableMGBA = true;

    # Nintendo 64 core
    enableMupen64Plus = true;
  };
}
