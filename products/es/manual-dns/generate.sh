#!/bin/bash

MODULE_DIR="../../../es/modules/dns"
moduledir=`realpath $MODULE_DIR`
revnumber="${PRODUCT_VERSION:-unknown}"
revdate="${PRODUCT_BUILD:-unknown}"

asciidoctor-pdf -o output.pdf -r asciidoctor-diagram \
        -a moduledir=$moduledir -a revnumber=$revnumber -a revdate=$revdate \
        manual.adoc

## remove temporal files generated
#rm $MODULE_DIR/assets/images/blackhole-negative.png
#rm $MODULE_DIR/assets/images/blackhole-positive.png
#rm $MODULE_DIR/assets/images/xlisthole-process.png
rm -rf .asciidoctor
