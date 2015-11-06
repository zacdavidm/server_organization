#!/bin/bash
SITES=("/var/www/example.org")
ENVS=("prod" "staging" "updates" "dev1")
DIRS=("backups" "html" "logs" "scripts" "shared")
for i in "${SITES[@]}"
do
  mkdir -p $i
  cd $i
  for j in "${ENVS[@]}"
  do
  	mkdir -p $j
    cd $j
    for k in "${DIRS[@]}"
    do
      mkdir -p $k
    done
    cd ..
  done

done
