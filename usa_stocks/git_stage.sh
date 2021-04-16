#!/bin/bash

file_list="/tmp/download.file.list"
today="$(date -I)"

git status | grep modified | sed 's/.* //g' > ${file_list}

for i in $(cat ${file_list})
do
    if tail -n 1 ${i} | grep "${today}" > /dev/null
    then
        git add ${i}
    else
        echo "$i : missing data ${today}"
    fi
done

rm ${file_list}


