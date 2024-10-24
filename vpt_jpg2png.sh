for img in "$@"; do
	filename=${img%.*}
	if [ ${img##*.} == jpg ];then 
		echo yes jpg
		echo $img
		convert "$filename.jpg" -quality 00 "$filename.png"
   	 fi
	if [ ${img##*.} == webp ];then
                echo yes jpg
                echo $img
                convert "$filename.webp" -quality 00 "$filename.png"
         fi
    rm "$img"

done
