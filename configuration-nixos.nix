{
  sorlag =
    { config, lib, pkgs, ... }: {
      imports = [
        ./configuration.nix
      ];

      deployment.targetHost = "1.2.3.4";
    };
}
