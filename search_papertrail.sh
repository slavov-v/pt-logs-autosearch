#!/bin/bash

PAPERTRAIL_TOKEN="$1"
START_DATE="$2"
END_DATE="$3"
SEARCH_TERMS_BEGIN=4
SEARCH_TERMS_END=$#

AWK_ARG='$0'

# `curl` command from papertrail docs -> https://help.papertrailapp.com/kb/how-it-works/permanent-log-archives/#download-a-large-number-of-archives
curl -sH "X-Papertrail-Token: ${PAPERTRAIL_TOKEN}" https://papertrailapp.com/api/v1/archives.json |
  grep -o '"filename":"[^"]*"' | egrep -o '[0-9-]+' |
  awk "$AWK_ARG >= \"$START_DATE\" && $AWK_ARG < \"$END_DATE\" {
    print \"output \" $AWK_ARG \".tsv.gz\"
    print \"url https://papertrailapp.com/api/v1/archives/\" $AWK_ARG \"/download\"
  }" | curl --progress-bar -fLH "X-Papertrail-Token: ${PAPERTRAIL_TOKEN}" -K-


awk_cmd="/$4/"

for ((i=SEARCH_TERMS_BEGIN+1; i<=SEARCH_TERMS_END; i++)); do
    awk_cmd="${awk_cmd} && /${!i}/"
done

echo $awk_cmd

for filename in *.tsv.gz; do
    gunzip -c ${filename} | awk "${awk_cmd}"
done
