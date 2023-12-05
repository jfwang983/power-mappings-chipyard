#!/bin/bash
cd /scratch/jfwang/power-prediction/dosa
python run.py --arch_name gemmini --arch_file dataset/hw/gemmini/arch/arch.yaml --num_mappings 1000 -wl bert_test
python sample_extract.py
cd /scratch/jfwang/power-prediction/power-mappings-chipyard/generators/gemmini/software/gemmini-rocc-tests/gemmini-data-collection
./build_script.sh
cd /scratch/jfwang/power-prediction/power-mappings-chipyard/vlsi
./power_results.sh $1 $2