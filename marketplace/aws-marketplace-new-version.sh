#!/usr/bin/env bash

HELM_CHART_VERSION=${1:?Chart version to release not provided (first argument)}
RELEASE_NOTES_URL=${2:?Release notes URL not provided (second argument)}
AWS_MARKETPLACE_PRODUCT_ID=${3:?AWS Marketplace Product ID not provided (third argument)}
INSTALLATION_TYPE=${4:?Installation Type not provided (fourth argument)}

PRODUCT_TITLE=$(aws marketplace-catalog describe-entity --entity-id "${AWS_MARKETPLACE_PRODUCT_ID}" --catalog AWSMarketplace --region us-east-1 | jq -r '.Details | fromjson | .Description.ProductTitle')

echo "==========================================================================="
echo "Starting AWS Marketplace Release ${HELM_CHART_VERSION} for ${PRODUCT_TITLE}"
echo "==========================================================================="

echo "Getting Helm Chart repository for ${PRODUCT_TITLE}"
HELM_CHART_REPO=$(aws marketplace-catalog describe-entity --entity-id "${AWS_MARKETPLACE_PRODUCT_ID}" --catalog AWSMarketplace --region us-east-1 | jq -r '.Details | fromjson | .Repositories[].Url | select(. | contains("strm-privacy/strm")) | select(. | contains("strm-privacy-data-plane") | not) | match(".+?/(.+)$").captures[0].string')

echo "Getting all repositories for ${PRODUCT_TITLE}"
ECR_REPOSITORIES=$(aws marketplace-catalog describe-entity --entity-id "${AWS_MARKETPLACE_PRODUCT_ID}" --catalog AWSMarketplace --region us-east-1 | jq -r '.Details | fromjson | .Repositories[].Url | select(. | contains("strm-privacy/strm") | not) | match(".+?/(.+)$").captures[0].string')

echo "Getting latest image tag for each repository"
CONTAINER_IMAGES=""

while read -r repo; do
    image_uri=$(aws ecr describe-images --registry-id 709825985650 --repository-name "$repo" --region us-east-1 | jq -r '.imageDetails[].imageTags | flatten[] | .[1:]' | sort -V | tail -n1 | awk -v repo="$repo" '{print "709825985650.dkr.ecr.us-east-1.amazonaws.com/"repo":v"$1}')
    CONTAINER_IMAGES="$CONTAINER_IMAGES"$'\n'"$image_uri"
done <<<"$ECR_REPOSITORIES"

if [[ "$INSTALLATION_TYPE" == "AWS_MARKETPLACE_PAYG" ]]; then
    echo "Adding AWS Marketplace Service Account override parameter for $INSTALLATION_TYPE, as that is a requirement for paid products"
    AWS_MARKETPLACE_PAYG_SERVICE_ACCOUNT='{ "Key": "marketplace.aws.serviceAccount", "DefaultValue": "${AWSMP_SERVICE_ACCOUNT}", "Metadata": { "Obfuscate": false, "Label": "AWS Marketplace Service Account", "Description": "Should be ${AWSMP_SERVICE_ACCOUNT}, do not change." } }'
fi

echo "Creating Change Set"
# For API Reference, see https://docs.aws.amazon.com/marketplace-catalog/latest/api-reference/container-products.html
CHANGE_SET=$(
jq --null-input \
    --arg RELEASE_NOTES_URL "$RELEASE_NOTES_URL" \
    --arg HELM_CHART_REPO "$HELM_CHART_REPO" \
    --arg HELM_CHART_VERSION "$HELM_CHART_VERSION" \
    --arg CONTAINER_IMAGES "$CONTAINER_IMAGES" \
    --arg INSTALLATION_TYPE "$INSTALLATION_TYPE" \
    --arg PRODUCT_TITLE "$PRODUCT_TITLE" \
    --arg AWS_MARKETPLACE_PAYG_SERVICE_ACCOUNT "$AWS_MARKETPLACE_PAYG_SERVICE_ACCOUNT" \
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
               "HelmChartUri": "709825985650.dkr.ecr.us-east-1.amazonaws.com/\($HELM_CHART_REPO):\($HELM_CHART_VERSION)",
               "QuickLaunchEnabled": false,
               "UsageInstructions": "For detailed instructions on how to install the STRM Privacy Data Plane, please see our documentation at https://docs.strmprivacy.io/docs/latest/concepts/deployment-modes/ccd/.\n\nPlease note that this product requires an ongoing internet connection to STRM Privacy, as the Control Plane is managed by us. The Control Plane supports your Data Plane and manages, for example, all streams that should exist.\nAll applications of the Data Plane report their heartbeat periodically to STRM Privacy, in order for you to use all tools that STRM Privacy provides, such as the CLI and the Console.",
               "ReleaseName": "strmprivacy",
               "Namespace": "strmprivacy",
               "OverrideParameters": ([
                  {
                    "Key": "license.installationType",
                    "DefaultValue": "\($INSTALLATION_TYPE)",
                    "Metadata": {
                      "Obfuscate": false,
                      "Label": "Installation Type",
                      "Description": "Should be \($INSTALLATION_TYPE), do not change."
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
                  }
                ] + [($AWS_MARKETPLACE_PAYG_SERVICE_ACCOUNT | select(. != "") | fromjson)])
             }
           },
           "DeliveryOptionTitle": "\($PRODUCT_TITLE)"
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
