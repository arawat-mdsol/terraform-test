#!/bin/bash
 
# Exit on failure of any command
set -e
 
# This script is run by the GoCD deployment pipeline with the current working directory
# set to the root of the git repository.
 
# Required environment variables
: "${ENVIRONMENT:?must be set}" # sandbox, production, distro, etc.
 
# Variables with defaults
: "${RUN_PREDEPLOY_STAGE:=true}" # Controls whether this stage runs or is skipped.
 
# Optional environment variables:
# GITREF_OVERRIDE - Set to the tag to use for for databag configuration
# GITREF_FOR_DATABAG_UPDATE - set to the tag or branch of the config to use. Allows
#                             GITREF_OVERRIDE to be set for deploys and other
#                             steps but a different gitref to be used for config.
 
# Variables set by GoCD by default
: "${MEDISTRANO_TOKEN:?must be set to a bearer token for Medistrano}"
: "${STAGE_REGION:?must be set to the AWS region name to deploy to}"
: "${STRANO_API:?must be set to the Medistrano API URL}"
 
if [[ "$RUN_PREDEPLOY_STAGE" != "true" ]]; then
  echo "RUN_PREDEPLOY_STAGE is not true. Skipping stage."
  exit 0
fi
 
###########################
# The GoCD template starts us inside $APP_REPO so we need to go up one level.
# In the rest of the script we will move into either the application repo
# specified by the $APP_REPO environment variable or into the go-cd directory
# and then back to this directory.
cd ..
 
###########################
# Prep go-cd directory.
# Many scripts in the go-cd repo expect the current working directory to
# be in a specific location. These prep steps are done in most GoCD templates.
cp -rf $HOME/go-cd go-cd
 
###########################
# Update Databag
 
echo "---------------------------------"
echo " Updating databags"
echo "---------------------------------"
 
# Export environment variables required by automated_databag_update.sh
export MEDISTRANO_PROJECT=$MEDISTRANO_PROJECT
export MEDISTRANO_STAGE="$ENVIRONMENT"
 
# Run the databag update.
go-cd/app/automated_databag_update/automated_databag_update.sh EC2