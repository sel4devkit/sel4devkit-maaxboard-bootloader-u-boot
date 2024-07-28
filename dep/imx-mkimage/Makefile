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

DEP_FIR_PATH := ${DEP_PATH}/firmware-imx
DEP_UBO_PATH := ${DEP_PATH}/uboot-imx
DEP_ATF_PATH := ${DEP_PATH}/imx-atf

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
all: ${OUT_PATH}/imx-mkimage

${OUT_PATH}:
	mkdir ${OUT_PATH}

DEP_FIR_TARGET_PATH_FILES := \
    ${DEP_FIR_PATH}/out/firmware-imx-8.22/firmware/ddr/synopsys/ddr4_dmem_1d_202006.bin \
    ${DEP_FIR_PATH}/out/firmware-imx-8.22/firmware/ddr/synopsys/ddr4_dmem_2d_202006.bin \
    ${DEP_FIR_PATH}/out/firmware-imx-8.22/firmware/ddr/synopsys/ddr4_imem_1d_202006.bin \
    ${DEP_FIR_PATH}/out/firmware-imx-8.22/firmware/ddr/synopsys/ddr4_imem_2d_202006.bin \
    ${DEP_FIR_PATH}/out/firmware-imx-8.22/firmware/hdmi/cadence/signed_hdmi_imx8m.bin \

${DEP_FIR_TARGET_PATH_FILES} &:
	make -C ${DEP_FIR_PATH} all

DEP_UBO_TARGET_PATH_FILES := \
    ${DEP_UBO_PATH}/out/uboot-imx/arch/arm/dts/maaxboard.dtb \
    ${DEP_UBO_PATH}/out/uboot-imx/spl/u-boot-spl.bin \
    ${DEP_UBO_PATH}/out/uboot-imx/tools/mkimage \
    ${DEP_UBO_PATH}/out/uboot-imx/u-boot-nodtb.bin \

${DEP_UBO_TARGET_PATH_FILES} &:
	make -C ${DEP_UBO_PATH} all

DEP_ATF_TARGET_PATH_FILES := \
    ${DEP_ATF_PATH}/out/imx-atf/build/imx8mq/release/bl31.bin \

${DEP_ATF_TARGET_PATH_FILES} &:
	make -C ${DEP_ATF_PATH} all

${OUT_PATH}/imx-mkimage: ${DEP_FIR_TARGET_PATH_FILES} ${DEP_UBO_TARGET_PATH_FILES} ${DEP_ATF_TARGET_PATH_FILES} | ${OUT_PATH}
	# Acquire.
	git -C ${OUT_PATH} clone --branch "develop_imx_4.14.78_1.0.0_ga" "git@github.com:Avnet/imx-mkimage.git"
	git -C ${OUT_PATH}/imx-mkimage reset --hard "9a299d31a2045db3eafb7ee61ec3c7ee87225d53"
	# Patch for relative target.
	sed -i -e 's/MKIMG = .*mkimage_imx8/MKIMG = mkimage_imx8/g' ${OUT_PATH}/imx-mkimage/Makefile
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

.PHONY: clean
clean:
	make -C ${DEP_FIR_PATH} clean
	make -C ${DEP_UBO_PATH} clean
	make -C ${DEP_ATF_PATH} clean
	rm -rf ${OUT_PATH}

################################################################################
# End of file
################################################################################
