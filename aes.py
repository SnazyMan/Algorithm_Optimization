'''
@file
This is the model
  - How to run a GAMSJob from file
  - How to specify the solver
  - How to run a job with a solver option file
'''

from __future__ import print_function
from gams import *
import os
import sys

if __name__ == "__main__":
    if len(sys.argv) > 1:
        ws = GamsWorkspace(system_directory = sys.argv[1])
    else:
        ws = GamsWorkspace(working_directory = os.getcwd())

    ws.DebugLevel = 3    
    t1 = ws.add_job_from_file("aes.gms")
    t1.run()

    symbol_list = ["Z", "x", "s", "theta"]

    for symbol in symbol_list:    
        for rec in t1.out_db[symbol]:
            print(rec)
            

    
