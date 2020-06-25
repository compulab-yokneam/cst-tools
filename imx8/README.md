# CompuLab cst-tools

This is a tool for: signing kernel, imx-boot image and generating the fuse values file.
<br>
This tool uses: [NXP Code Signing Tools](https://www.nxp.com/webapp/Download?colCode=IMX_CST_TOOL_NEW)

Supported machines:
* ucm-imx8m-mini
* mcm-imx8m-mini

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
        details: https://github.com/compulab-yokneam/meta-bsp-imx8mm/blob/mcm-imx8m-mini/Documentation/imx_boot_image_build.md

imx-boot signing procedure:
        make imx-boot
        signed image: hab/signed/u/flash.bin

kernel signing input fies
        in the kernel build directory issue:
        make Image
        copy Image hab/
        details: https://github.com/compulab-yokneam/meta-bsp-imx8mm/blob/mcm-imx8m-mini/Documentation/linux_kernel_build.md

kernel signing procedure:
        make kernel
        signed image: hab/signed/k/Image

fuse values generating procedure:
        make fuse
        output file: hab/signed/f/fuse.out
```

## Input files:
Follow instructions of: [imx-boot image buid](https://github.com/compulab-yokneam/meta-bsp-imx8mm/edit/mcm-imx8m-mini/Documentation/imx_boot_image_build.md) and [kerne image buil](https://github.com/compulab-yokneam/meta-bsp-imx8mm/blob/mcm-imx8m-mini/Documentation/linux_kernel_build.md)
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
hab
├── csf_additional_images.in
├── csf_fit.in
├── csf_spl.in
├── flash.bin
├── flash_evk.log
├── Image
├── print_fit_hab.log
└── signed
    ├── f
    │   └── fuse.out
    ├── k
    │   ├── csf_additional_images.in
    │   ├── genivt
    │   ├── hab_auth_img.cmd
    │   ├── Image
    │   ├── Image_csf
    │   ├── Image_pad
    │   ├── Image_pad_ivt
    │   ├── ivt.bin
    │   └── signed -> Image
    └── u
        ├── csf_fit.bin
        ├── csf_fit.txt
        ├── csf_spl.bin
        ├── csf_spl.txt
        ├── flash.bin
        └── signed -> flash.bin
```

* Clean up

|Description|Command|
|---|---|
| signed files only |make clean|
| keys only |make clean_keys|
| all files |make clean_all|
