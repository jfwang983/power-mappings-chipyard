import sys
import subprocess
import yaml

def run_power_rtl():
    yaml_file = "custom.yml"
    path_1_temp = "output/chipyard.harness.TestHarness.CustomGemminiSoCConfig/matmul_tilings_"
    path_2_temp = "-baremetal.fsdb"
    report_temp = "bert-inst_gemmini-"

    subprocess.call("source /ecad/tools/vlsi.bashrc", shell=True)

    try:
        sys.argv[1]
        sys.argv[2]
    except Exception as e:
        raise ValueError("Not enough args")
    
    start = int(sys.argv[1])
    end = int(sys.argv[2])

    for i in range(start, end):
        # MK Setup
        custom_mk_file = "../power-mappings-chipyard/vlsi/custom.mk"
        with open(custom_mk_file, "r") as f:
            data = f.readlines()
            
        binary_file = f"/scratch/jfwang/power-prediction/power-mappings-chipyard/generators/gemmini/software/gemmini-rocc-tests/build/bareMetalC/conv_tilings_{i}-baremetal"
        data[-3] = f"BINARY \t\t\t\t?= {binary_file}\n"

        with open(custom_mk_file, "w") as f:
            f.writelines(data)

        # YAML Setup
        waveform_path = path_1_temp + str(i) + path_2_temp
        report_name = report_temp + str(i)
        with open(yaml_file, 'r') as f:
            custom = yaml.safe_load(f)
        custom['power.inputs']['report_configs'][0]['waveform_path'] = waveform_path
        custom['power.inputs']['report_configs'][0]['report_name'] = report_name

        with open(yaml_file, 'w',) as f:
            yaml.dump(custom, f, sort_keys=False)
    
        subprocess.call('make redo-power-rtl args="--only_step report_power"', shell=True)

run_power_rtl()