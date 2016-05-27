#!/bin/bash

for i in 1; do
    new_seed=`expr 12345670 + 2 \* $i - 1`
    tracedir='/home/bluu/ndnSIM/ns-3/examples'
    #thisdir='/home/jani/ns-allinone-3.22/ns-3.22/examples/DTN_SF_UDP'
    ./waf --run "dtn_sf_udp --seed=$new_seed --traceFile=$tracedir/sf_downtown_nodes116_time120.tcl --logFile=dtn-run1.log --nodeNum=116 --duration=120.0" > dtn.txt
    grep 'final' dtn.txt > temp.txt
    awk '{print $21" "$14" "$18" "$3" "$5}' temp.txt > bundle_delays.tr
    rm temp.txt
    grep -v 'bundle' dtn.txt|grep -v 'antipacket'|grep -v 'ing'|grep -v 'too big' > qtrace.tr
    mv *.tr dtn.txt Run$i
done
