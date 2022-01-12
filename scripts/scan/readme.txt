unpaper <pnm> <pnm>
pgm2tiff
tiffcp -c G4

tesseract

gm convert -list format

gm convert 
-colorspace gray
 <scan>
-colors 2 image.png       # ImageMagick is better than GraphicsMagick
-level 10,1,70% x.jpg
-threshold 50%
-monochrome               # either this or colorspace gray
-compress lzw|zip|group4  # for TIFF
-normalize                # stretch contrast
-enhance

-type bilevel (like monochrome)

convert <IN> -depth 1 x.png  # IM better - contrast stretch?

gm convert scan6.jpg -threshold 50% -type Bilevel -compress lzw scan6.tiff
tiff2pdf -p A4 -o x.pdf x.tiff
