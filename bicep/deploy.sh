#!/bin/bash

resourceGroupName="bicep-demo-RG"

aiName="mn-demo2-ai"

az deployment group create --name bicepdeploy02 --resource-group $resourceGroupName --template-file './ai.bicep'


# aiName="mn-demo2-ai"
# az deployment group create --name bicepdeploy02 --resource-group $resourceGroupName --template-file './ai.bicep' --parameters "{ \"aiName\": { \"value\": \"$aiName\" } }"
