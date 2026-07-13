import uproot3 as uproot
import pandas as pd
import numpy as np
import os

path = "/pnfs/uboone/persistent/users/uboonepro/surprise/opendata/NuMI/"
name = "checkout_MCC9.10_Run4b_NuMI_beam_on_RHC_data_surprise_v10_04_07_09_reco2_hist_opendata_20400_20600"

df_file = uproot.open(path+name+".root")["wcpselection"]
df_pot = df_file["T_pot"].pandas.df(["pot_tor875good","runNo",'subRunNo'], flatten=False)
df_pot["rs_num"] = (df_pot["runNo"].to_numpy() * 100_000_000_000
                         + df_pot["subRunNo"].to_numpy() * 1_000_000)

duplicate_rows = df_pot[df_pot.duplicated(keep=False)]
print(duplicate_rows)

print(df_pot.shape[0])
df_pot = df_pot.drop_duplicates(subset=['rs_num'])
print(df_pot.shape[0])

output_file = name+".txt" 
run = df_pot["runNo"].to_numpy()
subrun = df_pot["subRunNo"].to_numpy()
run_subrun_list = {}    

for event in range(len(run)):
    if run[event] in run_subrun_list:
        if subrun[event] in run_subrun_list[run[event]]: 
            continue
        run_subrun_list[run[event]].append( subrun[event] ) 
        continue
    run_subrun_list[run[event]] = [subrun[event]] 

run_list = []
run_list = sorted(run_subrun_list)

for i in range(len(run_list)): 
    run_no = run_list[i]
          
    for j in range(len(run_subrun_list[run_no])):
        f = open(output_file, "a")
        string = str(run_no) +" "+str(run_subrun_list[run_no][j])
        f.write(string)
        f.write("\n")
        f.close()
