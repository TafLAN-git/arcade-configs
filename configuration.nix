{ pkgs, lib, ... }:

let
  hostname = "sorlag";
  user = "taflan";
in {
  # Networking
  networking.hostName = hostname;
  networking.networkmanager.enable = true;

  # Time
  services.ntp.enable = true;
  time.timeZone = "Europe/Helsinki";

  # Enable OpenSSH server on-demand
  services.openssh = {
    enable = true;
    startWhenNeeded = true;
    passwordAuthentication = lib.mkDefault false;
  };

  # Define a user account. Don't forget to change your password.
  users.extraUsers = {
    ${user} = {
      password = "change-me";
      isNormalUser = true;
      extraGroups = [ "wheel" "audio" ];

      # Arcade cabinet maintainers' pubkeys go here.
      openssh.authorizedKeys.keys = [
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCxHyNeiwAzZoExz8iOWkxYmb/3xsN9QVwp/R0/SRUZlFQRPoXk4Ncwkt/U8aiSpm0XmrG1WWGYO9lf5UzAPX8LyHOfjaOyvCTok7RhyMSYZ1cBOJsEQ8MfMRKqjZ0vBaLjRDZoFBERT+/VBfazjTUB1Fv8dGHS8PLvdhMly2VinsSGTc/tApdigP61SJeLmo7NoDavBqTKHx1efJRAw4dRKilhl8fOvAsBCuOn9UzBdZAYX4WTpHvlZGFnkRvLteeAmHGuFPUq8ofc3X4HZfukIz1/l5Ya8l5srHAQEsSpKGcG7EuRHBz+cwEulfjDKlVyFK1Jx7UwJHFGKENtFbST FruitieX"
      ];
    };
  };

  # Graphics
  services.xserver = {
    # Enable GNOME 3
    displayManager.gdm.enable = true;
    desktopManager.gnome3.enable = true;

    # Use libinput
    libinput.enable = true;
  };

  # Audio
  hardware.pulseaudio.enable = true;

  # System packages
  environment.systemPackages = with pkgs; [
    retroarch
  ];
}
