@description('name of the resource')
param name string

@description('Value of customer - for tags')
param customer string = 'Walgreens'
@description('Value of project - for tags')
param project string = 'Harmony'

@description('Environment designation - for tags')
param environment string = 'dev'

@description('Resource purpose or description - for tags')
param purpose string = 'storage'

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
