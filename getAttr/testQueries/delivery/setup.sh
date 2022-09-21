#!/bin/bash
#add gsql script to graph first

time gsql -g testGraph refactor_accum.gsql
time gsql -g testGraph refactor_where.gsql
time gsql -g testGraph distributed_refactor_accum.gsql
time gsql -g testGraph distributed_refactor_accum.gsql




#install query 
time gsql -g testGraph install query all


