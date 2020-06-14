#!/usr/bin/env bash

printf '%s\nsteps:\n' "---"
c='0'
for i in tests/*.sh; do
  f=${i##tests/}
  (( ${f%%[0-9]-*} > c )) && echo '  - wait' && c=${f%%[0-9]-*}
  cat <<!
  - label: ':bash: $i'
    command: $i
    agents:
      queue: ${QUEUE:-dnp-oss}
!
done
