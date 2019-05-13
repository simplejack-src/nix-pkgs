{ stdenv, fetchurl, fetchFromGitHub, unzip, kernel }:

let
  modDestDir = "$out/lib/modules/${kernel.modDirVersion}/kernel/drivers/net/wireless"; 
  pkg_repo = fetchFromGitHub {
    repo = "nix-pkgs";
    owner = "simplejack-src";
    rev = "v1.1";
    sha256 = "1js548w27chis3ixzhkx8y78wp5g738jabahsjzwpshyra5ww5hm";
  };
in stdenv.mkDerivation {
  name = "pce-n53-${kernel.version}";
  version = "1.1";

  src = fetchurl {
    url = "https://dlcdnets.asus.com/pub/ASUS/wireless/PCE-N53/Linux_PCE_N53_1008.zip";
    sha256 = "c3eb1c4fc5ae8851c079b9c860d2eac9a7db1377bd7e03f253459db435d5d2a3";
  };

  nativeBuildInputs = [ unzip kernel.moduleBuildDependencies ];

  # Unpack the actual source
  postUnpack = ''
    tar -xjf "Linux/DPO_GPL_RT5592STA_LinuxSTA_v2.6.0.0_20120326.tar.bz2"
  '';

  # Patch source so resultant module runs on recent kernels
  patches = [ "${pkg_repo}/pkgs/pce-n53/fix.patch" ];

  # Disable troublesome features
  hardeningDisable = [ "format" "fortify" "stackprotector" "pic" ];

  # Required build variables
  MODE = "STA";
  TARGET = "LINUX";
  KERN_VER = "${kernel.modDirVersion}";
  LINUX_SRC = "${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"; 

  makeFlags = [
    "-C DPO_GPL_RT5592STA_LinuxSTA_v2.6.0.0_20120326"
    "LINUX"
  ];

  enableParallelBuilding = true;

  installPhase = ''
    mkdir -p ${modDestDir};
    cp -f DPO_GPL_RT5592STA_LinuxSTA_v2.6.0.0_20120326/os/linux/rt5592sta.ko ${modDestDir}
  '';

  meta = with stdenv.lib; {
    description = "Kernel module (driver) for ASUS PCE-N53 WLAN chipset";
    longDescription = ''
      WLAN driver capable of providing STA mode support for the ASUS PCE-N53
      (RT5592) chipset.
    '';
    license = licenses.gpl2Plus;
    platforms = platforms.linux;
  };
}
