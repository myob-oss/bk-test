#!/usr/bin/env bash

die() { echo "${1:-ded}" >&2; exit "${2:-1}"; }


id=$(/opt/aws/bin/ec2-metadata --instance-id | cut -d " " -f 2) \
  || die "can't get id"
echo "got id: $id"
ec2=$( aws ec2 describe-instances --instance-ids "$id") \
  || die "can't get instance info"
echo "got instance info"
q=$( jq -r '.Reservations[].Instances[].Tags[] | select ( .Key | contains ("BuildkiteQueue")) | .Value' <<<"$ec2" ) \
  || die "can't get queue name"
echo "got queue name: $q"
sdp=$(aws ssm get-parameter --name "/bk/$q/ScaleDownPeriod" --query Parameter.Value --output text) \
  || die "can't get scale down period"
echo "got scale down: $sdp"
asg=$( jq -r '.Reservations[].Instances[].Tags[] | select ( .Key | contains ("aws:autoscaling:groupName")) | .Value' <<<"$ec2" ) \
  || die "can't get asg name"
echo "got asg name: $asg"

echo "~~~ sleeping for $((sdp*3)) seconds"

sleep $((sdp*3))

echo "~~~ done sleeping"

dc=$( aws autoscaling describe-auto-scaling-groups --auto-scaling-group-name "$asg" \
  | jq -r '.AutoScalingGroups[].DesiredCapacity' ) \
  || die "can't get desired capacity"
[[ "$dc" == 1 ]] && echo "one agent running" || die "desired count is $dc, check scale down"
