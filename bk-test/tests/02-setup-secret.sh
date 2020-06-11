#!/usr/bin/env bash

env=$(mktemp)
cleanup() { rm "$env"; }
trap cleanup EXIT

echo "export SECRET_QUOTE='We are stuck with technology when what we really want is just stuff that works.'" > "$env"

aws s3 cp --acl private --sse aws:kms "$env" s3://"$BUILDKITE_SECRETS_BUCKET"/"$BUILDKITE_PIPELINE_SLUG"/env
