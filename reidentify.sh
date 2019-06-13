#!/bin/bash

# dir = 0, neither given; dir = 1, use -s; dir = 2, use -u
dir=0
# markop = 0, use -b; markop = 1, use -0; markop = 2, use -q
markop=0

while getopts ":sub0q" arg; do
    case $arg in
        s )
        # dir: Markus -> Registar
        dir=1
    	field1=2
    	field2=1
        shift
        ;;
        u )
        # dir: Registar -> Markus
        dir=2
	    field1=1
    	field2=1
        shift
        ;;
        b )
        # Include student not in mark file with empty mark
        markop=0
        shift
        ;;
        0 )
        # Include student not in mark file with 0 mark
        markop=1
        shift
        ;;
        q )
        # Exclude Student not in mark file
        markop=2
        shift
        ;;
        * )
        # ignore Unknown option
        shift
        ;;
    esac
done

if [ $# -ne 2 ]; then
    echo "Please give both enrollment and mark file"
    exit 1
fi

if [ $dir -eq 0 ]; then
    echo "Please ditermine the direction of conversion"
    exit 1
fi

if [ $markop -eq 0 ]; then
    all=$(sort -t "," -k $field1 $1 | join -1 $field1 -2 $field2 -t "," -a 1 -o auto - $2)
elif [ $markop -eq 1 ]; then
    all=$(sort -t "," -k $field1 $1 | join -1 $field1 -2 $field2 -t "," -a 1 -o auto -e 0 - $2)
else
    all=$(sort -t "," -k $field1 $1 | join -1 $field1 -2 $field2 -t "," - $2)
fi

echo "$all" | cut -d "," -f 1 --complement
