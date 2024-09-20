# Introduction

This Package forms part of the seL4 Developer Kit. It provides a fully
coordinated build of a MaaXBoard Bootloader via Avnet fork of Das U-Boot. It
also provides a set of "uEnv.txt" files, which may be used to configure U-Boot
to automatically boot a program at power up.

# License

The build process is dependent upon pre-built firmware, as provided and shared
by IMX:
* https://sources.buildroot.net/firmware-imx/

Use of this Firmware implies accepting an "NXP SOFTWARE LICENSE AGREEMENT".
Our packaged build of the Bootloader automatically includes firmware as
embedded in "https://sources.buildroot.net/firmware-imx/firmware-imx-8.22.bin"
which is associated with license "LA_OPT_NXP_Software_License v49 September
2023". 

# Usage

Must be invoked inside the following:
* sel4devkit-maaxboard-microkit-docker-dev-env

Show usage instructions:
```
make
```

Build:
```
make all
```

The expectation is that the output "out/flash.bin", and potentially the set of
"uEnv.txt" files, will be used in preparing an SD-card, to be inserted into
the MaaXBoard SD-card slot, to provide a functioning Bootloader.

# Maintenance

Presents detailed technical aspects relevant to understanding and maintaining
this Package.

## Dependencies

The Bootloader is assembled from a collection of externally managed
dependencies, as summarised below:
- firmware-imx: Pre-built firmware, as maintained by IMX, which is essential
  for enabling some devices on the SoC as present on MaaXBoard (i.MX 8).
This package makes use of both the DDR PHY and HDMI firmware.
- imx-atf: Source code for the ATF (ARM Trusted Firmware), as maintained by
  IMX, which is an essential element for booting the SoC as present
on MaaXBoard (i.MX 8).
- uboot-imx: Fork of the U-Boot, modified by IMX for the SoC as present on
  MaaXBoard (i.MX 8).
- imx-mkimage: Fork of the mkimage tool, modified by IMX for the SoC as
  present on MaaXBoard (i.MX 8), that combines various elements into a single
IVT (Image Vector Table) image suitable for initialising the SoC and booting
an application.
