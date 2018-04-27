#!/bin/bash

PROGNAME=$(basename $0)

MIN_FSIZE=$1
MAX_FSIZE=$2
FOUT=$3

function is_positive_integer
{
    local num=$1
    return $([[ $num =~ ^(0|[1-9][0-9]*)$ ]])
}

if [ $# -lt 3 ]
    then
        echo "$PROGNAME: missing operand"
        exit 1
    elif ! is_positive_integer $MIN_FSIZE
    then
        echo "$PROGNAME: first argument must be a positive integer"
        exit 1
    elif ! is_positive_integer $MAX_FSIZE
    then
        echo "$PROGNAME: second argument must be a positive integer"
        exit 1
    elif [ $MAX_FSIZE -lt $MIN_FSIZE ]
    then
        echo "$PROGNAME: min size can not be greater than max size"
        exit 1
    fi

truncate -s 0 $FOUT 
files=$(find . -type f)
for file in $files
do
  fsize=$(wc -c < $file)
  if [[ $fsize -ge $MIN_FSIZE &&  $fsize -le $MAX_FSIZE ]]; then
  	echo $(realpath $file) $(basename $file) $fsize 'bytes' >> $FOUT 
	fi
done
echo "$PROGNAME: viewed $(wc -w <<< $files) files"
exit 0
