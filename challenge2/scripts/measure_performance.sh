#!/bin/bash

src=$1
min_size=$2
max_size=$3
step=$4
seed=$5
output=$6

runs=5

echo "Compiling ..."
g++ -fopenmp -O1 ${src} -o lwd
echo "Compilation done."

echo "Creating output file ${output} ..."
echo "" > ${output}
echo "Output file created."

echo "Start profiling ..."
for ((size=${min_size};size<=${max_size};size += ${step})); do
    echo "Running size ${size} ..."
    time=0.0
    for ((i=0;i<${runs};i++)); do
        t=$(./build/old ${size} ${size} ${seed} | sed 's/[^0-9.]//g')
        time=$(echo "scale=5; ${time} + ${t}" | bc)
    done
    time=$(echo "scale=5; ${time} / 5" | bc)
    echo "${size};${time};" >> ${output}
    echo "${size}x${size} avg. time: ${time} (on ${runs} runs)"
done

rm lwd
echo "Output written in ${output}"
