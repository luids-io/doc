#!/bin/bash

MODULE_DIR="../../../es/modules/guides"
moduledir=`realpath $MODULE_DIR`
revnumber="${PRODUCT_VERSION:-unknown}"
revdate="${PRODUCT_BUILD:-unknown}"

asciidoctor-pdf -o output.pdf -v --trace -r asciidoctor-diagram \
	-a moduledir=$moduledir -a revnumber=$revnumber -a revdate=$revdate \
	guide.adoc

## remove temporal files generated
#rm $MODULE_DIR/assets/images/diagram-basic-sinkhole-sequence.png
#rm $MODULE_DIR/assets/images/deployment-basic-dns-sinkhole.png
#rm $MODULE_DIR/assets/images/flow-basic-dns-sinkhole.png
rm -rf .asciidoctor
