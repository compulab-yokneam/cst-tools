#!/bin/bash

help_string="Available value is imx8"

DEST=${DEST:-$(pwd)}
SRC=${SRC:-$(pwd)}

if [[ -z ${SOC} ]];then
cat << eom
SOC is not set.
${help_string}
eom
exit 1
fi

if [[ ${SOC} == 'imx8' ]];then
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
    tar -C ${DEST}/cst-tools -xf ${SRC}/nxp/cst-4.0.1.tgz --strip-components=1 cst-4.0.1/linux64 cst-4.0.1/keys cst-4.0.1/crts cst-4.0.1/ca

    for d in Makefile hab tools;do
        cp -a ${SRC}/${SOC}/${d} ${DEST}/cst-tools/
    done
}

do_configure
