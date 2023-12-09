#!/bin/bash

echo "Пожалуйста, выберите способ удаления созданных файлов:"
echo "1 - Удалить файлы, используя log file"
echo "2 - По дате и времени создания"
echo "3 - По маске имени"

read method

if [ -z $method ]
then
	echo "Вам следует выбрать один из способов удаления. Пожалуйста, попробуйте снова"
	exit 1
fi

if ! [[ $method =~ [1-3] ]]
then 
	echo "Есть только три допустимых метода(1/2/3)"
	exit 1
fi

case $method in
	1)
		bash clean_space_log.sh
		;;
	2)
		bash clean_space_date_and_time.sh
		;;
	3)
		bash clean_space_mask.sh
esac

