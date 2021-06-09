#!/bin/bash

subscription="e752c181-7a2c-4de5-b16b-b3288ed54e42"
resourceGroupName="perftest-RG"
location="eastus2"

# az login

# az account set --subscription $subscriptionId

# az account show --subscription $subscriptionId

az group create --resource-group $resourceGroupName --location $location

#az deployment group create --name bicepdeploy01 --resource-group 'arm-vscode' --template-file './azuredeploy.bicep'
