#!/bin/sh

# Скрипт для запуска на виртуалках для имитации бурной деятельности. Добавить в кронтаб.
# Запускать с аргументом - количество итераций.

if [ $# -ne 1 ]
	then echo Usage: sh proc_load.sh iterations; exit
fi


ITERATIONS=$1
ITERATIONS=$((ITERATIONS * 1000))

for i in `seq $ITERATIONS`
do
	a=$((t*i))
done
