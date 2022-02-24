
@description('name of the resource')
param name string

@description('Value of customer - for tags')
param customer string = 'Walgreens'
@description('Value of project - for tags')
param project string = 'Harmony'

@description('Environment designation - for tags')
param environment string = 'dev'


param tags object

resource logworkspace 'microsoft.operationalinsights/workspaces@2020-10-01' = {
  name: name
  location: resourceGroup().location
  tags: tags
  properties: {
    sku: {
      name: 'PerGB2018'
    }
    retentionInDays: 30
    features: {
      enableLogAccessUsingOnlyResourcePermissions: true
    }
    workspaceCapping: {
      dailyQuotaGb: -1
    }
    publicNetworkAccessForIngestion: 'Enabled'
    publicNetworkAccessForQuery: 'Enabled'
  }
}

resource logworkspace_LogManagement_logworkspace_General_AlphabeticallySortedComputers 'Microsoft.OperationalInsights/workspaces/savedSearches@2020-08-01' = {
  parent: logworkspace
  name: 'LogManagement(logworkspace)_General|AlphabeticallySortedComputers'
  properties: {
    displayName: 'All Computers with their most recent data'
    category: 'General Exploration'
    query: 'search not(ObjectName == "Advisor Metrics" or ObjectName == "ManagedSpace") | summarize AggregatedValue = max(TimeGenerated) by Computer | limit 500000 | sort by Computer asc\r\n// Oql: NOT(ObjectName="Advisor Metrics" OR ObjectName=ManagedSpace) | measure max(TimeGenerated) by Computer | top 500000 | Sort Computer // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PTT: True; SortI: True; SortF: True} // Version: 0.1.122'
    version: 2
  }
}

resource logworkspace_LogManagement_logworkspace_General_dataPointsPerManagementGroup 'Microsoft.OperationalInsights/workspaces/savedSearches@2020-08-01' = {
  parent: logworkspace
  name: 'LogManagement(logworkspace)_General|dataPointsPerManagementGroup'
  properties: {
    displayName: 'Which Management Group is generating the most data points?'
    category: 'General Exploration'
    query: 'search * | summarize AggregatedValue = count() by ManagementGroupName\r\n// Oql: * | Measure count() by ManagementGroupName // Args: {OQ: True; WorkspaceId: 00000000-0000-0000-0000-000000000000} // Settings: {PTT: True; SortI: True; SortF: True} // Version: 0.1.122'
    version: 2
  }
}


