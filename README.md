# arcade-configs

**WORK IN PROGRESS**

## Introduction

This repo contains Nix expressions for configuring a NixOS host as an arcade
cabinet. There are also NixOps configs for local VirtualBox VM development, as
well as deployment to bare-metal machines.

### Why Nix?

Usage of Nix(Ops) addresses a few things:

- Local development environment: We can easily deploy to virtual machines,
  allowing anybody to participate in development of the system configuration.
- Quick iteration: Re-deploying after making changes to configuration.nix
  typically only takes a few seconds. Nix figures out the necessary changes, and
  applies them to the running NixOS instance on the fly.
- Self documenting: The declarative nature of Nix expressions means any changes
  to the system configuration are visible in one single place.
- No need to do "cleanup re-installs". NixOS only keeps packages/services around
  if they are declared in configuration.nix. There is no difference between
  a re-install or doing a re-deployment.
- We get system-wide rollbacks for free.

Further reading:

- https://nixos.org/nixops/manual/#chap-introduction
- https://nixos.org/nixos/about.html
- https://nixos.org/nix/about.html

## Local setup

Running a local deployment requires Nix and NixOps, which in turn work on both
Linux and macOS. Windows (with WSL) is a work in progress.

1. Install VirtualBox: https://www.virtualbox.org/
2. Install the Nix package manager: https://nixos.org/nix/
3. Install NixOps using Nix:

    ```
    nix-env -i nixops
    ```

4. Clone this repo somewhere.
5. Inside the repo, run:

    ```
    nixops create configuration-vbox.nix -d vm-sorlag
    ```
6. Followed by:

    ```
    nixops deploy -d vm-sorlag
    ```

NixOps should now fetch the required VirtualBox images and packages, boot up
a NixOS VM for you and copy the Nix closure into the guest.

**NOTE**: NixOps VirtualBox target seems to initially install an ancient
version of NixOS. After running `nixops deploy` for the first time you might
get errors regarding activation of services at the end of the deployment.
Running `nixops stop` followed by another `nixops deploy -d vm-sorlag` seems to
fix the issue by rebooting into the now upgraded NixOS installation.

## Useful commands for development

- To deploy further changes to `configuration.nix`, run:

    ```
    nixops deploy -d vm-sorlag
    ```

  NixOps will figure out the necessary changes, and only deploy those.

- You can inspect the running instance with SSH using:

    ```
    nixops ssh vm-sorlag
    ```

- Stop the VM cleanly with:

    ```
    nixops stop
    ```

  You can use the deploy command to start the VM again later.

## Deployment

Bare metal deployment requires a NixOS target host which is accessible over
SSH. Follow [these
steps](https://nixos.org/nixos/manual/index.html#ch-installation) if the target
host isn't running NixOS yet. You can use our `configuration.nix` while
installing by merging it with `/mnt/etc/nixos/configuration.nix`.  Remember to
keep your (hardware-specific) `hardware-configuration.nix` import in place!

With a target NixOS host ready:

1. Clone this repo somewhere.
2. Modify `configuration-nixos.nix` with the target host's IP address
3. Inside the repo, run:

    ```
    nixops create configuration-nixos.nix -d sorlag
    ```
4. Followed by:

    ```
    nixops deploy -d sorlag
    ```

NixOps should now fetch the required packages, and copy the Nix closure into
the target host.

To deploy further changes to `configuration.nix`, run:

```
nixops deploy -d sorlag
```

NixOps will figure out the necessary changes, and only deploy those.
