
@description('name of the resource')
param name string

@description('Address space of VNET')
param addressPrefix string = '10.0.0.0/15'

param subnets array = [
  {
    name: 'functiona-subnet'
    subnetPrefix: '10.0.0.0/24'
  }
  {
    name: 'functionb-subnet'
    subnetPrefix: '10.0.1.0/24'
  }
  {
    name: 'functionc-subnet'
    subnetPrefix: '10.0.2.0/24'
  }
  {
    name: 'genservices-subnet'
    subnetPrefix: '10.0.3.0/24'
  }
  {
    name: 'storage-subnet'
    subnetPrefix: '10.0.3.0/24'
  }
]

// The following params are used for tagging
@description('Value of customer - for tags')
param customer string

@description('Value of project - for tags')
param project string

@description('Environment name - for tags')
param environment string

@description('Resource purpose or description - for tags')
param purpose string

param location string = resourceGroup().location
param dateCreated string = utcNow('u')


resource vnet 'Microsoft.Network/virtualNetworks@2020-06-01' = {
  name: name
  location: location
  tags: {
    purpose: purpose
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
    subnets: [for subnet in subnets: {
      name: subnet.name
      properties: {
        addressPrefix: subnet.subnetPrefix
      }
    }]
  }
}

output vnetId string = vnet.id
