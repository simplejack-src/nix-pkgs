Usage
=====
When applied to the original (uncompressed) ASUS PCE-N53 source drop (dated
2012) this modified source is able to build a STA-only kernel module for the
PCE-N53/Ralink chipset (rt55992sta.ko).

Note: The latest kernel release this has been tested with is:
   [Arch-Linux Mainline] 4.19.2-arch1-1-ARCH 


Manual Build Instructions
=========================
The following environment variables must be set prior to building:
MODE[=STA]
TARGET[=LINUX]
KERN_VER[=[target kernel version]]
LINUX_SRC[=[target kernel source directory, i.e. kernel headers]]


As a Makefile project, the following commands can be used to clean, build and
install the kernel module respectively:
# make clean
# make
# make install

Note: Installing the kernel module may require root privledges

e.g.
# export MODE='STA'
# export TARGET='LINUX'
# export KERN_VER='4.19.2-arch1-1-ARCH'
# export LINUX_SRC="/lib/modules/$KERN_VER/build"
# make clean
# make
# make install


Acknowledgments
===============
Based on an orignal patch provided by Jesse Crews <jcrews at gridlox dot net>