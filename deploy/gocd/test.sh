#!/usr/bin/env bash

# Exit on failure of any command
#set -e
## This script is run by the GoCD deployment pipeline with the current working directory
## set to the root of the git repository.
#
## Variables with defaults
#: "${RUN_TEST_STAGE:=true}" # Controls whether this stage runs or is skipped.
#
#if [[ "$RUN_TEST_STAGE" != "true" ]]; then
#  echo "RUN_PREDEPLOY_STAGE is not true. Skipping stage."
#  exit 0
#fi
#
### Execute command to generate ECR login
#aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 767904627276.dkr.ecr.us-east-1.amazonaws.com
#
### Command to clear unused container, images and networks
#yes | docker system prune
#
### pull latest develop image
#docker pull "$ECR_REPO:$DOCKER_GIT_BRANCH"
#
#cd test/bdv_modules/
#ansible-playbook main.yml
#docker-compose -f docker_compose_$MEDISTRANO_PROJECT.yml up | tee result.txt
#
### Check the file if any of the RF test failed
#if cat result.txt | grep 'code 1'
#then
#    echo "Execution failed" && exit 1
#else
#    echo "Execution is successful" && exit 0
#fi
