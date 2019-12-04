#!/bin/bash

flacFiles="*.flac"
outputDir="MP3OUT"


if ! [ -x "$(command -v ffmpeg)" ]; then
    echo "No ffmpeg"
    exit 1
fi

if ! [ -x "$(command -v parallel)" ]; then
    echo "No ffmpeg"
    exit 1
fi

if [ -d "$outputDir" ]; then
    rm -r "$outputDir"
fi

mkdir "$outputDir"

# for a in $flacFiles; do
#     fileName="${a%%.flac}"
#     out="$(pwd)/$outputDir/$fileName.mp3"
#     ffmpeg -i "$(pwd)/$a" -qscale:a 0 "$out"
# done

parallel 'ffmpeg -i $(pwd)/{1} -qscale:a 0 $(pwd)/{2}/{1.}.mp3' ::: *.flac ::: $outputDir


exit 0