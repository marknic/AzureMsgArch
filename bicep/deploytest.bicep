
@description('Standard naming convention prefix')
param prefix string = 'mn'

@description('Standard naming convention suffix/number')
param suffix string = '01'

@description('Standard naming convention application name/abbreviation')
param appName string = 'msgproc'

// The following params are used for tagging
@description('Value of customer - for tags')
param customer string = 'Walgreens'

@description('Value of project - for tags')
param project string = 'Harmony'

@description('Environment name - for tags')
param environment string = 'dev'

var dashName = '${prefix}-${appName}-${suffix}-${environment}'
var nodashName = '${prefix}${appName}${suffix}${environment}'


var vnetName = '${dashName}-base-vnet'

module vnetModule './vnet.bicep' = {
  name: 'vnetDeploy'
  params: {
    name: vnetName
    purpose: 'VNET for the messaging environment'
    addressPrefix: '10.0.0.0/16'
    environment: environment
    customer: customer
    project: project
  }
}

var generalServicesSubnet = 'genservices-subnet'

var subnet_gen_id = '${vnetModule.outputs.vnetId}/subnets/${generalServicesSubnet}'


// App Insights
var aiName = '${dashName}-ai'

module appInsights 'appinsights.bicep' = {
  name: 'aiDeploy01'
  params: {
    purpose: 'App Insights for the Messaging System'
    environment: environment
    customer: customer
    project: project
    name: aiName
    resourceTag: 'hidden-link:/subscriptions/${subscription().id}/resourceGroups/${resourceGroup().name}/providers/Microsoft.Web/sites/${functionAppName}'
  }
}


var storageAccountName = '${nodashName}simdatsa'

module storageModule01 './storage.bicep' = {
  name: 'storageDeploy01'
  params: {
    name: storageAccountName
    purpose: 'Initial storage for the simulated data messages'
    environment: environment
    customer: customer
    project: project
    subnetId: subnet_gen_id
  }
  dependsOn: [
    vnetModule
  ]
}


module storageModule02 './storage.bicep' = {
  name: 
  params: {
    name: 
    subnetId: 
  }
  
}


var aspName = '${dashName}-asp'

module appServicePlan01 './appserviceplan.bicep' = {
  name: 'appserviceplan01'
  params: {
    customer: customer
    environment: environment
    name: aspName
    project: project
    purpose: 'ASP for the Kafka functions'
  }
}


var functionAppName = '${dashName}-pf'


