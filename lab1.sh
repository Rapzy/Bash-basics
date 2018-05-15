 #!/bin/bash

PROGNAME=$(basename $0)

MIN_FSIZE=$1
MAX_FSIZE=$2
FOUT=$3

find "$PWD/" -type f \( -size +$MIN_FSIZE -and -size -$MAX_FSIZE -or -size $MIN_FSIZE -or -size $MAX_FSIZE \) -printf "%h/%f %f %s bytes\n" > $FOUT 2> errors.txt
echo "$PROGNAME: viewed $(wc -l < $FOUT) files"

exec 2>&1 
while read line
do
  echo "$PROGNAME: $line" 1>&2
done <errors.txt
exit 0
