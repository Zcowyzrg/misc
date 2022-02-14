#!/bin/sh

device=genesys
fname=`date +scan-%Y-%m-%d--%H-%M-%S`
scanimage -d $device --mode Color --resolution 300 -x 210 -y 297 --format=png -o $fname.png
echo Converting to monochrome...
./conv.sh $fname.png img${fname:4}.png
echo Converting to 4 colours...
./conv-c4.sh $fname.png img${fname:4}-c4.png
echo Converting to 16 colours...
./conv-c16.sh $fname.png img${fname:4}-c16.png
