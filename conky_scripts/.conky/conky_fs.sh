#!/bin/bash

DRIVES="$(df -h --output=source,fstype,used,size,pcent,target  | grep '^/dev')"

IFS=$'\n'
for WORD in `echo "${DRIVES}" | cat`
do
    echo $WORD | grep 'sr0' &> /dev/null
    if [ $? -eq 0 ]
    then
        DIR="dvd rom"
    else
        DIR="$(basename $(echo ${WORD} | awk '{print $6}'))"
    fi

    PERC="$(echo $WORD | awk '{print $5}' | grep -o -E '[0-9]+')"

    if [ $PERC -eq 100 ] || [ $PERC -lt 50 ]
    then
        COLOR2="\${color2}"
    elif [ $PERC -lt 75 ]
    then
        COLOR2="\${color3}"
    elif [ $PERC -lt 85 ]
    then
        COLOR2="\${color4}"
    elif [ $PERC -lt 95 ]
    then
        COLOR2="\${color5}"
    else
        COLOR2="\${color6}"
    fi

    printf "\${color1}┣━${DIR}\$alignr${COLOR2}\${fs_used $(echo ${WORD} | awk '{print $6}')}\${color1}/${COLOR2}\${fs_size $(echo ${WORD} | awk '{print $6}')}\n\${color1}┃ ${COLOR2}\${fs_bar 5 $(echo ${WORD} | awk '{print $6}')}\n\${color1}┃\n"
done
