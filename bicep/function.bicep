
@description('name of the resource')
param name string

// The following params are used for tagging
@description('Value of customer - for tags')
param customer string

@description('Value of project - for tags')
param project string

@description('Environment name - for tags')
param environment string

@description('Resource purpose or description - for tags')
param purpose string

@description('Backing store account - for tags')
param storageAccountName string

param location string = resourceGroup().location
param dateCreated string = utcNow('u')

param aspId string
param aiInstrumentationKey string

resource functionApp 'Microsoft.Web/sites@2020-06-01' = {
  name: name
  location: location
  kind: 'functionapp'
  tags: {
    purpose: purpose
    customer: customer
    project: project
    environment: environment
    dateCreated: dateCreated
  }
  properties: {
    httpsOnly: true
    serverFarmId: aspId
    clientAffinityEnabled: true
    siteConfig: {
     
    }
  }
}
