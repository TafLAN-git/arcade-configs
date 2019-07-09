{ config, pkgs, lib, ... }:

let
  hostname = "sorlag";
  user = "taflan";

  nixpkgs = import <nixpkgs> {};

  esSystems = import ./configs/es_systems.nix { pkgs = pkgs; writeText = nixpkgs.writeText; };
in {
  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.09"; # Did you read the comment?

  # Silent boot
  boot.consoleLogLevel = 0;
  boot.loader.timeout = pkgs.lib.mkForce 0;
  boot.plymouth.enable = true;
  boot.plymouth.logo = pkgs.fetchurl {
    url = "https://taflan.tf/wp-content/uploads/2013/12/TafLAN_logo_d32.png";
    sha256 = "54f947b2be29eb15f16c4e0079c151fe5eab9405e9a45e0d60527cecef5dd96e";
  };

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

  virtualisation.virtualbox.guest.enable = true;
  virtualisation.virtualbox.guest.x11 = true;
  # Graphics
  services.xserver = {
    enable = true;

    # Drivers, tried in order from left to right
    videoDrivers = [ "nvidia" "nouveau" "amdgpu" "intel" "vboxvideo" ];

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

  # OpenGL support
  hardware.opengl.enable = true;

  # 32-bit OpenGL support
  # hardware.opengl.driSupport32Bit = true;

  # Audio
  hardware.pulseaudio.enable = true;

  # System packages
  environment.systemPackages = with pkgs; [
    emulationstation
    retroarch
    glxinfo
  ];

  # Retroarch cores to enable
  #
  # List of supported cores:
  # https://github.com/NixOS/nixpkgs/blob/master/pkgs/misc/emulators/retroarch/cores.nix
  #
  # enableXXXX attribute found in:
  # https://nixos.org/releases/tmp/release-nixos-unstable-small/nixos-18.09pre146360.75942f96b3f/unpack/nixos-18.09pre146360.75942f96b3f/pkgs/top-level/all-packages.nix
  #nixpkgs.config.retroarch = {
    # Playstation core
    #enableBeetlePSX = true;

    # Super Nintendo Entertainment System core
    #enableBsnesMercury = true;

    # Wii / GameCube core
    #enableDolphin = true;

    # Nintendo Entertainment System core
    #enableFceumm = true;

    # Game Boy / Game Boy Color core
    #enableGambatte = true;

    # Genesis core
    #enableGenesisPlusGX = true;

    # Arcade core
    #enableMAME = true;

    # Game Boy Advance core
    #enableMGBA = true;

    # Nintendo 64 core
    #enableMupen64Plus = true;
  #};

  # Symlink dotfiles
  system.activationScripts.dotfiles = ''
    ${pkgs.coreutils}/bin/mkdir -p /home/${user}/.emulationstation
    ${pkgs.coreutils}/bin/ln -sf ${esSystems} /home/${user}/.emulationstation/es_systems.cfg
  '';

}
