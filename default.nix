{ system ? builtins.currentSystem,
  pkgs ? import <nixpkgs> { inherit system; },
  kernelPackages ? pkgs.linuxPackages }:
let
  callPackage = pkgs.lib.callPackageWith (pkgs // kernelPackages // self);

  self = {
    pce-n53 = callPackage ./pkgs/pce-n53 {};
  };
in self
