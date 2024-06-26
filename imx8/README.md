# CompuLab cst-tools

This is a tool for: signing kernel, imx-boot image and generating the fuse values file.
<br>
This tool uses: [NXP Code Signing Tools](https://www.nxp.com/webapp/Download?colCode=IMX_CST_TOOL_NEW)

Supported machines:
* ucm-imx8m-mini
* mcm-imx8m-mini
* iot-gate-imx8
* ucm-imx8m-plus
* iot-gate-imx8plus
* iotdin-imx8p

# How to use

## Download the cst-tools:
* Clone the `cst-tools` repository to `/path/to/cst-tools`
```
git clone https://github.com/compulab-yokneam/cst-tools.git /path/to/cst-tools
```
* Got to `/path/to/cst-tools` and issue `bootstrap.sh`
```
SOC=imx8 ./bootstrap.sh
```
A directory `/path/to/cst-tools/cst-tools` will get created.

* Got to `/path/to/cst-tools/cst-tools` and issue `make help`:
```
make help
imx-boot input files
        in the imx-boot build directory issue:
        make SOC=iMX8MM flash_evk 2>&1 | tee flash_evk.log
        make SOC=iMX8MM print_fit_hab 2>&1 | tee print_fit_hab.log
        copy flash.bin, flash_evk.log and print_fit_hab.log to hab/
        details: https://github.com/compulab-yokneam/meta-bsp-imx8mm/blob/rel_imx_5.4.24_2.1.0-dev/Documentation/imx_boot_image_build.md

imx-boot signing procedure:
        make imx-boot
        signed image: hab/signed/u/flash.bin

kernel signing input fies
        in the kernel build directory issue:
        make Image
        copy Image hab/
        details: https://github.com/compulab-yokneam/meta-bsp-imx8mm/blob/rel_imx_5.4.24_2.1.0-dev/Documentation/linux_kernel_build.md

kernel signing procedure:
        make kernel
        signed image: hab/signed/k/Image

fuse values generating procedure:
        make fuse
        output file: hab/signed/f/fuse.out
```

## Input files:
Follow instructions of: [imx-boot image buid](https://github.com/compulab-yokneam/meta-bsp-imx8mm/blob/rel_imx_5.4.24_2.1.0-dev/Documentation/imx_boot_image_build.md) and [kerne image buil](https://github.com/compulab-yokneam/meta-bsp-imx8mm/blob/rel_imx_5.4.24_2.1.0-dev/Documentation/linux_kernel_build.md)
and prepare and copy all rquired input files. When all files are at `hab` folder, then issue:

* Kernel signing
```
make kernel
```

* imx-boot signing
```
make imx-boot
```

* fuse values generating
```
make fuse
```

* Generate all targets `kernel`, `imx-boot`, `fuse` at the same time:
```
make
```

## Signed files directory layout:
```
1 hab
2 ├── Image
3 ├── bootaa64.efi
4 ├── csf_additional_images.in
5 ├── csf_fit.in
6 ├── csf_spl.in
7 ├── flash.bin
8 ├── flash_evk.log
9 ├── print_fit_hab.log
10 └── signed
11     ├── f
12     │   └── fuse.out
13     ├── k
14     │   ├── Image  --- Signed Linux Image for U-Boot <#1-partition>/Image
15     │   ├── Image_csf
16     │   ├── Image_pad
17     │   ├── Image_pad_ivt
18     │   ├── csf_additional_images.in
19     │   ├── genivt
20     │   ├── hab_auth_img.cmd
21     │   ├── ivt.bin
22     │   └── signed -> Image
23     ├── kgrub
24     │   ├── Image --- Signed Linux Image for GRUB <#2-partition>/boot/Image
25     │   ├── Image_csf
26     │   ├── Image_pad
27     │   ├── Image_pad_ivt
28     │   ├── csf_additional_images.in
29     │   ├── genivt
30     │   ├── hab_auth_img.cmd
31     │   ├── ivt.bin
32     │   └── signed -> Image
33     ├── u
34     │   ├── csf_fit.bin
35     │   ├── csf_fit.txt
36     │   ├── csf_spl.bin
37     │   ├── csf_spl.txt
38     │   ├── flash.bin --- Signed bootloader
39     │   └── signed -> flash.bin
40     └── uefi
41         ├── bootaa64.efi --- Signed grub loader <#1-partition>/EFI/BOOT/bootaa64.efi
42         ├── bootaa64.efi_csf
43         ├── bootaa64.efi_pad
44         ├── bootaa64.efi_pad_ivt
45         ├── csf_additional_images.in
46         ├── genivt
47         ├── hab_auth_img.cmd
48         ├── ivt.bin
49         └── signed -> bootaa64.efi
```

* Clean up

|Description|Command|
|---|---|
| signed files only |make clean|
| keys only |make clean_keys|
| all files |make clean_all|
