#!/bin/bash

IMG=$1
TMP_IMG=".tmp.img.png"

if [ "$IMG" == "" ]
then
	echo "Error: image file needed"
	echo "Usage: $0 path_to_image_file"
	exit
fi

for var in `seq 10 11`
do
	echo $var
	convert $IMG -resize ${var}% $TMP_IMG
	python lib/stl_tools_helper.py
	size=`ls -l $TMP_IMG | awk '{print $5}'`
	if [ $size -gt 4000000 ]
	then
		break
	fi
done
