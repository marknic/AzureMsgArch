param prefix string = 'mn'
param suffix string = '01'
param appName string = 'msgproc'

@description('Value of customer for tags')
param customer string = 'Walgreens'
@description('Value of project for tags')
param project string = 'Harmony'

@description('Value of project for tags')
param addressPrefix string = '10.0.0.0/15'
param environment string = 'dev'
param dateCreated string = utcNow('u')



var dashName = '${prefix}-${appName}-${suffix}-${environment}'
var nodashName = '${prefix}${appName}${suffix}${environment}'

var storageAccountName = '${nodashName}sa'
var vnetName = '${dashName}-vnet'
//var aiName = '${dashName}-ai'

var ehns01Name = '${dashName}-ehns'

resource vnet 'Microsoft.Network/virtualNetworks@2020-06-01' = {
  name: vnetName
  location: resourceGroup().location
  tags: {
    displayName: 'EHUB VNET'
    customer: customer
    project: project
    environment: environment
    dateCreated: dateCreated
  }
  properties: {
    addressSpace: {
      addressPrefixes: [
        addressPrefix
      ]
    }
    enableVmProtection: false
    enableDdosProtection: false
    subnets: [
      {
        name: 'functiona-subnet'
        properties: {
          addressPrefix: '10.0.0.0/24'
        }
      }
      {
        name: 'functionb-subnet'
        properties: {
          addressPrefix: '10.0.1.0/24'
        }
      }
      {
        name: 'functionc-subnet'
        properties: {
          addressPrefix: '10.0.2.0/24'
        }
      }
      {
        name: 'genservices-subnet'
        properties: {
          addressPrefix: '10.0.3.0/24'
        }
      }
    ]
  }
}



resource sa 'Microsoft.Storage/storageAccounts@2019-06-01' = {
  name: storageAccountName // must be globally unique
  location: resourceGroup().location
  tags: {
    diplayName: 'messagestaging'
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
  }
}


resource ehns 'Microsoft.EventHub/namespaces@2018-01-01-preview' = {
  name: ehns01Name
  location: resourceGroup().location
  tags: {
    displayName: 'EHUB VNET'
    customer: customer
    project: project
    environment: environment
    dateCreated: dateCreated
  }
  sku: {
    name: 'Standard'
    tier: 'Standard'
    capacity: 2
  }
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    isAutoInflateEnabled: true
    maximumThroughputUnits: 4
    kafkaEnabled: true
    zoneRedundant: false
  }
  dependsOn: []
}

