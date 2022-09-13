#!/usr/bin/env bash

echo "This script is a work in progress. It is a start for upgrading a Helm chart deployed via the AWS Marketplace."
exit 0

export HELM_EXPERIMENTAL_OCI=1

latest_deployed_chart=$(helm list -A --filter strm --date | tail -n +2 | head -n 1)

deployed_chart_name=$(echo $latest_deployed_chart | awk '{print $1}')
deployed_chart_namespace=$(echo $latest_deployed_chart | gawk '{print $2}')

aws ecr get-login-password \
    --region us-east-1 | helm registry login \
    --username AWS \
    --password-stdin 709825985650.dkr.ecr.us-east-1.amazonaws.com

mkdir awsmp-chart && cd awsmp-chart

helm pull oci://709825985650.dkr.ecr.us-east-1.amazonaws.com/strm-privacy/strm --version 1.13.0

tar xf $(pwd)/* && find $(pwd) -maxdepth 1 -type f -delete

# FIXME how do we provide the values.yaml? Should we ask for a file? Should this be interactive?
#       and if the file is not provided, should we ask for each required value individually?
helm upgrade ${deployed_chart_name} strm \
    --namespace ${deployed_chart_namespace} \
    --set license.installationType=AWS_MARKETPLACE \
    --set license.installationId=<ENTER_VALUE_HERE> \
    --set license.installationClientId=<ENTER_VALUE_HERE> \
    --set license.installationClientSecret=<ENTER_VALUE_HERE> \
    --set services.loadbalancer.enabled=false
