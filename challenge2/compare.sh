#!/bin/bash

lwd=$1
new_lwd=$2
seed=$3
max_size=$4
lwd_file="csv/lwd_${seed}.csv"
new_lwd_file="csv/new-lwd_${seed}.csv"

echo "Compiling ..."
mkdir build
mkdir csv
g++ -fopenmp -O1 -DDISABLE_SEQUENTIAL=true ${lwd}.cpp -o build/lwd
g++ -fopenmp -O1 -DDISABLE_SEQUENTIAL=true ${new_lwd}.cpp -o build/new-lwd
echo "Compilation done."

echo "Creating output files ${lwd_file} ${new_lwd_file} ..."
echo "" > ${lwd_file}
echo "" > ${new_lwd_file}
echo "Output files created."

for ((size=11;size<${max_size};size += 100)); do
    echo "Running size ${size} ..."
    time=$(./build/lwd ${size} ${size} ${seed} | sed 's/[^0-9.]//g')
    echo "${size};${time};" >> ${lwd_file}
    time=$(./build/new-lwd ${size} ${size} ${seed} | sed 's/[^0-9.]//g')
    echo "${size};${time};" >> ${new_lwd_file}
done

echo "Plotting graphs ..."
python3 plot_graphs.py ${lwd_file} ${new_lwd_file}

