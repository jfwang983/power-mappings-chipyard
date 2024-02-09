import sys
import subprocess
import yaml

def run_power_rtl():
    try:     
        sys.argv[1]
        sys.argv[2]
        sys.argv[3]
        sys.argv[4]
    except Exception as e:
        raise ValueError("Not enough args")
    
    yaml_file = "custom.yml"
    path_1_temp = f"output/chipyard.harness.TestHarness.CustomGemminiSoCConfig/{sys.argv[1]}_tilings_"
    path_2_temp = "-baremetal.fsdb"
    report_temp = sys.argv[2] + "_"
    report_2_temp = "-baremetal-gemmini"

    subprocess.call("source /ecad/tools/vlsi.bashrc", shell=True)

    start = int(sys.argv[3])
    end = int(sys.argv[4])
    init_rtl = len(sys.argv) == 6 and sys.argv[5] == "-init"

    for i in range(start, end):
        # MK Setup
        custom_mk_file = "../vlsi/custom.mk"
        with open(custom_mk_file, "r") as f:
            data = f.readlines()
            
        binary_file = f"/scratch/jfwang/power-prediction/power-mappings-chipyard/generators/gemmini/software/gemmini-rocc-tests/build/bareMetalC/conv_tilings_{i}-baremetal"
        data[-3] = f"BINARY \t\t\t\t?= {binary_file}\n"

        with open(custom_mk_file, "w") as f:
            f.writelines(data)

        # YAML Setup
        waveform_path = path_1_temp + str(i) + path_2_temp
        report_name = report_temp + str(i) + report_2_temp
        with open(yaml_file, 'r') as f:
            custom = yaml.safe_load(f)
        custom['power.inputs']['report_configs'][0]['waveform_path'] = waveform_path
        custom['power.inputs']['report_configs'][0]['report_name'] = report_name

        with open(yaml_file, 'w',) as f:
            yaml.dump(custom, f, sort_keys=False)
    
        if init_rtl:
            subprocess.call('make power-rtl', shell=True)
        else:
            subprocess.call('make redo-power-rtl args="--only_step report_power"', shell=True)

run_power_rtl()