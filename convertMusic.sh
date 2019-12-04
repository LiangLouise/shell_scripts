#!/bin/bash

flacFiles="*.flac"
outputDir="MP3OUT"
cur="$(pwd)"

if ! [ -x "$(command -v ffmpeg)" ]; then
    echo "No ffmpeg"
    echo "Use suo apt install ffmpeg"
    exit 1
fi

if ! [ -x "$(command -v parallel)" ]; then
    echo "No gnu parallel"
    echo "Use suo apt install parallel"
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

parallel --jobs 5 ffmpeg -hide_banner -i "{2}/{1}" -qscale:a 0 "{2}/{3}/{1.}.mp3" ::: $flacFiles ::: "$cur" ::: $outputDir

exit 0