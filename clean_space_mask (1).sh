#!/bin/bash

    echo "входные данные должны быть такими: foldername_$(дата '+%d%m%y') или filename_$(дата '+%d%m%y').ext"
    read -p "введите маску имени: " nameMask
    name=$(echo $nameMask | awk -F"_" '{ print $1 }')
    end=$(echo $nameMask | awk -F"_" '{ print $2 }')
    sudo rm -rf $(find / -type f -name "*$name*$end" 2>/dev/null)
    sudo rm -rf $(find / -type d -name "*$name*$end" 2>/dev/null)