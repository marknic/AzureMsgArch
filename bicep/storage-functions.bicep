@description('name of the resource')
param name string = 'mnmsgproc01devsa'

@description('Value of customer - for tags')
param customer string = 'Walgreens'
@description('Value of project - for tags')
param project string = 'Harmony'

@description('Environment designation - for tags')
param environment string = 'dev'

@description('Resource purpose or description - for tags')
param purpose string = 'storage for Azure Functions'

@description('Name of the function that will use this storage account')
param funcName string = 'mn-function-test-pf'

param dateCreated string = utcNow('u')

param subnetId string

resource sa 'Microsoft.Storage/storageAccounts@2019-06-01' = {
  name: name
  location: resourceGroup().location
  tags: {
    purpose: purpose
    customer: customer
    project: project
    environment: environment
    dateCreated: dateCreated
  }
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  kind: 'StorageV2'
  properties: {
    supportsHttpsTrafficOnly: true
    networkAcls: {
      bypass: 'AzureServices'
      virtualNetworkRules: [
        {
          id: subnetId
          action: 'Allow'
        }
      ]
      ipRules: [
        {
          value: '98.32.169.208'
          action: 'Allow'
        }
      ]
      defaultAction: 'Deny'
    }
  }
}

var fileshareName = '${funcName}-fs'
resource funcfileshare 'Microsoft.Storage/storageAccounts/fileServices/shares@2021-04-01' = {
  name: fileshareName
  dependsOn: [
    sa
  ]
  properties: {
    accessTier: 'TransactionOptimized'
    shareQuota: 100
    enabledProtocols: 'SMB'
  }
}
