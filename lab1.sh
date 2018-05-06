 #!/bin/bash

PROGNAME=$(basename $0)

MIN_FSIZE=$1
MAX_FSIZE=$2
FOUT=$3

files=$(find . -type f -size +$MIN_FSIZE -and -size -$MAX_FSIZE -or -size $MIN_FSIZE -or -size $MAX_FSIZE 2> errors.txt)
for file in $files
do
  echo $(realpath $file) $(basename $file) $(wc -c < $file) 'bytes' 2>> errors.txt >> $FOUT
done
echo "$PROGNAME: viewed $(wc -l <<< $files) files"
exit 0
