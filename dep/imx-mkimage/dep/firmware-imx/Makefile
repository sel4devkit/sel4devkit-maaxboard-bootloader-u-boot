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
	curl "https://sources.buildroot.net/firmware-imx/firmware-imx-8.22.bin" --output ${OUT_PATH}/firmware-imx-8.22.bin
	# Unpack.
	cd ${OUT_PATH} ; bash firmware-imx-8.22.bin --auto-accept

.PHONY: clean
clean:
	rm -rf ${OUT_PATH}

################################################################################
# End of file
################################################################################
