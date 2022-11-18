#!/bin/bash
 
# This script creates infrastructure using Terraform.
# It is intended to be run from the repository's root directory like this:
#   deploy/gocd/infrastructure.sh
# Paths used in the script assume the current working directory is the top of
# the repository.
 
set -e
 
# Verify that environment variables have values.
: "${ENVIRONMENT:?must be set and should be the lowercase name of the Medistrano stage}"
if [[ ("${TF_STATE_PATH}" == "") && ("${MEDISTRANO_PROJECT}" == "") ]]; then
  echo "One of TF_STATE_PATH or MEDISTRANO_PROJECT must be set."
  exit 0;
fi
# Use TF_STATE_PATH if set, but default if unset.
: "${TF_STATE_PATH:=${ENVIRONMENT}/terraform/MCC_test}"
# If TF_STATE_REGION is not set, use the STAGE_REGION variable set by GoCD.
: "${TF_STATE_REGION:=${STAGE_REGION}}"
# If STAGE_REGION was empty, then default to us-east-1.
: "${TF_STATE_REGION:=us-east-1}"
 
# The optional TF_OPTIONS environment variable is appended to the terraform command
# and can be used to set deploy-time overrides of variables without changing the code in git.

if [[ "$RUN_INFRASTRUCTURE_STAGE" != "true" ]]; then
  echo "RUN_PREDEPLOY_STAGE is not true. Skipping stage."
  exit 0
fi
 
pushd deploy/terraform
 
# terraform init \
#       -input=false \
#       -reconfigure \
#       -backend-config="bucket=${TF_STATE_BUCKET}" \
#       -backend-config="key=${TF_STATE_PATH}" \
#       -backend-config="region=${TF_STATE_REGION}"

terraform init
 
terraform apply --auto-approve