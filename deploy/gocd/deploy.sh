# #!/bin/bash
 
# # Exit on failure of any command
# set -e
 
# # This script is run by the GoCD deployment pipeline with the current working directory
# # set to the root of the git repository.
 
# # Required environment variables
# : "${DEPLOY_CORRAL_NAME:?must be set}" # The corral(s) to deploy to.
# : "${ENVIRONMENT:?must be set}" # sandbox, production, distro, etc.
# : "${MEDISTRANO_PROJECT:?must be set to the name of the Medistrano project (i.e. medsetl)}"
 
# # Optional variables
# : "${RUN_DEPLOY_STAGE:=true}" # Controls whether this stage runs or is skipped.
 
# if [[ "$RUN_DEPLOY_STAGE" != "true" ]]; then
#   echo "RUN_DEPLOY_STAGE is not true. Skipping stage."
#   exit 0
# fi
 
# ###########################
# # The GoCD template starts us inside $APP_REPO so we need to go up one level.
# # In the rest of the script we will move into either the application repo
# # specified by the $APP_REPO environment variable or into the go-cd directory
# # and then back to this directory.
# cd ..
 
# ###########################
# # Prep go-cd directory.
# # Many scripts in the go-cd repo expect the current working directory to
# # be in a specific location. These prep steps are done in most GoCD templates.
# cp -rf $HOME/go-cd go-cd
 
# ###########################
# # Run the 12-factor deploy
# export MEDISTRANO_PROJECT=$MEDISTRANO_PROJECT
# export MEDISTRANO_STAGE=$ENVIRONMENT
# export MEDISTRANO_HOSTNAME=$DEPLOY_CORRAL_NAME
# export TWELVE_FACTOR_TASK='deploy:twelve_factor_task'
 
# echo "---------------------------------"
# echo " Deploying"
# echo "---------------------------------"
# pushd go-cd
# tools/medistrano/ec2-12f-tasks.sh deployment
# popd