#!/bin/bash
read -p "Please enter name of new video:" videoname
mkdir ./${videoname}
cd ./${videoname}

function name {
IFS=$'\n'
for file2 in $p
do
echo $file2
echo -e "2 \n 2 \n  2 \n   2 \n    2 \n     2 \n       2 \n         2 \n           2 \n              2 \n"
if [ -d "$file2" ] ;then
	n=1
	n+=1
##	echo $n
	p=`ls -d  "$file2"/*`
	echo $p
	name
else
	echo file "'""$file2""'" >> ${videoname}.txt
fi
done
}
for file1 in "$@";do
if [ -d "$file1" ] 
then
	p=`ls -d "$file1"`
	name
else
        echo file "'""$file1""'" >> ${videoname}.txt
	echo -e "2 \n 2 \n  2 \n   2 \n    2 \n     2 \n       2 \n         2 \n           2 \n              2 \n"

fi
done

cd ./${videoname}


l=`cat "$videoname".txt | wc -l`
printf "00:01" >> "$videoname"chapter_list.txt
l=$((l+1))
l=$((l-1))
k=1
IFS=$'\n'
for i in `cut -d"'" -f 2 ./${videoname}.txt`;do
	echo $i
	j=`ffmpeg -i "$i" 2>&1 | grep "Duration"| cut -d ' ' -f 4 | cut -d ',' -f 1`
	minutes=$(echo "$j" | cut -d":" -f2 | cut -d"." -f3)
	seconds=$(echo "$j" | cut -d":" -f3 | cut -d"." -f1)
	millis=$(echo "$j" | cut -d":" -f3 | cut -d"." -f2)

##	echo $minutes
##	echo $seconds

	currentMillis=$(( 10#$millis+10#$seconds*1000+10#$minutes*60000))
        totalMillisOne=$(( 10#$currentMillis + 10#$totalMillisOne))
##	echo $j
##	echo $totalMillisOne
	
	avSeconds=$(( $totalMillisOne/1000 ))
	avMillis=$(( $avMillis-$avSeconds*1000))
	avMinutes=$(( $avSeconds/60))
	avSeconds=$(( $avSeconds-$avMinutes*60))

	echo "${avMinutes}:${avSeconds}:${avMillis}"
	pq=${i##*/}
        q=${pq%.*}
	echo " "$q >> "$videoname"chapter_list.txt
##	echo 'l======' $l
##	echo 'k=========' $k
	if [ 1 -eq 1 ];then
		if [ "$l" != "$k" ];then
	        	printf "${avMinutes}:${avSeconds}" >> "$videoname"chapter_list.txt
		fi
	fi
	k=$((k+1))
##	echo dfdasd
done

format=${pq##*.}
##echo "format=========="$format

ffmpeg -f concat -safe 0 -i ${videoname}.txt -vcodec copy -acodec copy ${videoname}output.${format}

if [ 1 -eq 1 ];then
	rm ${videoname}.txt
fi
cd ..
pwd
echo -e "\a"
