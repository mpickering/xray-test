rm xray-log*

clang++ -o sample -O3 sample.cc -std=c++11 -fxray-instrument -fxray-instruction-threshold=1
XRAY_OPTIONS="patch_premain=true xray_mode=xray-basic" ./sample

llvm-xray graph xray-log.sample.* -m sample -color-edges=sum -edge-label=sum \
    | unflatten -f -l10 | dot -Tsvg -o sample.svg

llvm-xray convert -symbolize -instr_map=./sample \
  -output-format=trace_event xray-log.* \
    | gzip > llc-trace.txt.gz
