Custom Nix Packages
===================
* ASUS PCE-N53 (STA-only) WLAN driver

Nix Channel
===========
Note: Below (including Install) should be done with root permissions if Nix store is only root accessible or if using NixOS declarative configuration.
```
nix-channel --add https://github.com/simplejack-src/nix-pkgs/archive/master.tar.gz simplejack-src-pkgs
nix-channel --update simplejack-src-pkgs
```

Manual Build
============
```
# wget -O - https://github.com/simplejack-src/nix-pkgs/archive/master.tar.gz | tar xz
# nix-build -A pce-n53 ./nix-pkgs-master/default.nix
```

Install
=======
e.g. NixOS install PCE-N53 driver from channel (added via above):
Add to /etc/nixos/configuration.nix:
```
{ config, pkgs, ... }:
let
  simplejack-src-pkgs = import <simplejack-src-pkgs> {};
in {
  boot.extraModulePackages = [ simplejack-src-pkgs.pce-n53 ];
}
```
