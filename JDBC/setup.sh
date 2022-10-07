#!/bin/bash
DDL_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
#DATA_PATH=${1:-"/data"}
QUERY_PATH=${2:-"/queries"}
DML_PATH=${3:-"/dml"}

echo "==============================================================================="
echo "Setting up the TigerGraph database"
echo "-------------------------------------------------------------------------------"
echo "DDL_PATH: ${DDL_PATH}"
echo "DATA_PATH: ${DATA_PATH}"
echo "QUERY_PATH: ${QUERY_PATH}"
echo "QUERY_PATH: ${DML_PATH}"
echo "==============================================================================="
t0=$SECONDS
#gsql drop all
#gsql PUT TokenBank FROM \"$DDL_PATH/TokenBank.cpp\"
#gsql PUT ExprFunctions FROM \"$DDL_PATH/ExprFunctions.hpp\"
gsql /home/tigergraph/ldbc_snb_bi/tigergraph/ddl/schema.gsql

#gsql --graph ldbc_snb $DDL_PATH/load_dynamic.gsql


echo "==============================================================================="
echo "Load Data"
echo "-------------------------------------------------------------------------------"
t1=$SECONDS
STATIC_PATH=ANY:$DATA_PATH/initial_snapshot/static
DYNAMIC_PATH=ANY:/home/tigergraph/data


gsql --graph ldbc_snb RUN LOADING JOB load_comment USING \
  file_Comment=\"$DYNAMIC_PATH/Comment.csv\" ,BATCH_SIZE=\"8192\"

gsql --graph ldbc_snb RUN LOADING JOB load_reply USING \
  file_Comment_replyOf_Comment=\"$DYNAMIC_PATH/reply.csv\" ,BATCH_SIZE=\"8192\"

echo "==============================================================================="
echo "Install Query"
echo "-------------------------------------------------------------------------------"
t2=$SECONDS
