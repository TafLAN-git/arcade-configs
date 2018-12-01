{
  sorlag =
    { config, lib, pkgs, ... }: {
      imports = [
        ./configuration.nix
      ];

      deployment.targetEnv = "virtualbox";
      deployment.virtualbox.memorySize = 4096; # megabytes
      deployment.virtualbox.vcpu = 2; # number of cpus
    };
}
