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
DEP_PATH := dep
OUT_PATH := out

DEP_MKI_PATH := ${DEP_PATH}/imx-mkimage/

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
all: ${OUT_PATH}/flash.bin

${OUT_PATH}:
	mkdir ${OUT_PATH}

${DEP_MKI_PATH}/out/imx-mkimage/iMX8M/flash.bin:
	make -C ${DEP_MKI_PATH} all

${OUT_PATH}/flash.bin: ${DEP_MKI_PATH}/out/imx-mkimage/iMX8M/flash.bin | ${OUT_PATH}
	cp $< $@

.PHONY: clean
clean:
	make -C ${DEP_MKI_PATH} clean
	rm -rf ${OUT_PATH}

################################################################################
# End of file
################################################################################
