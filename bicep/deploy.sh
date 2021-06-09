#!/bin/bash

subscription="e752c181-7a2c-4de5-b16b-b3288ed54e42"
resourceGroupName="perftest-RG"
location="eastus2"

az deployment group create --name bicepdeploy02 --resource-group $resourceGroupName --template-file './deploytest.bicep'
