#!/bin/bash

file_list="/tmp/download.file.list"
today="$(date -I)"

restore=0
if [ "$1" == "--restore" ]
then
    restore=1
fi

git status | grep csv | grep modified | sed 's/.* //g' > ${file_list}

for i in $(cat "${file_list}")
do
    if tail -n 1 ${i} | grep "${today}" > /dev/null
    then
        git add ${i}
    else
        echo "$i : missing data ${today}"
        if [ ${restore} -eq 1 ]
        then
            git restore ${i}
        fi
    fi
done

rm ${file_list}

