#!/bin/bash
b=1
while [ $b -le 100 ]
do
    gsql -g testGraph "run query test03()"
    let b++
done