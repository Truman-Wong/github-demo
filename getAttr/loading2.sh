#!/bin/bash

cwd=$(cd `dirname $0` && pwd)
cd $cwd

if [ $# -eq 1 ]; then
  vertex_cnt=$1
else
  echo "shell script input check failed, e.g.: bash load.sh 10"
  exit 1
fi

load_file=$cwd/load.gsql
rm -rf $load_file

echo "use graph testGraph
CREATE LOADING JOB loadTest FOR GRAPH testGraph {
" >> $load_file

attr_cnt=8
v_value="\$0"
e_value="\$0"
for((i=1;i<$attr_cnt+1;i++)); do
    v_value="${v_value}, \$$(($i+1))"
    e_value="${e_value}, \$$i"
done
e_value="${e_value}, \$$(($attr_cnt+1))"

echo "DEFINE FILENAME f_v;" >> $load_file
echo "DEFINE FILENAME f_e;" >> $load_file

i=1
while [ $i -le $vertex_cnt ]
do
  echo "LOAD f_v TO VERTEX vertex_${i} VALUES (${v_value}) USING header=\"true\", separator=\",\";" >> $load_file
  echo "LOAD f_e TO EDGE edge_1_${i} VALUES (${e_value}) USING header=\"true\", separator=\",\";" >> $load_file
  let i++
done

echo "}" >> $load_file

echo "RUN LOADING JOB loadTest USING f_v=\"./data_generator/vertex_1.csv\",f_e=\"./data_generator/edge_1_1.csv\"" >> $load_file
