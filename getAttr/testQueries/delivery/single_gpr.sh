 #!/bin/bash
 gsql -g testGraph drop query all

 time gsql -g testGraph UDF.gsql

 
 time gsql -g testGraph install query -force -single all
 #queries="getAttr_constant_string variable_string getAttr_parameter_int where_constant_bool"
 #for q in $queries
 #do 
 #time gsql -g testGraph install query -force -single $q
 #done

 output_path="./output.csv"
t=5

echo single_gpr mode |& tee -a $output_path
queries="attr constant variable where"
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

echo query parametermode |& tee -a $output_path
for i in $(seq 1 $t)
    do
    q_start=$(date +%s%N | cut -b1-13)
    (curl -X GET -H "GSQL-TIMEOUT: 500000" "http://127.0.0.1:9000/query/testGraph/parameter?vType=vertex_1&vertex1_attr4") &> /dev/null
    q_end=$(date +%s%N | cut -b1-13)
    q_time=$(($q_end-$q_start))
    echo -n "$q_time," |& tee -a $output_path
    done
    echo "" |& tee -a $output_path