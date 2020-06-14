#!/usr/bin/env bash

set -euo pipefail

json=$(aws s3api list-object-versions --bucket "$BUILDKITE_SECRETS_BUCKET")
echo "$json"
objs=$(jq -sM ".[].Versions[]?, .[].DeleteMarkers[]? | select (.Key | contains (\"$BUILDKITE_PIPELINE_SLUG/\")) | {Key: .Key, VersionId:.VersionId}" <<<"$json" \
  | jq -sM '{Objects: ., Quiet: false}')

aws s3api delete-objects --bucket "$BUILDKITE_SECRETS_BUCKET" --delete "$objs"
