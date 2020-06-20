#!/bin/bash -ex

SOC=$(pwd)
CST=../linux64/bin/cst

command -v ${CST} &>/dev/null
if [[ $? -ne 0 ]];then
cat << eom
"${CST} - binary is missing, exiting ..."
eom
exit 1
fi

O=${SOC}/signed/k
install -d ${O}

ifile=zImage
ofile=${ifile}

zimage_path=${ifile}

zimage_pad_size=$(stat --printf=%s  ${zimage_path} | awk '($0=int(($0+0xfff)/0x1000)*0x1000)')

zimage_self_ptr=$(printf "0x%x\n" $(($zimage_pad_size+0x80800000)))
zimage_csf_ptr=$(printf "0x%x\n" $(($zimage_self_ptr+0x20)))
zImage_pad_ivt_size=$(printf "0x%x\n" $(($zimage_pad_size+0x20)))

cat <<EOF > ${O}/genIVT
#! /usr/bin/perl -w
use strict;
open(my \$out, '>:raw', '${O}/ivt.bin') or die "Unable to open: \$!";
print \$out pack("V", 0x412000D1); # Signature
print \$out pack("V", 0x80800000); # Load Address
print \$out pack("V", 0x0); # Reserved
print \$out pack("V", 0x0); # DCD pointer
print \$out pack("V", 0x0); # Boot Data
print \$out pack("V", $zimage_self_ptr); # Self Pointer *ivt
print \$out pack("V", $zimage_csf_ptr); # CSF Pointer *csf
print \$out pack("V", 0x0); # Reserved
close(\$out);
EOF
chmod +x ${O}/genIVT
${O}/genIVT

objcopy -I binary -O binary --pad-to $zimage_pad_size --gap-fill=0x00 ${zimage_path} ${O}/zImage_pad

cat ${O}/zImage_pad ${O}/ivt.bin > ${O}/zImage_pad_ivt

cat << eof > ${O}/csf-zimage.txt
$(cat csf.in)
Blocks = 0x80800000 0x000 ${zImage_pad_ivt_size} "${O}/zImage_pad_ivt"
eof

${CST} --o ${O}/csf-zImage --i ${O}/csf-zimage.txt

cat ${O}/zImage_pad_ivt ${O}/csf-zImage > ${O}/${ofile}

ln -sf ${ofile} ${O}/signed
