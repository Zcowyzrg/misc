#!/bin/sh

#gm convert -page A4 -units pixelsperinch -density 72 $1 $2
pdfjam --paper a4paper -o output.pdf $@
pdfinfo output.pdf
