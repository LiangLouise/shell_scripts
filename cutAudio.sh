#!/bin/bash

if ! [ -x "$(command -v ffmpeg)" ]; then
    echo "No ffmpeg"
    echo "Use suo apt install ffmpeg"
    exit 1
fi

# Cut the audio from $1 to $2 in format 00:01:12
ffmpeg -i p2.flv -ss $1 -to $2 -ac 2 -vn "$3" 


# Add Cover $4 and overwrite to the audio $3
ffmpeg -y -i "$3" -i "$4" 
	\ -map 0:0 -map 1:0 -c copy -id3v2_version 3 -metadata:s:v title="Album cover" 
	\ -metadata:s:v comment="Cover (Front)" "$3"