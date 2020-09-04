#!/bin/bash

MODULE_DIR="../../../es/modules/archive"
moduledir=`realpath $MODULE_DIR`
revnumber="${PRODUCT_VERSION:-unknown}"
revdate="${PRODUCT_BUILD:-unknown}"

asciidoctor-pdf -o output.pdf -r asciidoctor-diagram \
	-a moduledir=$moduledir -a revnumber=$revnumber -a revdate=$revdate \
	manual.adoc

## remove temporal files generated
rm -rf .asciidoctor
