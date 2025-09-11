#!/bin/bash -xe
#
WORKDIR=$(dirname $(readlink -e ${BASH_SOURCE[0]}))
${WORKDIR}/../keys/hab4_pki_tree.sh -existing-ca n -kt rsa -kl 2048 -duration 10 -num-srk 4 -srk-ca y
