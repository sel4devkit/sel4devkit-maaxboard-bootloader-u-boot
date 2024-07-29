# Introduction

This Package forms part of the seL4 Developer Kit. It provides a fully
coordinated build of a MaaXBoard Bootloader via Avnet fork of Das U-Boot. It
also provides a set of "uEnv.txt" files, which may be used to configure U-Boot
to automatically boot a program at power up.

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


...tricky... bits of this covered better in the overall guide.

Maybe total-low-level basics? Like the what and less the how?

