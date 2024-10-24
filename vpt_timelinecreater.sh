currentMillis=0
avMillis=0
totalMillisOne=0
printf "00:01" >> music_list.txt
n=0
for i in "$@";do
	let n=n+1
##	echo $n
##	echo "\n"
##      printf "${avMinutes}:${avSeconds}" >> music_list.txt
	if ((n != 1));then printf %02d "${avMinutes}" >> music_list.txt;fi
	if ((n != 1));then printf ":" >> music_list.txt;fi
	if ((n != 1));then printf %02d "${avSeconds}" >> music_list.txt;fi
	j=`ffmpeg -i "$i" 2>&1 | grep "Duration"| cut -d ' ' -f 4 | cut -d ',' -f 1`
	minutes=$(echo "$j" | cut -d":" -f2 | cut -d"." -f3)
	seconds=$(echo "$j" | cut -d":" -f3 | cut -d"." -f1)
	millis=$(echo "$j" | cut -d":" -f3 | cut -d"." -f2)

	echo $minutes
	echo $seconds
	echo $millis

	currentMillis=$(( 10#$millis+10#$seconds*1000+10#$minutes*60000))
        totalMillisOne=$(( 10#$currentMillis + 10#$totalMillisOne))
	echo $j
	echo $totalMillisOne
	
	avSeconds=$(( $totalMillisOne/1000 ))
	echo $avSeconds
	avMillis=$(( -$avMillis+$avSeconds*1000))
	echo $avMillis
	avMinutes=$(( $avSeconds/60))
	echo $avSeconds
	avSeconds=$(( $avSeconds-$avMinutes*60))
	echo $avSeconds

	echo "${avMinutes}:${avSeconds}"
	q=${i##*/}
	q=${q%.*}
	echo " "$q >> music_list.txt


	echo dfdasd
done
