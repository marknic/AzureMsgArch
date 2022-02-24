
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

param dateCreated string = utcNow('u')

@description('Resource purpose or description - for tags')
param purpose string = 'storage'

param tags object = {
  purpose: purpose
  customer: customer
  project: project
  environment: environment
  dateCreated: dateCreated
}



var dashName = '${prefix}-${appName}-${suffix}-${environment}'
var nodashName = '${prefix}${appName}${suffix}${environment}'

var logWorkspaceName = '${dashName}-laws'
// App Insights
var aiName = '${dashName}-ai'
var aspName = '${dashName}-asp'

var idBase = '/subscriptions/${subscription().id}/resourceGroups/${resourceGroup().name}/providers'
var logWorkspaceId = '${idBase}/Microsoft.OperationalInsights/workspaces/${logWorkspaceName}'
var appInsightsId = '${idBase}/microsoft.insights/components/${aiName}'
var appServicePlanId = '${idBase}/providers/Microsoft.Web/serverfarms/${aspName}'
var functionAppName = '${dashName}-pf'

module logging './log_analytics_ws.bicep' = {
  name: 'loganalyticsworkspace'
  params: {
    purpose: 'Log storage for the Messaging System'
    environment: environment
    customer: customer
    project: project
    name: logWorkspaceName
  }
}


module appInsights './appinsights.bicep' = {
  name: 'aiDeploy01'
  params: {
    purpose: 'App Insights for the Messaging System'
    environment: environment
    customer: customer
    project: project
    name: aiName
    resourceTag: 'hidden-link:/subscriptions/${subscription().id}/resourceGroups/${resourceGroup().name}/providers/Microsoft.Web/sites/${functionAppName}'
    logWorkspaceId: logWorkspaceId
  }
}

var appInsightsKey = '${appInsights.outputs.instrumentationKey}'

module funcAppA 'function.bicep' = {
  name: 'funcA'
  params: {
    aiInstrumentationKey: appInsightsKey
    aspId: appServicePlanId
    purpose: 'Function A application'
    environment: environment
    customer: customer
    project: project
    name: functionAppName
    storageAccountName: 'funcstor'
  }
  dependsOn: [

  ]
}


// var vnetName = '${dashName}-base-vnet'

// module vnetModule './vnet.bicep' = {
//   name: 'vnetDeploy'
//   params: {
//     name: vnetName
//     purpose: 'VNET for the messaging environment'
//     addressPrefix: '10.0.0.0/16'
//     environment: environment
//     customer: customer
//     project: project
//   }
// }

// var generalServicesSubnet = 'genservices-subnet'

// var subnet_gen_id = '${vnetModule.outputs.vnetId}/subnets/${generalServicesSubnet}'




// var storageAccountName = '${nodashName}simdatsa'

// module storageModule01 './storage.bicep' = {
//   name: 'storageDeploy01'
//   params: {
//     name: storageAccountName
//     purpose: 'Initial storage for the simulated data messages'
//     environment: environment
//     customer: customer
//     project: project
//     subnetId: subnet_gen_id
//   }
//   dependsOn: [
//     vnetModule
//   ]
// }





//

// module appServicePlan01 './appserviceplan.bicep' = {
//   name: 'appserviceplan01'
//   params: {
//     customer: customer
//     environment: environment
//     name: aspName
//     project: project
//     purpose: 'ASP for the Kafka functions'
//   }
// }


//


