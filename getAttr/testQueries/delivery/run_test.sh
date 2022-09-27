#!/bin/bash
#add gsql script to graph first

# variable declaration
output_path="./output.csv"
t=5
 echo "start run_test.sh" |& tee -a $output_path
queries="attr constant variable where_attr attr_dist constant_dist variable_dist where_dist"
 for q in $queries
 do 
 echo "query ${q}" |& tee -a $output_path

    for i in $(seq 1 $t)
    do
    q_start=$(date +%s%N | cut -b1-13)
    (curl -X GET -H "GSQL-TIMEOUT: 500000" "http://127.0.0.1:9000/query/testGraph/${q}?vType=vertex_1") &> /dev/null
    q_end=$(date +%s%N | cut -b1-13)
    q_time=$(($q_end-$q_start))
    echo -n "$q_time," |& tee -a $output_path
    done
    echo "" |& tee -a $output_path
done

echo query parameter
para="parameter parameter_dist"
for p in $para
 do 
 echo "query ${p}" |& tee -a $output_path

    for i in $(seq 1 $t)
    do
    q_start=$(date +%s%N | cut -b1-13)
    (curl -X GET -H "GSQL-TIMEOUT: 500000" "http://127.0.0.1:9000/query/testGraph/${p}?vType=vertex_1&attrName=vertex1_attr4") &> /dev/null
    q_end=$(date +%s%N | cut -b1-13)
    q_time=$(($q_end-$q_start))
    echo -n "$q_time," |& tee -a $output_path
    done
    echo "" |& tee -a $output_path
done
echo "end of run_test.sh" |& tee -a $output_path
echo "" |& tee -a $output_path