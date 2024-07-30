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
all: ${OUT_PATH}/imx-atf

${OUT_PATH}:
	mkdir ${OUT_PATH}

${OUT_PATH}/imx-atf: | ${OUT_PATH}
	# Acquire.
	git -C ${OUT_PATH} clone --branch "maaxboard-imx_5.4.24_2.1.0" "git@github.com:Avnet/imx-atf.git" imx-atf
	git -C ${OUT_PATH}/imx-atf reset --hard "d801fd97ea9606bf5a686334639abac2ddb77985"
	# Patch for current compiler.
	echo "TF_LDFLAGS += --no-warn-rwx-segments" >> ${OUT_PATH}/imx-atf/Makefile
	echo "TF_CFLAGS_aarch64 += --param=min-pagesize=0" >> ${OUT_PATH}/imx-atf/Makefile
	# Build for MaaXBoard.
	make -C ${OUT_PATH}/imx-atf CROSS_COMPILE=aarch64-linux-gnu- PLAT=imx8mq

.PHONY: clean
clean:
	rm -rf ${OUT_PATH}

################################################################################
# End of file
################################################################################
