#!/bin/bash

IMG=$1
TMP_IMG=".tmp.img.png"


rm output*stl 2>/dev/null
rm -rf /tmp/out*jpg 2>/dev/null

echo "Give name"
read name

echo "Launching capture"
python lib/cap.py
IMG=/tmp/avg.out.jpg

echo "finding appropriate size"
for var in `seq 50 50`
do
	echo $var
	convert /tmp/out*jpg -evaluate-sequence mean $IMG
	convert -fill red -draw "point 0,0" $IMG -negate -resize ${var}% -background black -normalize $TMP_IMG

	echo "generating STL"
	python lib/stl_tools_helper.py examples/${name}.stl 0.08 .8

	echo "simplifying STL"
	meshlabserver -i examples/${name}.stl -o examples/${name}.stl -s simplify.mlx

	echo "view!"
	python ~/printer/tatlin/tatlin.py examples/${name}.stl


	# size=`ls -l output.stl | awk '{print $5}'`
	# if [ $size -gt 4000000 ]
	# then
	# 	echo "correct size is ${var}%"

	# 	for blur in 1.5 #1.0 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2.0
	# 	do
	# 		echo "generating STL with blur $blur"

	# 		python lib/stl_tools_helper.py output.${blur}.stl 0.085 ${blur}
	# 	done

	# 	break
	# fi
done