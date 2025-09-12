#!/bin/bash -xe

WORKDIR=$(dirname $(readlink -e ${BASH_SOURCE[0]}))

SRKTOOL=$(which srktool || true)
SRKTOOL=${SRKTOOL:-"${WORKDIR}/../linux64/bin/srktool"}

${SRKTOOL} -h 4 -t SRK_1_2_3_4_table.bin -e SRK_1_2_3_4_fuse.bin -d sha256 -c SRK1_sha256_2048_65537_v3_ca_crt.pem,SRK2_sha256_2048_65537_v3_ca_crt.pem,SRK3_sha256_2048_65537_v3_ca_crt.pem,SRK4_sha256_2048_65537_v3_ca_crt.pem -f 1
