#!/bin/bash

GUIDE_NAME="basic-nfqueue-xlist"
MODULE_DIR="../../../es/modules/guides"
THEME_NAME="luids"
THEMES_DIR="../../resources/themes"
FONTS_DIR="../../resources/fonts"

guidename="$GUIDE_NAME"
moduledir=`realpath $MODULE_DIR`
revnumber="${PRODUCT_VERSION:-unknown}"
revdate="${PRODUCT_BUILD:-unknown}"

asciidoctor-pdf -o output.pdf -v --trace -r asciidoctor-diagram \
	-a pdf-stylesdir="${THEMES_DIR}" \
	-a pdf-fontsdir="${FONTS_DIR}" \
	-a pdf-style="${THEME_NAME}" \
	-a moduledir=$moduledir -a revnumber=$revnumber -a revdate=$revdate \
	-a guidename=$guidename guide.adoc

## remove temporal files generated
imagesdir=$MODULE_DIR/assets/images/${guidename}
rm ${imagesdir}/${guidename}-sequence.png
rm ${imagesdir}/${guidename}-deployment.png
rm ${imagesdir}/${guidename}-flow.png
rm ${imagesdir}/${guidename}-flow-low-confidence.png
rm -rf .asciidoctor
