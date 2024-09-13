#!/bin/bash

# Loop from 0 to 31
for i in {0..31}
do
  # Execute the curl command with the current batch_number
  curl -X GET -H "GSQL-TIMEOUT: 500000" "http://127.0.0.1:9000/query/general/delete_edge_batch?batch_number=$i"
done
