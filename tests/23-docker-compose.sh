#!/usr/bin/env bash
set -euo pipefail

die() { echo "${1:-ENDOFXMSSN}" >&2; exit "${2:-1}"; }

echo "~~~ :docker: inflate docker-compose.yml"
cat <<'eeek' > docker-compose.yml || die ":bangbang: unable inflate docker-compose.yml"
version: '2'
services:
  hello:
    image: alpine
    command: /bin/sh -c "/bin/sleep 5 ; /bin/echo ';)' ; /bin/echo 'Do Not Panic We Are Mostly Harmless'"
eeek

echo "~~~ :whale: pull docker image"
docker pull alpine || die ":bangbang: unable to pull docker image"

echo "~~~ :whale: :dolphin: dnp, moha!"
docker-compose --file docker-compose.yml run hello || die ":bangbang: failed to exec docker-compose"

echo "~~~ :recycle: cleaning up"
rm -f docker-compose.yml