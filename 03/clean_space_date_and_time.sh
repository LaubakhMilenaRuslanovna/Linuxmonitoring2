#!/bin/bash/

    echo "Введите дату и время (пример: ГГГГ-ММ-ДД ЧЧ:ММ)"
    read -p "Напишите дату и время начала: " start
    echo "Введите дату и время (пример: ГГГГ-ММ-ДД ЧЧ:ММ)"
    read -p "Напишите дату и время окончания: " end
    files=`sudo find / -newermt "$start" ! -newermt "$end"  2>/dev/null | sort -r`
    for i in $files
    do
        last=$(echo $i | awk -F"/" '{ print $NF }')
        if [[ $last =~ "." ]]
        then
            sudo rm -rf $i
        fi
    done
