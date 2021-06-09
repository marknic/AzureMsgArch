
@description('name of the resource')
param name string

param resourceTag string

// The following params are used for tagging
@description('Value of customer - for tags')
param customer string = 'Walgreens'

@description('Value of project - for tags')
param project string = 'Harmony'

@description('Environment name - for tags')
param environment string = 'dev'

@description('Resource purpose or description - for tags')
param purpose string = 'storage'

param dateCreated string = utcNow('u')
param location string = resourceGroup().location


var resourceTagName = resourceTag == '' ? resourceTag : 'nullTagName'
var resourceTagValue = resourceTag == '' ? 'Resource' : 'nullTagValue'


resource appInsights 'Microsoft.Insights/components@2020-02-02-preview' = {
  name: name
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
    publicNetworkAccessForIngestion: 'Enabled'
    publicNetworkAccessForQuery: 'Enabled'
  }
  tags: {
    '${resourceTagName}': resourceTagValue
    purpose: purpose
    customer: customer
    project: project
    environment: environment
    dateCreated: dateCreated
  }
}
