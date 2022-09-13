#!/usr/bin/env bash

HELM_CHART_VERSION=${1:?Chart version to release not provided (first argument)}
RELEASE_NOTES_URL=${2:?Release notes URL not provided (second argument)}
AWS_MARKETPLACE_PRODUCT_ID=${3:?AWS Marketplace Product ID not provided (third argument)}

echo "Getting all repositories for the STRM Privacy Data Plane AWS Marketplace listing"
ECR_REPOSITORIES=$(aws marketplace-catalog describe-entity --entity-id "${AWS_MARKETPLACE_PRODUCT_ID}" --catalog AWSMarketplace --region us-east-1 | jq -r '.Details | fromjson | .Repositories[].Url | select(. | contains("strm-privacy/strm") | not) | match(".+?/(.+)$").captures[0].string')

echo "Getting latest image tag for each repository"
CONTAINER_IMAGES=""

while read -r repo; do
    image_uri=$(aws ecr describe-images --registry-id 709825985650 --repository-name "$repo" --region us-east-1 | jq -r '.imageDetails[].imageTags | flatten[] | .[1:]' | sort -V | tail -n1 | awk -v repo="$repo" '{print "709825985650.dkr.ecr.us-east-1.amazonaws.com/"repo":v"$1}')
    CONTAINER_IMAGES="$CONTAINER_IMAGES"$'\n'"$image_uri"
done <<<"$ECR_REPOSITORIES"

echo "Creating Change Set"
CHANGE_SET=$(
jq --null-input \
    --arg RELEASE_NOTES_URL "$RELEASE_NOTES_URL" \
    --arg HELM_CHART_VERSION "$HELM_CHART_VERSION" \
    --arg CONTAINER_IMAGES "$CONTAINER_IMAGES" \
    --arg AWS_MARKETPLACE_PRODUCT_ID "$AWS_MARKETPLACE_PRODUCT_ID" \
    '{
       "Version": {
         "ReleaseNotes": "For detailed release notes, please navigate to the GitHub release page of this version at: \($RELEASE_NOTES_URL)",
         "VersionTitle": "v\($HELM_CHART_VERSION)"
       },
       "DeliveryOptions": [
         {
           "Details": {
             "HelmDeliveryOptionDetails": {
               "CompatibleServices": [
                 "EKS"
               ],
               "ContainerImages": ($CONTAINER_IMAGES | split( "\n" ) | map(select(. != "" ))),
               "Description": "The STRM Privacy Data Plane is deployed in your EKS cluster with our Helm chart. The chart is open source and can be viewed at https://github.com/strmprivacy/data-plane-helm-chart.",
               "HelmChartUri": "709825985650.dkr.ecr.us-east-1.amazonaws.com/strm-privacy/strm:\($HELM_CHART_VERSION)",
               "QuickLaunchEnabled": false,
               "UsageInstructions": "For detailed instructions on how to install the STRM Privacy Data Plane, please see our documentation at https://docs.strmprivacy.io/docs/latest/concepts/ccd/.\n\nPlease note that this product requires an ongoing internet connection to STRM Privacy, as the Control Plane is managed by us. The Control Plane supports your Data Plane and manages, for example, all streams that should exist.\nAll applications of the Data Plane report their heartbeat periodically to STRM Privacy, in order for you to use all tools that STRM Privacy provides, such as the CLI and the Console. ",
               "ReleaseName": "strmprivacy",
               "Namespace": "strmprivacy",
               "OverrideParameters": [
                  {
                    "Key": "license.installationType",
                    "DefaultValue": "AWS_MARKETPLACE",
                    "Metadata": {
                      "Obfuscate": false,
                      "Label": "Installation Type",
                      "Description": "Should be AWS_MARKETPLACE, do not change."
                    }
                  },
                  {
                    "Key": "license.installationId",
                    "Metadata": {
                      "Obfuscate": false,
                      "Label": "Installation ID",
                      "Description": "The ID of your installation, can be found at https://console.strmprivacy.io/installation/configuration"
                    }
                  },
                  {
                    "Key": "license.installationClientId",
                    "Metadata": {
                      "Obfuscate": true,
                      "Label": "Installation Client ID",
                      "Description": "The client ID used to authenticate Data Plane applications with the STRM Privacy Control Plane, can be found at https://console.strmprivacy.io/installation/configuration"
                    }
                  },
                  {
                    "Key": "license.installationClientSecret",
                    "Metadata": {
                      "Obfuscate": true,
                      "Description": "The client secret used to authenticate Data Plane applications with the STRM Privacy Control Plane, can be found at https://console.strmprivacy.io/installation/configuration",
                      "Label": "Installation Client Secret"
                    }
                  },
                  {
                    "Key": "services.loadbalancer.enabled",
                    "DefaultValue": "false",
                    "Metadata": {
                      "Obfuscate": false,
                      "Description": "Should Kubernetes Services of type LoadBalancer be created to expose STRM Privacy Applications",
                      "Label": "Enable LoadBalancer Kubernetes Service"
                    }
                  }
                ]
             }
           },
           "DeliveryOptionTitle": "STRM Privacy Data Plane"
         }
       ]
     }

     | tostring |

     [
       {
         "ChangeType": "AddDeliveryOptions",
         "Entity": {
           "Identifier": $AWS_MARKETPLACE_PRODUCT_ID,
           "Type": "ContainerProduct@1.0"
         },
         "Details": .
       }
     ]
     '
)

echo "Starting Change Set"
aws marketplace-catalog start-change-set --change-set-name "Publish version v${HELM_CHART_VERSION}" --catalog "AWSMarketplace" --region us-east-1 --change-set "$CHANGE_SET"
