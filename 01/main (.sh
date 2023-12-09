#!/bin/bash

if [ $# -ne 6 ] 
then
    echo "Ошибка! Неверное количество аргументов."
    echo "Пример:  /opt/test 4 az 5 az.az 3kb"
    exit 1
fi

#Параметр 1 - это абсолютный путь.
path=$1
last=$(echo "{path}" | tail -c 2)
if [[$last == "/"] || ![-d $path]]
then
    echo "Неправильный путь, он должен быть абсолютным"
    exit 1
fi


#Параметр 2 - количество вложенных папок(число).
re1='^[1-9][0-9]+?$'
if ! [[ $2 =~ $re1 ]]
then
    echo "Второе значение или не равно числу или меньше одного"       
    exit 1
fi

#Параметр 3 - список букв английского алфавита, используемый в названии папок (не более 7 знаков).
re2='^[a-zA-Z]{1,7}$'
if ! [[ $3 =~ $re2 ]]
then
    echo "Третье знаение это только буквы и не  более 7 букв"  
    exit 1
fi

#Параметр 4 - количество файлов в каждой созданной папке(число)
if ! [[ $4 =~ $re1 ]]
then
    echo "Четвертый аргумент не является целым числом или меньше 1"
    exit 1
fi

if [[ $p4 =~ [^0-9] ]]; then
    echo "{$p4}: колличество файлов в каждой папке некорректно!"
    exit 1
fi


if [[ $p4 -gt 100 ]]; then
    echo "{$p4}: папки засорены файлами!"
    exit 1
fi

#Параметр 5 - список букв английского алфавита
#Используемый в имени файла и расширении (не более 7 знаков для имени, не более 3 знаков для расширения)
re3='^[a-zA-Z]{1,7}[.][a-zA-Z]{1,3}$'
if ! [[ $5 =~ $re3 ]]
then
    echo "Имя файла должно содержать менее 7 букв, а расширение - от 1 до 3 букв"
    exit 1
fi

#Параметр 6 - размер файлов (в килобайтах, но не более 100).
re4='^[1-9][0-9]?[0]?kb$'
if ! [[ $6 =~ $re4 ]]
then
    echo "Размер должен заканчиваться на кб и не превышать 100"
    exit 1
fi

# Проверяем, что в списке символов есть хотя бы один символ "az"
chars=$1$2

if [[ $chars =~ "az" ]]; then
  # Если есть "az", то удаляем его из списка символов
  chars=${chars//az/}
  # Устанавливаем флаг, который будет использоваться для проверки порядка символов в именах
  reverse=true
else
  reverse=false
fi

# Проверка наличия достаточного свободного места на файловой системе
free_space=$(df -k --output=avail / | awk 'NR==2{print $1}')
if [ "$free_space" -lt 1000000 ]; then
  echo "Ошибка: Недостаточно свободного места на файловой системе."
  exit 1
fi


start_time=$(date +%s)
echo "Дата начала работы скрипта: $(date)">> l.log


# Создаем папки и файлы
for ((i=1; i<=$2; i++)); do
  date=$(date +%d%m%y)
  folder_chars=$(echo "$3" | fold -w1 | shuf | tr -d '\n' | head -c4)
  folder_name="$1/$folder_chars$date"
  mkdir "$folder_name"
  for ((j=1; j<=$4; j++)); do
    file_chars=$(echo "$5" | fold -w1 | shuf | tr -d '\n' | head -c4)
    file_name="$folder_name/$file_chars$date"
    dd if=/dev/urandom of="$file_name" bs=1024 count=$6 >/dev/null 2>&1
    echo "$file_name $(date +%d.%m.%Y) $6" >> l.log
  done
done

echo "Создание папок и файлов завершено!"

# Проверка наличия достаточного свободного места на файловой системе
free_space=$(df -k --output=avail / | awk 'NR==2{print $1}')
if [ "$free_space" -lt 1000000 ]; then
  echo "Ошибка: Недостаточно свободного места на файловой системе."
  exit 1
fi

# Запись логов
end_time=$(date +%s)
echo "Время окончания работы скрипта: $(date)" >> l.log
echo "Общее время работы скрипта: $((end_time - start_time)) секунд" >> l.log

echo "Время начала работы скрипта: $(date)"
echo "Время окончания работы скрипта: $(date)"
echo "Общее время работы скрипта: $((end_time - start_time)) секунд"