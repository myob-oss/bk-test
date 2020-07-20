#!/usr/bin/env bash
die() { echo "${1:-sadface}"; exit "${2:-1}"; }

id=$(/opt/aws/bin/ec2-metadata --instance-id | cut -d " " -f 2) \
  || die "can't get id"

logs=$( aws logs get-log-events --log-group-name '/buildkite/system' --log-stream-name "$id" ) || die "can't get logs"
[[ -n "$logs" ]] || die "logs are empty"

