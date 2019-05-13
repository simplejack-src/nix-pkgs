{ system ? builtins.currentSystem }:
let
  pkgs = import <nixpkgs> { inherit system; };

  callPackage = pkgs.lib.callPackageWith (pkgs // pkgs.linuxPackages // self);

  self = {
    pce-n53 = callPackage ./pkgs/pce-n53 { };
  };
in self
