################################################################################
# Makefile
################################################################################

#===========================================================
# Check
#===========================================================
ifndef FORCE
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
	@echo "usage: make <target> [FORCE=TRUE]"
	@echo ""
	@echo "<target> is one off:"
	@echo "get"
	@echo "all"
	@echo "clean"

#===========================================================
# Target
#===========================================================
.PHONY: get
get: dep-get

.PHONY: dep-get
dep-get:
	make -C ${DEP_MKI_PATH} get

.PHONY: all
all: dep-all ${OUT_PATH}/flash.bin

.PHONY: dep-all
dep-all:
	make -C ${DEP_MKI_PATH} all

${OUT_PATH}:
	mkdir ${OUT_PATH}

${OUT_PATH}/flash.bin: ${DEP_MKI_PATH}/out/imx-mkimage/iMX8M/flash.bin | ${OUT_PATH}
	cp $< $@

.PHONY: clean
clean:
	make -C ${DEP_MKI_PATH} clean
	rm -rf ${OUT_PATH}

################################################################################
# End of file
################################################################################
