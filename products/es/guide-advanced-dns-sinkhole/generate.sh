#!/bin/bash

GUIDE_NAME="advanced-dns-sinkhole"
MODULE_DIR="../../../es/modules/guide-${GUIDE_NAME}"
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
imagesdir=$MODULE_DIR/assets/images
rm ${imagesdir}/${guidename}-deployment.png
rm ${imagesdir}/${guidename}-sequence.png
rm -rf .asciidoctor
