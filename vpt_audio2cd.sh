#!/bin/bash
##read -p "Please enter picture address:" picture
##read -p "Please enter audio address:" audio
read -p "Please enter name of new cd:" cdname

##cdname=甲铁城的卡巴內瑞_海门决战_主题曲_instrumental
##pictureaddress=\'$picture\'
##IFS=$'\n'
##for i in "$@";do
##	echo file "'"$i"'" >> ${cdname}picture.txt
##done
##ffmpeg -f concat -safe 0 -i picture.txt  -c:v libx264 -pix_fmt yuv420p -vf "scale=w=1920:h=1080:force_original_aspect_ratio=1,pad=1920:1080:(ow-iw)/2:(oh-ih)/2" -r 24 -y ${cdname}video.mp4
##echo "ffmpeg -framerate 0.2 -i $picture -c:v libx264 -pix_fmt yuv420p -vf "scale=w=1920:h=1080:force_original_aspect_ratio=1,pad=1920:1080:(ow-iw)/2:(oh-ih)/2" -r 24 -y "$cdname"video.mp4"

currentMillis=0
avMillis=0
totalMillisOne=0
IFS=$'\n'
##read -p "Please enter picture address:" picture
printf "00:01" >> "$cdname"_chapter_list.txt
n=0
for i in "$@";do
	let n=n+1
##	echo $n
##	echo "\n"
##        printf "${avMinutes}:${avSeconds}" >> "$cdname"_chapter_list.txt
	if ((n != 1));then printf %02d "${avMinutes}" >> "$cdname"_chapter_list.txt;fi
	if ((n != 1));then printf ":" >> "$cdname"_chapter_list.txt;fi
	if ((n != 1));then printf %02d "${avSeconds}" >> "$cdname"_chapter_list.txt;fi
	j=`ffmpeg -i "$i" 2>&1 | grep "Duration"| cut -d ' ' -f 4 | cut -d ',' -f 1`
	minutes=$(echo "$j" | cut -d":" -f2 | cut -d"." -f3)
	seconds=$(echo "$j" | cut -d":" -f3 | cut -d"." -f1)
	millis=$(echo "$j" | cut -d":" -f3 | cut -d"." -f2)

##	echo $minutes
##	echo $seconds
##	echo $millis

	currentMillis=$(( 10#$millis+10#$seconds*1000+10#$minutes*60000))
        totalMillisOne=$(( 10#$currentMillis + 10#$totalMillisOne))
##	echo $j
##	echo $totalMillisOne
	
	avSeconds=$(( $totalMillisOne/1000 ))
##	echo $avSeconds
	avMillis=$(( -$avMillis+$avSeconds*1000))
##	echo $avMillis
	avMinutes=$(( $avSeconds/60))
##	echo $avSeconds
	avSeconds=$(( $avSeconds-$avMinutes*60))
##	echo $avSeconds

##	echo "${avMinutes}:${avSeconds}"
	q=${i##*/}
	q=${q%.*}
	echo " "$q >> "$cdname"_chapter_list.txt


	echo dfdasd
done

IFS=" "
audiolist=" "
n=0
for i in "$@";do
##	echo "$i"
	audiolist="$audiolist""-i"' '"$i"" "
	echo $audiolist
	n=`expr $n + 1`
done


##echo "ffmpeg -i $picture $audiolist -filter_complex "concat=n=$n:v=0:a=1" -vcodec mjpeg -y input.mkv"
##ffmpeg -i $picture $audiolist -filter_complex "concat=n=$n:v=0:a=1" -vcodec mjpeg -y input.mkv
##echo "ffmpeg -i /Users/wangnuoqian/Downloads/51D7oKK5T3S._SY500__AC_SY400_.jpg  $audiolist -filter_complex "concat=n=$n:v=0:a=1" -vcodec mjpeg -y input.mkv"
ffmpeg  -i /Users/wangnuoqian/Downloads/51D7oKK5T3S._SY500__AC_SY400_.jpg  $audiolist -filter_complex "concat=n=$n:v=0:a=1" -c:v mjpeg -c:a aac -b:a 700k -y "$cdname"audio.mp4
##echo "ffmpeg -i /Users/wangnuoqian/Downloads/51D7oKK5T3S._SY500__AC_SY400_.jpg  $audiolist -filter_complex "concat=n=$n:v=0:a=1" -vcodec mjpeg -acodec aac -y input.mp4"
echo "videocompletedvideocompletedvideocompletedvideocompletedvideocompletedvideocompletedvideocompletedvideocompleted
videocompletedvideocompletedvideocompletedvideocompletedvideocompletedvideocompletedvideocompleted
videocompletedvideocompletedvideocompletedvideocompletedvideocompletedvideocompletedvideocompleted
videocompletedvideocompletedvideocompletedvideocompletedvideocompletedvideocompletedvideocompleted
videocompletedvideocompletedvideocompletedvideocompletedvideocompletedvideocompletedvideocompleted"


##ffmpeg -framerate 0.2 -pattern_type glob -i $picture  -c:v libx264 -pix_fmt yuv420p -vf "scale=w=1920:h=1080:force_original_aspect_ratio=1,pad=1920:1080:(ow-iw)/2:(oh-ih)/2" -r 24 -y "$cdname"video.mp4



ffmpeg -stream_loop -1 -i "$cdname"video.mp4 -i "$cdname"audio.mp4 -map 0:v:0 -map 1:a:0 -c:a copy -shortest -y $cdname.mp4

##rm "$cdname"video.mp4
rm "$cdname"audio.mp4
