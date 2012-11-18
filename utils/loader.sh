#!/bin/bash
#
# Simple CPU loader by Vladislav Belogrudov
# vlad.belogrudov@gmail.com
# 



trap 'kill -9 `jobs -p` &> /dev/null; exit 1' SIGINT

if [[ 0 -eq $# ]]
then
    echo "I need arguments! please specify list of cpuload,time pairs, e.g. 10,20 30,45"
    exit 1
fi

nproc=`grep processor /proc/cpuinfo | wc -l`
echo "number of CPUs = $nproc"

loads="$@"

while true
do
    for pair in $loads
    do
        echo "current load pair = $pair"
        set -- `echo $pair | tr ',' ' '`
        mylimit=$1 
        mytime=$2
        [[ $mylimit -eq 0 ]] && sleep $mytime && continue
        echo "running at $mylimit% for $mytime seconds"
        for (( i = 0; i < $nproc; ++i ))
        do
            echo "spawning load #$i"
            cat /dev/urandom  &> /dev/null &
            cpulimit -l $mylimit -p $! &> /dev/null &
        done
        sleep $mytime
        for pid in `jobs -p 2>/dev/null`
        do
            kill -9 $pid &> /dev/null
        done
    done
done
