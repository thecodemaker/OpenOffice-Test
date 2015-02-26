#!/bin/bash

N=100;
echo "$(/opt/libreoffice3.4/program/soffice --version)";

cd ./resources

#echo "Create the documents we want to use for testing."
for i in $(seq 1 $N); do
    cp input/hello.odt input/hello_$i.odt
done

/opt/libreoffice3.4/program/soffice --headless --invisible --convert-to pdf --outdir "result/" input/hello.odt &>/dev/null

#echo "Convert documents."
startTime=$(date +%s);
for i in $(seq 1 $N); do
    /opt/libreoffice3.4/program/soffice --headless --invisible  --convert-to pdf --outdir "result/" input/hello_$i.odt &>/dev/null
done
endTime=$(date +%s);
duration=$((endTime-startTime));
echo "Time required for converting ${N} documents: ${duration}";

#echo "Clean test data."
for i in $(seq 1 $N); do
    rm -f input/hello_$i.odt result/hello_$i.pdf
done