#!/bin/sh

echo $0

if [[ `basename $0` == 'conv.sh' ]]; then
  echo Converting to monochrome...
  gm convert $1 -level 10,1,70% -enhance -lat 10x10-5% -monochrome $2
elif [[ `basename $0` == 'conv-c4.sh' ]]; then
  echo Converting to 4 colours...
  gm convert $1 -level 10,1,70% -enhance -colors 4 -normalize $2
elif [[ `basename $0` == 'conv-c16.sh' ]]; then
  echo Converting to 16 colours...
  gm convert $1 -level 10,1,70% -enhance -colors 16 -normalize $2
fi
