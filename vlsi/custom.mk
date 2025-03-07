extra               ?=  # extra configs
args                ?=  # command-line args (including step flow control)

vlsi_dir=$(abspath .)
tech_name          = intech22
INPUT_CONFS        = $(vlsi_dir)/custom.yml $(extra)
ENV_YML            = $(vlsi_dir)/custom-env.yml

HAMMER_EXTRA_ARGS   ?= $(foreach conf, $(INPUT_CONFS), -p $(conf)) $(args)

BINARY 				?= /bwrcq/scratch/jfwang983/power-mappings-chipyard/generators/gemmini/software/gemmini-rocc-tests/build/bareMetalC/simple-baremetal
LOADMEM 			?= $(BINARY)

CONFIG				?= CustomGemminiSoCConfig