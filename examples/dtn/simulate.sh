#!/bin/bash

for i in 1 2 3 4 5 6; do
    new_seed=`expr 12345670 + 2 \* $i - 1`
    tracedir='/home/jani/ns-allinone-3.22/ns-3.22/examples'
    thisdir='/home/jani/ns-allinone-3.22/ns-3.22/examples/DTN_SF_UDP'
    ./waf --run "dtn_sf_udp --seed=$new_seed --traceFile=$tracedir/sf_downtown_nodes116_time3600.tcl --logFile=$thisdir/ns-2.log --nodeNum=116 --duration=3600.0" > dtn.txt
    grep 'final' dtn.txt > temp.txt
    awk '{print $21" "$14" "$18" "$3" "$5}' temp.txt > bundle_delays.tr
    rm temp.txt
    grep -v 'bundle' dtn.txt|grep -v 'antipacket'|grep -v 'ing'|grep -v 'too big' > qtrace.tr
    mv *.tr dtn.txt Run$i
done
