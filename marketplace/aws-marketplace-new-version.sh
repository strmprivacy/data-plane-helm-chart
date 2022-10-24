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
    echo "Adding AWS Marketplace override parameters for $INSTALLATION_TYPE"

    AWS_MARKETPLACE_PAYG_EXTRA_OVERRIDE_PARAMETERS='
    [
        {
            "Key": "serviceAccount",
            "DefaultValue": "${AWSMP_SERVICE_ACCOUNT}",
            "Metadata": {
                "Obfuscate": false,
                "Label": "Kubernetes Service Account Name",
                "Description": "Name of the Kubernetes Service Account that is linked to the role that has access to the AWS Marketplace Metering API."
            }
        },
        {
            "Key": "marketplace.aws.serviceAccountRoleArn",
            "Metadata": {
                "Obfuscate": false,
                "Label": "Role ARN with access to Marketplace Metering API",
                "Description": "ARN of the role that is allowed to access the Marketplace Metering API."
            }
        }
    ]
    '
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
    --arg AWS_MARKETPLACE_PAYG_EXTRA_OVERRIDE_PARAMETERS "$AWS_MARKETPLACE_PAYG_EXTRA_OVERRIDE_PARAMETERS" \
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
               "UsageInstructions": "Please do not follow the instructions on the \"Launch this software\" page, as those leave out too many details. For detailed instructions and a step by step guide on how to install the STRM Privacy Data Plane, please see our documentation at https://docs.strmprivacy.io/docs/latest/quickstart/ccd/aws-marketplace/.\n\nPlease note that this product requires an ongoing internet connection to STRM Privacy, as the Control Plane is managed by us. The Control Plane supports your Data Plane and manages, for example, all streams that should exist.\nAll applications of the Data Plane report their heartbeat periodically to STRM Privacy, in order for you to use all tools that STRM Privacy provides, such as the CLI and the Console.",
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
                ] + [($AWS_MARKETPLACE_PAYG_EXTRA_OVERRIDE_PARAMETERS | select(. != "") | fromjson)] | flatten)
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
