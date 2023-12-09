#!/bin/bash

    logs="$(cat ../02/log.txt | awk -F'  ' '{print $1}'))"
    reg='^\/'
    for i in $logs:
    do
        if [[ $i =~ $reg ]]
        then
            sudo rm -rf $i
        fi
    done
