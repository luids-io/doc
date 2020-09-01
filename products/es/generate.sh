#!/bin/bash

SRCDIR=$(dirname $(readlink -f "$0"))
OUTDIR=${SRCDIR}/output

export PRODUCT_LANG="es"
export PRODUCT_VERSION=$(git describe --match 'v[0-9]*' --dirty='.m' --always)
export PRODUCT_BUILD=$(date +%F)

# list of products
PRODUCTS="manual-xlist manual-dns guide-basic-dns-sinkhole"

mkdir -p $OUTDIR
for product in $PRODUCTS; do
	echo "Constructing: ${product}"
	pushd ${SRCDIR}/${product} >/dev/null
	./generate.sh
	mv output.pdf ${OUTDIR}/${product}_${PRODUCT_LANG}.pdf
	popd >/dev/null
done

