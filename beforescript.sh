#!/bin/bash
cd Terraform
case "$CI_MERGE_REQUEST_TARGET_BRANCH_NAME" in
    master) WORKSPACE_NAME="production" ;;
    *) WORKSPACE_NAME="${CI_MERGE_REQUEST_TARGET_BRANCH_NAME:-$CI_COMMIT_REF_SLUG}" ;;
    esac
rm -rf .terraform
terraform --version
rm -f coastalbloom.json
touch coastalbloom.json
ls
echo $bucket >> coastalbloom.json
cat coastalbloom.json
terraform init -reconfigure
echo $WORKSPACE_NAME
terraform workspace select $WORKSPACE_NAME || terraform workspace new $WORKSPACE_NAME
