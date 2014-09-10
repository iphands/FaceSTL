#!/bin/bash

IMG=$1
TMP_IMG=".tmp.img.png"

if [ "$IMG" == "" ]
then
	echo "Error: image file needed"
	echo "Usage: $0 path_to_image_file"
	exit
fi

echo "finding appropriate size"
for var in `seq 1 50`
do
	echo $var
	convert $IMG -resize ${var}% -background black -vignette 50x5000 -normalize $TMP_IMG
	python lib/stl_tools_helper.py  output.0.028.stl 0.028

	size=`ls -l output.0.028.stl | awk '{print $5}'`
	if [ $size -gt 4000000 ]
	then
		echo "correct size is ${var}%"
		for scale in 0.020 0.035 0.040 0.050
		do
			echo "generating STL $scale"
			python lib/stl_tools_helper.py output.${scale}.stl ${scale}
		done
		break
	fi
done
