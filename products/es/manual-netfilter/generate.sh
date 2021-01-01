#!/bin/bash

MANUAL_NAME="netfilter"
MODULE_DIR="../../../es/modules/manual-${MANUAL_NAME}"
THEME_NAME="luids"
THEMES_DIR="../../resources/themes"
FONTS_DIR="../../resources/fonts"

manualname="$MANUAL_NAME"
moduledir=`realpath $MODULE_DIR`
revnumber="${PRODUCT_VERSION:-unknown}"
revdate="${PRODUCT_BUILD:-unknown}"

asciidoctor-pdf -o output.pdf -r asciidoctor-diagram \
	-a pdf-stylesdir="${THEMES_DIR}" \
	-a pdf-fontsdir="${FONTS_DIR}" \
	-a pdf-style="${THEME_NAME}" \
	-a moduledir=$moduledir -a revnumber=$revnumber -a revdate=$revdate \
	-a docs-version=$revnumber -a docs-date=$revdate \
	-a manualname=$manualname manual.adoc

## remove temporal files generated
rm -rf .asciidoctor
