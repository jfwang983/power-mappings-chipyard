extra               ?=  # extra configs
args                ?=  # command-line args (including step flow control)

vlsi_dir=$(abspath .)
tech_name          = sky130
INPUT_CONFS        = $(vlsi_dir)/custom.yml $(extra)
ENV_YML            = $(vlsi_dir)/custom-env.yml

HAMMER_EXTRA_ARGS   ?= $(foreach conf, $(INPUT_CONFS), -p $(conf)) $(args)

BINARY 				?= $(RISCV)/riscv64-unknown-elf/share/riscv-tests/benchmarks/towers.riscv

CONFIG				?= CustomGemminiSoCConfig
