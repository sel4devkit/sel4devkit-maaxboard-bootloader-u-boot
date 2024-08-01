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

DEP_FIR_PATH := ${DEP_PATH}/firmware-imx
DEP_UBO_PATH := ${DEP_PATH}/uboot-imx
DEP_ATF_PATH := ${DEP_PATH}/imx-atf

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
get: dep-get | ${OUT_PATH}
	git -C ${OUT_PATH} clone --branch "develop_imx_4.14.78_1.0.0_ga" "git@github.com:Avnet/imx-mkimage.git" imx-mkimage
	git -C ${OUT_PATH}/imx-mkimage reset --hard "9a299d31a2045db3eafb7ee61ec3c7ee87225d53"

.PHONY: dep-get
dep-get:
	make -C ${DEP_FIR_PATH} get
	make -C ${DEP_UBO_PATH} get
	make -C ${DEP_ATF_PATH} get

DEP_FIR_TARGET_PATH_FILES := \
    ${DEP_FIR_PATH}/out/firmware-imx-8.22/firmware/ddr/synopsys/ddr4_dmem_1d_202006.bin \
    ${DEP_FIR_PATH}/out/firmware-imx-8.22/firmware/ddr/synopsys/ddr4_dmem_2d_202006.bin \
    ${DEP_FIR_PATH}/out/firmware-imx-8.22/firmware/ddr/synopsys/ddr4_imem_1d_202006.bin \
    ${DEP_FIR_PATH}/out/firmware-imx-8.22/firmware/ddr/synopsys/ddr4_imem_2d_202006.bin \
    ${DEP_FIR_PATH}/out/firmware-imx-8.22/firmware/hdmi/cadence/signed_hdmi_imx8m.bin \

DEP_UBO_TARGET_PATH_FILES := \
    ${DEP_UBO_PATH}/out/uboot-imx/arch/arm/dts/maaxboard.dtb \
    ${DEP_UBO_PATH}/out/uboot-imx/spl/u-boot-spl.bin \
    ${DEP_UBO_PATH}/out/uboot-imx/tools/mkimage \
    ${DEP_UBO_PATH}/out/uboot-imx/u-boot-nodtb.bin \

DEP_ATF_TARGET_PATH_FILES := \
    ${DEP_ATF_PATH}/out/imx-atf/build/imx8mq/release/bl31.bin \

.PHONY: all
all: dep-all ${DEP_FIR_TARGET_PATH_FILES} ${DEP_UBO_TARGET_PATH_FILES} ${DEP_ATF_TARGET_PATH_FILES} | ${OUT_PATH}
	# Patch for relative target.
	sed --in-place --expression "s/MKIMG = .*mkimage_imx8/MKIMG = mkimage_imx8/g" ${OUT_PATH}/imx-mkimage/Makefile
	# Populate.
	cp ${DEP_FIR_TARGET_PATH_FILES} ${DEP_UBO_TARGET_PATH_FILES} ${DEP_ATF_TARGET_PATH_FILES} ${OUT_PATH}/imx-mkimage/iMX8M
	mv ${OUT_PATH}/imx-mkimage/iMX8M/ddr4_dmem_1d_202006.bin ${OUT_PATH}/imx-mkimage/iMX8M/ddr4_dmem_1d.bin
	mv ${OUT_PATH}/imx-mkimage/iMX8M/ddr4_dmem_2d_202006.bin ${OUT_PATH}/imx-mkimage/iMX8M/ddr4_dmem_2d.bin
	mv ${OUT_PATH}/imx-mkimage/iMX8M/ddr4_imem_1d_202006.bin ${OUT_PATH}/imx-mkimage/iMX8M/ddr4_imem_1d.bin
	mv ${OUT_PATH}/imx-mkimage/iMX8M/ddr4_imem_2d_202006.bin ${OUT_PATH}/imx-mkimage/iMX8M/ddr4_imem_2d.bin
	mv ${OUT_PATH}/imx-mkimage/iMX8M/maaxboard.dtb ${OUT_PATH}/imx-mkimage/iMX8M/fsl-imx8mq-ddr4-arm2.dtb
	mv ${OUT_PATH}/imx-mkimage/iMX8M/mkimage ${OUT_PATH}/imx-mkimage/iMX8M/mkimage_uboot
	# Build for MaaXBoard.
	make -C ${OUT_PATH}/imx-mkimage SOC=iMX8MQ flash_ddr4_val

.PHONY: dep-all
dep-all:
	make -C ${DEP_FIR_PATH} all
	make -C ${DEP_UBO_PATH} all
	make -C ${DEP_ATF_PATH} all

${OUT_PATH}:
	mkdir ${OUT_PATH}

.PHONY: clean
clean:
	make -C ${DEP_FIR_PATH} clean
	make -C ${DEP_UBO_PATH} clean
	make -C ${DEP_ATF_PATH} clean
	rm -rf ${OUT_PATH}

################################################################################
# End of file
################################################################################
