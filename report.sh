#!/bin/bash

FORMAT=`printf '%%I,\\\"%%t\\\",\\\"%%as\\\",%%S'`

CMD=""
for SIZE in 1 2 3 5 8 13
do
  if [ ! -z "$CMD" ]; then
    CMD="$CMD &&"
  fi
  CMD="$CMD hub issue -s all -l sprint -L 100 --format \"$FORMAT,$SIZE%n\" -l "size:$SIZE""
done

CMD="{ $CMD; }"

eval $CMD > report.csv
