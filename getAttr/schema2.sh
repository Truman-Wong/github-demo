#!/bin/bash

cwd=$(cd `dirname $0` && pwd)
cd $cwd

if [ $# -eq 1 ]; then
  vertex_cnt=$1
else
  echo "shell script input check failed, e.g.: bash schema.sh 10"
  exit 1
fi

schema_file=$cwd/schema.gsql
rm -rf $schema_file

echo "drop all" >> $schema_file
i=1
while [ $i -le $vertex_cnt ]
do
  echo "CREATE VERTEX vertex_${i}(PRIMARY_ID id uint, vertex${i}_attr1 float, vertex${i}_attr2 uint, vertex${i}_attr3 string compress, vertex${i}_attr4 string, vertex${i}_attr5 int, vertex${i}_attr6 double, vertex${i}_attr7 datetime, vertex${i}_attr8 bool) WITH primary_id_as_attribute=\"TRUE\"" >> $schema_file
  let i++
done

j=1
while [ $j -le $vertex_cnt ]
do
  echo "CREATE UNDIRECTED EDGE edge_1_${j}(FROM vertex_1, TO vertex_${j} , edge_${j}_attr1 float, edge_${j}_attr2 uint, edge_${j}_attr3 string compress, edge_${j}_attr4 string, edge_${j}_attr5 int, edge_${j}_attr6 double, edge_${j}_attr7 datetime, edge_${j}_attr8 bool)" >> $schema_file
  let j++
done

echo "create graph testGraph(*)" >> $schema_file