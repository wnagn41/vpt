#!/bin/bash
function name {
IFS=$'\n'
for file2 in $p
do
echo $file2
echo -e "2 \n 2 \n  2 \n   2 \n    2 \n     2 \n       2 \n         2 \n           2 \n              2 \n"
if [ -d "$file2" ] ;then
	n=1
	n+=1
	echo $n
	p=`ls -d  "$file2"/*`
	echo $p
	name
elif [ ${file2##*.} == mkv ] ;then
	echo "$file2"
        ffmpeg -i "$file2" -c:a copy -c:v copy -strict -2  "$file2".mp4
	echo -e "\a"
fi
done
}


for file1 in "$@";do
if [ -d "$file1" ] 
then
	cp -R "$file1" "$file1"mp4ver
	p=`ls -d "$file1"mp4ver/*`
	name
elif [ ${file1##*.} == mkv ] 
then
        ffmpeg -i "$file1" -c:a copy -c:v copy -strict -2  "$file1".mp4
	echo "ffmpeg -i "$file1" -c:a copy -c:v copy -strict -2  "$file1".mp4"

	echo -e "\a"
fi
done
