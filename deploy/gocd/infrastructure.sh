# This script creates infrastructure for mwarehousebdv using Terraform.
# It is intended to be run from the repository's root directory like this:
#   deploy/gocd/infrastructure.sh
# Paths used in the script assume the current working directory is the top of
# the repository.

set -e

# Verify that environment variables have values.
: "${ENVIRONMENT:?must be set and should be the lowercase name of the Medistrano stage}"
: "${TF_STATE_BUCKET:?must be set to the bucket to use for Terraform state storage}"

# Variables with defaults
: "${RUN_INFRASTRUCTURE_STAGE:=true}" # Controls whether this stage runs or is skipped.

# Use TF_STATE_PATH if set, but default to ${ENVIRONMENT}/terraform/mwarehousebdv if unset.
: "${TF_STATE_PATH:=${ENVIRONMENT}/terraform/MCC_test}"

# If TF_STATE_REGION is not set, use the STAGE_REGION variable set by GoCD.
: "${TF_STATE_REGION:=${STAGE_REGION}}"

# The optional TF_OPTIONS environment variable is appended to the terraform command
# and can be used to set deploy-time overrides of variables without changing the code in git.

echo "TF_STATE_BUCKET "$TF_STATE_BUCKET
echo "TF_STATE_PATH   "$TF_STATE_PATH
echo "TF_REGION   "$TF_STATE_REGION

if [[ "$RUN_INFRASTRUCTURE_STAGE" != "true" ]]; then
  echo "RUN_PREDEPLOY_STAGE is not true. Skipping stage."
  exit 0
fi

cd deploy/terraform

#terraform init \
#      -backend-config="bucket=${TF_STATE_BUCKET}" \
#      -backend-config="key=${TF_STATE_PATH}" \
#      -backend-config="region=${TF_STATE_REGION}"
terraform init

# terraform plan -var-file="vars/${ENVIRONMENT}.tfvars"
#terraform apply -var-file=vars/${ENVIRONMENT}.tfvars --auto-approve $TF_OPTIONS
terraform apply --auto-approve