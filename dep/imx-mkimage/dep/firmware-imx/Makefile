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
OUT_PATH := out

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
get: | ${OUT_PATH}
	curl "https://sources.buildroot.net/firmware-imx/firmware-imx-8.22.bin" --output ${OUT_PATH}/firmware-imx-8.22.bin
	cd ${OUT_PATH} ; bash firmware-imx-8.22.bin --auto-accept

.PHONY: all
all:

${OUT_PATH}:
	mkdir ${OUT_PATH}

.PHONY: clean
clean:
	rm -rf ${OUT_PATH}

################################################################################
# End of file
################################################################################
