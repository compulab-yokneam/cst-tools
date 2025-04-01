#!/bin/bash

help_string="Available values are: imx8, imx7"

DEST=${DEST:-$(pwd)}
SRC=${SRC:-$(pwd)}

if [[ -z ${SOC} ]];then
cat << eom
SOC is not set.
${help_string}
eom
exit 1
fi

if [[ ${SOC} == 'imx8' ]] || [[ ${SOC} == 'imx7' ]];then
:
else
cat << eom
Invalid SOC value ${SOC}
${help_string}
eom
exit 2
fi

do_configure () {
    install -d ${DEST}/cst-tools
    tar -C ${DEST}/cst-tools -xf ${SRC}/nxp/cst-4.0.0.tgz --strip-components=1 cst-4.0.0/linux64 cst-4.0.0/keys cst-4.0.0/crts cst-4.0.0/ca

    for d in env Makefile hab tools;do
        cp -a ${SRC}/${SOC}/${d} ${DEST}/cst-tools/
    done
}

do_configure
