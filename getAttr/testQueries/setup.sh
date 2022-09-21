#!/bin/bash
#add gsql script to graph first
for q in distributed/*.gsql; do
gsql -g ldbc_snb $q
done

for q in udf/*.gsql; do
gsql -g ldbc_snb $q
done

for q in single_gpr/*.gsql; do
gsql -g ldbc_snb $q
done

#install query 
gsql -g ldbc_snb install query all