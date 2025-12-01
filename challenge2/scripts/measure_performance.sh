#!/bin/bash

src=$1
min_size=$2
max_size=$3
step=$4
seed=$5
size_output=$6
step_output=$7

runs=2

echo "Compiling ..."
g++ -fopenmp -O1 ${src} -o lwd
echo "Compilation done."

echo "Creating output files ${size_output} ${step_output} ..."
echo "" > ${size_output}
echo "" > ${step_output}
echo "Output files created."

echo "Start profiling ..."
for ((size=${min_size};size<=${max_size};size += ${step})); do
    echo "Running size ${size} ..."
    time=0.0
    steps=0
    for ((i=0;i<${runs};i++)); do
        t=$(./lwd ${size} ${size} ${seed} | grep "time" | sed 's/[^0-9.]//g')
        s=$(./lwd ${size} ${size} ${seed} | grep "steps" | sed 's/[^0-9.]//g')
        time=$(echo "scale=5; ${time} + ${t}" | bc)
        steps=$(echo "${steps} + ${s}" | bc)
    done
    time=$(echo "scale=5; ${time} / ${runs}" | bc)
    steps=$(echo "${steps} / ${runs}" | bc)
    cells=$(echo "${size} * ${size} * ${steps}" | bc)
    echo "${size};${time};" >> ${size_output}
    echo "${cells};${time};" >> ${step_output}
    echo "${size}x${size}; steps: ${steps}; avg. time: ${time} (on ${runs} runs)"
done

rm lwd
echo "Output written in ${size_output} and ${step_output}"
