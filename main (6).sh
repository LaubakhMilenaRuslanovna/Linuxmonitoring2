
#!/bin/bash

# Обработка параметров
if [ "$#" -ne 3 ]; then
    echo "Ошибка: скрипт должен быть запущен с 3 параметрами."
    echo "Попробуй написать это: az az.az 3Mb"
    exit 1
fi

# Проверка параметров
if [ ${#1} -gt 7 ] || [ ${#2} -gt 7 ] || [ ${#3} -gt 3 ]; then
    echo "Ошибка: длина алфавита для папок не должна превышать 7 символов."
    echo "Попробуй написать это: az az.az 3Mb"
    exit 1
fi

# Проверка размера файла

if [ $3 -gt 100 ]; then
     echo "Ошибка: размер файла не должен превышать 100 Мб."
     echo "Попробуй написать это: az az.az 3Mb"
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

# Запись логов
start_time=$(date +%s)
echo "Время начала работы скрипта: $(date)" >> log.txt

# Проверка свободного места
free_space=$(df -h / | tail -1 | awk '{print $4}')
if [ $free_space -lt 1 ]; then
    echo "Недостаточно свободного места в файловой системе"
    exit 1
fi

# Создание папок и файлов
directories=$(find / -maxdepth 1 -type d | grep -v -e "bin" -e "sbin")
for directory in $directories
do
    # Создание папки
    folder_name="$1$2_$(date +%d%m%y)"
    mkdir "$directory/$folder_name"
    echo "Создана папка $directory/$folder_name" >> log.txt

    # Создание файлов
    files_number=$((RANDOM % 100))
    for ((i=1; i<=$files_number; i++))
    do
        file_name="$1$2.$3"
        touch "$directory/$folder_name/$file_name"
        echo "Создан файл $directory/$folder_name/$file_name" >> log.txt
    done
done

# Проверка свободного места
free_space=$(df -h / | tail -1 | awk '{print $4}')
if [ $free_space -lt 1 ]; then
    echo "Недостаточно свободного места в файловой системе"
    exit 1
fi

# Запись логов
end_time=$(date +%s)
echo "Время окончания работы скрипта: $(date)" >> log.txt
echo "Общее время работы скрипта: $((end_time - start_time)) секунд" >> log.txt

echo "Время начала работы скрипта: $(date)"
echo "Время окончания работы скрипта: $(date)"
echo "Общее время работы скрипта: $((end_time - start_time)) секунд"