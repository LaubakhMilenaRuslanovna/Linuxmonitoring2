#!/bin/bash

# Коды ответа:
# 200 - ОК
# 201 - создан
# 400 - неверный запрос
# 401 - не авторизован
# 403 - запрещено
# 404 - не найдено
# 500 - внутренняя ошибка сервера
# 501 - не реализовано
# 502 - неверный шлюз
# 503 - сервис недоступен


# Функция для генерации случайного числа в заданном диапазоне
# Принимает два аргумента: минимальное и максимальное значение
# Возвращает случайное число
function random_number() {
  local min=$1
  local max=$2
  echo $((min + RANDOM % (max - min + 1)))
}

# Массивы с возможными значениями для каждого поля
ip=("192.168.0.1" "10.0.0.2" "172.16.0.3" "192.168.1.4" "10.0.0.5")
status=("200" "201" "400" "401" "403" "404" "500" "501" "502" "503")
methods=("GET" "POST" "PUT" "PATCH" "DELETE")
user_agents=("Mozilla" "Google Chrome" "Opera" "Safari" "Internet Explorer" "Microsoft Edge" "Crawler and bot" "Library and net tool")

# Функция для генерации случайной даты в формате "день/месяц/год:час:минута:секунда"
# Принимает один аргумент: дату в формате "день/месяц/год"
# Возвращает случайную дату в указанном формате
function random_date() {
  local date=$1
  local hour=$(random_number 0 23)
  local minute=$(random_number 0 59)
  local second=$(random_number 0 59)
  echo "$date:$hour:$minute:$second"
}

# Функция для генерации случайного URL запроса агента
# Возвращает случайный URL запрос агента
function random_url() {
  local urls=("http://example.com/page1" "http://example.com/page2" "http://example.com/page3" "http://example.com/page4" "http://example.com/page5")
  echo ${urls[$((RANDOM % ${#urls[@]}))]}
}

# Функция для генерации случайного агента
# Возвращает случайный агент
function random_user_agent() {
  echo ${user_agents[$((RANDOM % ${#user_agents[@]}))]}
}

# Генерация логов
for i in {1..5}; do
  log_file="access$i.log"
  start_date=$(date -d "-$i day" +"%d/%b/%Y")
  end_date=$(date -d "-$((i-1)) day" +"%d/%b/%Y")

  num_records=$(random_number 100 1000)

  for ((j=0; j<$num_records; j++)); do
    ip_address=${ip[$((RANDOM % ${#ip[@]}))]}
    status_code=${status[$((RANDOM % ${#status[@]}))]}
    method=${methods[$((RANDOM % ${#methods[@]}))]}
    date=$(random_date $start_date)
    url=$(random_url)
    user_agent=$(random_user_agent)

 echo "$ip_address - - [$date]: "$method $url HTTP/1.1" $status_code $(random_number 100 10000) "$user_agent"" >> $log_file
done

echo "Сгенерировано $num_records записей в логе $log_file"
echo "Даты: с $start_date по $end_date"
done

# Комментарии:
# 1. Функция `random_number()` генерирует случайное число в заданном диапазоне, используя встроенную команду `RANDOM` в bash.
# 2. Массивы `ip`, `status`, `methods` и `user_agents` содержат возможные значения для каждого поля, из которых случайным образом выбираются значения при генерации логов.
# 3. Функция `random_date()` генерирует случайную дату в формате "день/месяц/год:час:минута:секунда" на основе заданной даты.
# 4. Функции `random_url()` и `random_user_agent()` выбирают случайные значения из соответствующих массивов.
# 5. В основной части скрипта используется цикл для генерации указанного количества записей в логах, с использованием случайно выбранных значений для каждого поля. Записи добавляются в соответствующий файл лога с использованием оператора `>>`, который добавляет данные в конец файла без перезаписи его содержимого.
# 6. Выводится информация о количестве сгенерированных записей и датах, за которые сгенерированы логи.

