#!/bin/bash

FORMAT=`printf '%%I,\\\"%%t\\\",\\\"%%as\\\",%%S'`


########################################################################################################################
# REPOSITORY REPORT
########################################################################################################################
# Append to 'report.csv' a list of issues with sprint and size tags
function append_repo_report() {
  CMD=""
  for SIZE in 1 2 3 5 8 13
  do
    if [ ! -z "$CMD" ]; then
      CMD="$CMD &&"
    fi
    CMD="$CMD hub issue -s all -l sprint -L 100 --format \"$FORMAT,$SIZE%n\" -l "size:$SIZE""
  done

  CMD="{ $CMD; }"

  eval $CMD >> ../report.csv
}

if [ -f 'report.csv' ]; then
  rm -i report.csv
fi

for repo in "$@"
do
  cd $repo
  append_repo_report
  cd ".."
done
