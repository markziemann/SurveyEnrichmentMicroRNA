#!/bin/bash

# extract PMID and ISSN from PUBMED format data

for TXT in *set.txt ; do

  sed 's/^PMID/!PMID/' $TXT \
  | tr '\r' '\n' \
  | tr -d ' ' \
  | grep -v ^$ \
  | tr '\n' '\t' \
  | tr '!' '\n' > tmp.txt

  for PMID in $(cut -f1 tmp.txt | cut -d '-' -f2 ) ; do

    SEARCH="PMID-$PMID"
    IS=$(grep -w "$SEARCH" tmp.txt \
      | tr '\t' '\n' \
      | grep -m1 ^IS \
      | cut -d '(' -f1 \
      | cut -d '-' -f2- \
      | tr -d '-' )
    echo $SEARCH $IS | sed 's/PMID-//'

  done > $TXT.tsv

  rm tmp.txt

done
