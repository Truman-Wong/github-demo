#!/usr/bin/python3
"""
Combine LDBC SNB data
Data files in gz to gz file. Every 10 files are combined into 1.

Input#1
header
record1

Input#2
header
record2

...

Input#10
header
record10

To 

Output#1
header
record1
record2
...
record10
"""

import gzip
from pathlib import Path
from multiprocessing import Pool
input_folder = Path('/home/truman/sf30000')
output_folder = Path('/home/truman/sf30000-new')
thread = 20 # suggest to use 5 for SF-30k

def combine_file(task):
  output, inputs = task
  first = True
  with gzip.open(output, 'wb') as fo:
    for fin in inputs:
      with gzip.open(fin, 'rb') as fi:
        for i,row in enumerate(fi):
          if i == 0:
            if first:
              fo.write(row) # write header
              first = False
            continue
          fo.write(row)

dynamic = input_folder/'initial_snapshot'/'dynamic'
tasks = []
for entity in dynamic.iterdir():
  rel = entity.relative_to(input_folder)
  out = output_folder / rel
  out.mkdir(exist_ok=True, parents=True)
  files = []
  for i,f in enumerate(sorted(entity.glob('*.csv'))):
    if len(files) < 9:
      files.append(f)
    else:
      files.append(f)
      tasks.append((out/f'part-{i//10:05d}.csv', files.copy()))
      files = []
  if len(files) > 0:
    tasks.append((out/f'part-{i//10:05d}.csv', files.copy()))


print(tasks[:3])
with Pool(processes=thread) as pool:
  pool.map(combine_file, tasks)

print("Done initial Snapshot")
print("Work on inserts")


dynamic = input_folder/'inserts'/'dynamic'
tasks = []
for entity in dynamic.iterdir():
  for batch in (dynamic/entity).iterdir():
    rel = batch.relative_to(input_folder)
    out = output_folder / rel
    out.mkdir(exist_ok=True, parents=True)
    files = []
    for i,f in enumerate(sorted(batch.glob('*.csv'))):
      if len(files) < 9:
        files.append(f)
      else:
        files.append(f)
        tasks.append((out/f'part-{i//10:05d}.csv', files.copy()))
        files = []
    if len(files) > 0:
      tasks.append((out/f'part-{i//10:05d}.csv', files.copy()))


print(tasks[:3])
with Pool(processes=thread) as pool:
  pool.map(combine_file, tasks)
