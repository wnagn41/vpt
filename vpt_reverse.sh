export a=$@
echo $a
yt-dlp -o '~/Downloads/or.mp4' $a
ffmpeg -i ~/Downloads/or.mp4 -vf reverse -af areverse fdsdf.mp4
