################################################################################
# Makefile
################################################################################

#===========================================================
# Check
#===========================================================
EXP_INFO := sel4devkit-maaxboard-microkit-docker-dev-env 1 *
CHK_PATH_FILE := /check.mk
ifeq ($(wildcard ${CHK_PATH_FILE}),)
    HALT := TRUE
else
    include ${CHK_PATH_FILE}
endif
ifdef HALT
    $(error Expected Environment Not Found: ${EXP_INFO})
endif

#===========================================================
# Layout
#===========================================================
OUT_PATH := out

#===========================================================
# Usage
#===========================================================
.PHONY: usage
usage: 
	@echo "usage: make <target>"
	@echo ""
	@echo "<target> is one off:"
	@echo "all"
	@echo "clean"

#===========================================================
# Target
#===========================================================

.PHONY: all
all: ${OUT_PATH}/uboot-imx

${OUT_PATH}:
	mkdir ${OUT_PATH}

${OUT_PATH}/uboot-imx: | ${OUT_PATH}
	# Acquire.
	git -C ${OUT_PATH} clone --branch "maaxboard_v2021.04_5.10.35_2.0.0" "https://github.com/Avnet/uboot-imx.git"
	git -C ${OUT_PATH}/uboot-imx reset --hard "f752480a4c29d3ff7fd4008863adc286019bf594"
	# Patch for favoured load address.
	sed -i -e 's/0x40480000/0x50000000/g' ${OUT_PATH}/uboot-imx/include/configs/maaxboard.h 
	# Build for MaaXBoard.
	make -C ${OUT_PATH}/uboot-imx maaxboard_defconfig
	make -C ${OUT_PATH}/uboot-imx CROSS_COMPILE=aarch64-linux-gnu-

.PHONY: clean
clean:
	rm -rf ${OUT_PATH}

################################################################################
# End of file
################################################################################
