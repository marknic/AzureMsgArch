
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

param skuName string = 'EP2'
param tier string = 'ElasticPremium'
param size string = 'EP2'
param family string = 'EP'
param capacity int = 1

param location string = resourceGroup().location
param dateCreated string = utcNow('u')


resource asp 'Microsoft.Web/serverfarms@2018-02-01' = {
  name: name
  location: location
  tags: {
    purpose: purpose
    customer: customer
    project: project
    environment: environment
    dateCreated: dateCreated
  }
  sku: {
    name: skuName
    tier: tier
    size: size
    family: family
    capacity: capacity
  }
  properties: {
    perSiteScaling: false
    maximumElasticWorkerCount: 20
    isSpot: false
    reserved: true
    isXenon: false
    hyperV: false
    targetWorkerCount: 0
    targetWorkerSizeId: 0
  }
}

output aspId string = asp.id
