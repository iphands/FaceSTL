#!/bin/bash

IMG=$1
TMP_IMG=".tmp.img.png"

if [ "$IMG" == "" ]
then
	echo "Error: image file needed"
	echo "Usage: $0 path_to_image_file"
	exit
fi

rm output*stl

echo "finding appropriate size"
for var in `seq 1 50`
do
	echo $var
	convert $IMG -resize ${var}% -background black -vignette 50x5000 -normalize $TMP_IMG

	python lib/stl_tools_helper.py output.stl 0.025 1

	size=`ls -l output.stl | awk '{print $5}'`
	if [ $size -gt 4000000 ]
	then
		echo "correct size is ${var}%"

		for blur in 1.0 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2.0
		do
			echo "generating STL with blur $blur"
			python lib/stl_tools_helper.py output.${blur}.stl 0.025 ${blur}
		done

		break
	fi
done
