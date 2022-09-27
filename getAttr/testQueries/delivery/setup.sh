#!/bin/bash
#add gsql script to graph first
#using_gpr to indicate single_gpr query to run all modes in one script
time gsql -g testGraph UDF.gsql
time gsql -g testGraph distributed.gsql





#install query 
time gsql -g testGraph install query all


