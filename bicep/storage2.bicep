resource mndatastore 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: 'mndatastore'
  location: 'eastus2'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  kind: 'StorageV2'
  properties: {
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess: true
    allowSharedKeyAccess: true
    networkAcls: {
      bypass: 'AzureServices'
      virtualNetworkRules: []
      ipRules: []
      defaultAction: 'Allow'
    }
    supportsHttpsTrafficOnly: true
    encryption: {
      services: {
        file: {
          keyType: 'Account'
          enabled: true
        }
        blob: {
          keyType: 'Account'
          enabled: true
        }
      }
      keySource: 'Microsoft.Storage'
    }
    accessTier: 'Hot'
  }
}

resource mndatastore_default 'Microsoft.Storage/storageAccounts/blobServices@2021-04-01' = {
  parent: mndatastore
  name: 'default'
  properties: {
    changeFeed: {
      enabled: false
    }
    restorePolicy: {
      enabled: false
    }
    containerDeleteRetentionPolicy: {
      enabled: true
      days: 7
    }
    cors: {
      corsRules: []
    }
    deleteRetentionPolicy: {
      enabled: true
      days: 7
    }
    isVersioningEnabled: false
  }
}

resource Microsoft_Storage_storageAccounts_fileServices_mndatastore_default 'Microsoft.Storage/storageAccounts/fileServices@2021-04-01' = {
  parent: mndatastore
  name: 'default'
  properties: {
    protocolSettings: {
      smb: {}
    }
    cors: {
      corsRules: []
    }
    shareDeleteRetentionPolicy: {
      enabled: true
      days: 7
    }
  }
}

resource Microsoft_Storage_storageAccounts_queueServices_mndatastore_default 'Microsoft.Storage/storageAccounts/queueServices@2021-04-01' = {
  parent: mndatastore
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource Microsoft_Storage_storageAccounts_tableServices_mndatastore_default 'Microsoft.Storage/storageAccounts/tableServices@2021-04-01' = {
  parent: mndatastore
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}