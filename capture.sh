#!/bin/bash

TMP_IMG=".tmp.img.png"

rm output*stl 2>/dev/null
rm -rf /tmp/out*jpg 2>/dev/null

name=$1
if [ ! $name ]
then
	echo "Give name"
	read name
fi

echo "Launching capture"
python lib/cap.py
IMG=/tmp/avg.out.jpg

convert /tmp/out*jpg -evaluate-sequence mean $IMG
convert -fill red -draw "point 0,0" $IMG -negate -background black -normalize $TMP_IMG

echo "generating STL"
python lib/stl_tools_helper.py examples/${name}.stl 0.08 .8

echo "simplifying STL"
meshlabserver -i examples/${name}.stl -o examples/${name}.stl -s simplify.mlx

echo "view!"
python ~/printer/tatlin/tatlin.py examples/${name}.stl

