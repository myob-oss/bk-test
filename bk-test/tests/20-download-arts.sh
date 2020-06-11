#!/usr/bin/env bash

die() { echo "${1:-ENDOFXMSSN}" >&2; exit "${2:-1}"; }
rm -rf f.txt &>/dev/null

echo "~~~ :truck::package::green_heart: download arts"
buildkite-agent artifact download f.txt . || die "definitely khan"
ls -lh f.txt
