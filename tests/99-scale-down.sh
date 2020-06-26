#!/usr/bin/env bash

die() { echo "${1:-ded}" >&2; exit "${2:-1}"; }

sdp=$(aws ssm get-parameter --name "/bk/$queue/ScaleDownPeriod" \
    --region "$region" --query Parameter.Value --output text) || die "can't get idle"

sleep ((sdp*3))

id=$(/opt/aws/bin/ec2-metadata --instance-id | cut -d " " -f 2) || die "can't get id"
asg=$( aws ec2 describe-instances --instance-ids "$id" \
  | jq -r '.Reservations[].Instances[].Tags[] | select ( .Key | contains ("aws:autoscaling:groupName")) | .Value' ) \
  || die "can't get asg name"
dc=$( aws autoscaling describe-auto-scaling-groups --auto-scaling-group-name "$asg" \
  | jq -r '.AutoScalingGroups[].DesiredCapacity' ) \
  || die "can't get desired capacity"

[[ "$dc" == 1 ]] && echo "one agent running" || die "desired count is $dc, check scale down"
