#!/bin/bash
for file in "$@";do
	echo $file
	file_new=$(echo "$file" | tr ' （）' '__')
	echo $file_new	
	mv "$file" "$file_new"

done
