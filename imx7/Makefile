all: build

crts/SRK1_sha256_2048_65537_v3_ca_crt.pem:
	cd keys && ../tools/gen_keys.sh
	
crts/SRK_1_2_3_4_*.bin: crts/SRK1_sha256_2048_65537_v3_ca_crt.pem
	cd crts && ../tools/gen_srk.sh

srk:	crts/SRK_1_2_3_4_*.bin

hab/signed/k hab/signed/u hab/signed/f: crts/SRK_1_2_3_4_*.bin
	cd hab && ../tools/csf.$(@F)

sign_req: srk linux64/bin/cst

kernel_in: hab/zImage hab/csf.in
kernel:	sign_req kernel_in hab/signed/k

u-boot_in: hab/u-boot-ivt.img hab/u-boot-ivt.img.log hab/SPL hab/SPL.log hab/csf.in
u-boot: sign_req u-boot_in hab/signed/u

fuse: srk crts/SRK_1_2_3_4_*.bin hab/signed/f

clean:
	rm -rf hab/signed

clean_keys:
	rm -rf crts/* keys/*

clean_all: clean clean_keys

clean_yocto:
	rm -rf ca crts linux64 keys tools hab

build: kernel u-boot fuse
