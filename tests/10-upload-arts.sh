#!/usr/bin/env bash

die() { echo "${1:-ENDOFXMSSN}" >&2; exit "${2:-1}"; }

cat <<! >f.txt
[C has] the power of assembly language and the
convenience of … assembly language.
    -- Dennis Ritchie
!

echo "~~~ :gift_heart::package::truck: upload arts"
buildkite-agent artifact upload f.txt || die "khan?"
