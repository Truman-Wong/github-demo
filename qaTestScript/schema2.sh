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
  echo "CREATE VERTEX vertex_${i}(PRIMARY_ID id uint, attr1 float, attr2 uint, attr3 string compress, attr4 string, attr5 int, attr6 double, attr7 datetime, attr8 bool) WITH primary_id_as_attribute=\"TRUE\"" >> $schema_file
  let i++
done

j=1
while [ $j -le $vertex_cnt ]
do
  echo "CREATE UNDIRECTED EDGE edge_1_${j}(FROM vertex_1, TO vertex_${j} ,attr1 float, attr2 uint, attr3 string compress, attr4 string, attr5 int, attr6 double, attr7 datetime, attr8 bool)" >> $schema_file
  let j++
done

echo "create graph testGraph(*)" >> $schema_file