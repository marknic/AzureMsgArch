resource subnetsizeprmfunsa01 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: 'subnetsizeprmfunsa01'
  location: 'centralus'
  tags: {
    CostCenter: 'IT Innovation 5001'
    Department: 'Innovation'
    LegalSubEntity: 'Walgreen Co'
    SubDivision: 'Innovation'
    DeployDate: '12/15/2020'
    Deployer: 'Luis Cruz'
    DeleteDate: '02/15/2021'
    EnvType: 'Non-Production'
  }
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  kind: 'StorageV2'
  properties: {
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess: true
    networkAcls: {
      bypass: 'AzureServices'
      virtualNetworkRules: [
        {
          id: '/subscriptions/ead5aea8-e662-4627-836e-f893321541b5/resourceGroups/rpu-lcruz-cus-rg-01/providers/Microsoft.Network/virtualNetworks/premium-functions-cus-vnet/subnets/premium-functions-27'
          action: 'Allow'
          state: 'Succeeded'
        }
        {
          id: '/subscriptions/ead5aea8-e662-4627-836e-f893321541b5/resourceGroups/rpu-lcruz-cus-rg-01/providers/Microsoft.Network/virtualNetworks/premium-functions-cus-vnet/subnets/premium-functions-28'
          action: 'Allow'
          state: 'Succeeded'
        }
        {
          id: '/subscriptions/ead5aea8-e662-4627-836e-f893321541b5/resourceGroups/rpu-lcruz-cus-rg-01/providers/Microsoft.Network/virtualNetworks/premium-functions-cus-vnet/subnets/premium-functions-29'
          action: 'Allow'
          state: 'Succeeded'
        }
      ]
      ipRules: [
        {
          value: '63.239.17.0/24'
          action: 'Allow'
        }
        {
          value: '63.73.199.0/24'
          action: 'Allow'
        }
        {
          value: '63.73.199.69'
          action: 'Allow'
        }
      ]
      defaultAction: 'Deny'
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

resource subnetsizeprmfunsa01_default 'Microsoft.Storage/storageAccounts/blobServices@2021-04-01' = {
  parent: subnetsizeprmfunsa01
  name: 'default'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  properties: {
    cors: {
      corsRules: []
    }
    deleteRetentionPolicy: {
      enabled: false
    }
  }
}

resource Microsoft_Storage_storageAccounts_fileServices_subnetsizeprmfunsa01_default 'Microsoft.Storage/storageAccounts/fileServices@2021-04-01' = {
  parent: subnetsizeprmfunsa01
  name: 'default'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  properties: {
    protocolSettings: {
      smb: {}
    }
    cors: {
      corsRules: []
    }
  }
}

resource Microsoft_Storage_storageAccounts_queueServices_subnetsizeprmfunsa01_default 'Microsoft.Storage/storageAccounts/queueServices@2021-04-01' = {
  parent: subnetsizeprmfunsa01
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource Microsoft_Storage_storageAccounts_tableServices_subnetsizeprmfunsa01_default 'Microsoft.Storage/storageAccounts/tableServices@2021-04-01' = {
  parent: subnetsizeprmfunsa01
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource subnetsizeprmfunsa01_default_azure_webjobs_secrets 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-04-01' = {
  parent: subnetsizeprmfunsa01_default
  name: 'azure-webjobs-secrets'
  properties: {
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [
    subnetsizeprmfunsa01
  ]
}

resource subnetsizeprmfunsa01_default_subnet_size_premium_function_test 'Microsoft.Storage/storageAccounts/fileServices/shares@2021-04-01' = {
  parent: Microsoft_Storage_storageAccounts_fileServices_subnetsizeprmfunsa01_default
  name: 'subnet-size-premium-function-test'
  properties: {
    accessTier: 'TransactionOptimized'
    shareQuota: 5120
    enabledProtocols: 'SMB'
  }
  dependsOn: [
    subnetsizeprmfunsa01
  ]
}