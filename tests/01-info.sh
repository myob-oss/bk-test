#!/usr/bin/env bash
#set -x

die() { echo "${1:-ENDOFXMSSN}" >&2; exit "${2:-1}"; }

echo "~~~ :aws: metadata"
aid=$(curl -s http://169.254.169.254/latest/meta-data/ami-id)
hn=$(curl -s http://169.254.169.254/latest/meta-data/hostname)
iid=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
ity=$(curl -s http://169.254.169.254/latest/meta-data/instance-type)
echo "ami-id: $aid"
echo "hostname: $hn"
echo "instance-id: $iid"
echo "instance-type: $ity"

echo "~~~ :linux: uname -a"
uname -a

echo "~~~ :bash: uptime"
uptime

echo "~~~ :bash: id"
id

echo "~~~ :bash: whoami"
whoami

echo "~~~ :bash: who"
who

echo "~~~ :bash: which bash"
# shellcheck disable=SC2230
which bash

echo "~~~ :bash: bash ver"
# shellcheck disable=SC2230,SC2006
`which bash` --version

echo "~~~ :bash: custom bk vars"
echo "BADA $BADA"
echo "GOPATH $GOPATH"
echo "GOROOT $GOROOT"
echo "GOBIN $GOBIN"
echo "PATH $PATH"

echo "~~~ :bash: env | sort"
env | sort

echo "~~~ :bash: alias"
alias

echo "~~~ :bash: mount"
mount

echo "~~~ :bash: df -h"
df -h

echo "~~~ :bash: psaux"
ps auxc

echo "~~~ :bash: pstree"
pstree
