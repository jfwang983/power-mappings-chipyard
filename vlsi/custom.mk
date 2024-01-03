extra               ?=  # extra configs
args                ?=  # command-line args (including step flow control)

vlsi_dir=$(abspath .)
tech_name          = sky130
INPUT_CONFS        = $(vlsi_dir)/custom.yml $(extra)
ENV_YML            = $(vlsi_dir)/custom-env.yml

HAMMER_EXTRA_ARGS   ?= $(foreach conf, $(INPUT_CONFS), -p $(conf)) $(args)

BINARY ?= /scratch/jfwang/power-prediction/power-mappings-chipyard/generators/gemmini/software/gemmini-rocc-tests/build/bareMetalC/matmul_tilings_0-baremetal
# BINARY 				?= $(RISCV)/riscv64-unknown-elf/share/riscv-tests/benchmarks/towers.riscv

CONFIG				?= CustomGemminiSoCConfig
