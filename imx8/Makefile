all: build

help:
	@echo "imx-boot input files"
	@echo "\tin the imx-boot build directory issue:"
	@echo "\tmake SOC=iMX8MM flash_evk 2>&1 | tee flash_evk.log"
	@echo "\tmake SOC=iMX8MM print_fit_hab 2>&1 | tee print_fit_hab.log"
	@echo "\tcopy flash.bin, flash_evk.log and print_fit_hab.log to hab/"
	@echo "\tdetails: https://github.com/compulab-yokneam/meta-bsp-imx8mm/blob/rel_imx_5.4.24_2.1.0-dev/Documentation/imx_boot_image_build.md"
	@echo "\nimx-boot signing procedure:"
	@echo "\tmake imx-boot"
	@echo "\tsigned image: hab/signed/u/flash.bin"
	@echo "\nkernel signing input fies"
	@echo "\tin the kernel build directory issue:"
	@echo "\tmake Image"
	@echo "\tcopy Image hab/"
	@echo "\tdetails: https://github.com/compulab-yokneam/meta-bsp-imx8mm/blob/rel_imx_5.4.24_2.1.0-dev/Documentation/linux_kernel_build.md"
	@echo "\nkernel signing procedure:"
	@echo "\tmake kernel"
	@echo "\tsigned image: hab/signed/k/Image"
	@echo "\nfuse values generating procedure:"
	@echo "\tmake fuse"
	@echo "\toutput file: hab/signed/f/fuse.out"

crts/SRK1_sha256_2048_65537_v3_ca_crt.pem:
	cd keys && ../tools/gen_keys.sh
	
crts/SRK_1_2_3_4_*.bin: crts/SRK1_sha256_2048_65537_v3_ca_crt.pem
	cd crts && ../tools/gen_srk.sh

srk:	crts/SRK_1_2_3_4_*.bin

hab/signed/k hab/signed/u hab/signed/f: crts/SRK_1_2_3_4_*.bin
	cd hab && ../tools/csf.$(@F)

sign_req: srk linux64/bin/cst

kernel_in: hab/Image hab/csf_additional_images.in
kernel:	sign_req kernel_in hab/signed/k

imx-boot_in: hab/flash.bin hab/flash_evk.log hab/print_fit_hab.log hab/csf_fit.in hab/csf_spl.in
imx-boot: sign_req imx-boot_in hab/signed/u

fuse: srk crts/SRK_1_2_3_4_*.bin hab/signed/f

clean:
	rm -rf hab/signed

clean_keys:
	rm -rf crts/* keys/*

clean_all: clean clean_keys

clean_yocto:
	rm -rf ca crts linux64 keys tools hab

build: kernel imx-boot fuse
