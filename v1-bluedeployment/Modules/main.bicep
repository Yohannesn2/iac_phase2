param appGatewayName string = 'phase1apg'
param virtualNetworkName string = 'phase1vnet'
param publicIPAddressName string = 'phase1pbip'
param location string = 'canadacentral'

module virtualNetworkModule './virtualNetwork.bicep' = {
  name: 'virtualNetworkModule'
  params: {
    virtualNetworkName: virtualNetworkName
    location: location
  }
}

module publicIPAddressModule './publicIPAddress.bicep' = {
  name: 'publicIPAddressModule'
  params: {
    publicIPAddressName: publicIPAddressName
    location: location
  }
}

resource appServicePlan 'Microsoft.Web/serverfarms@2021-02-01' = {
  name: 'myAppServicePlan'
  location: location
  sku: {
    name: 'B1'
    tier: 'Basic'
  }
  properties: {
    reserved: true
  }
}

resource webApp1 'Microsoft.Web/sites@2021-01-01' = {
  name: 'webapponeyohannesnirayoblue'
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      appSettings: [
        {
          name: 'WEBSITE_NODE_DEFAULT_VERSION'
          value: '14.17.0'
        }
      ]
      linuxFxVersion: 'DOCKER|hussnain786786/web_app1:latest'
    }
  }
}

resource webApp2 'Microsoft.Web/sites@2021-01-01' = {
  name: 'webapptwoyohannesnirayoblue'
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      appSettings: [
        {
          name: 'WEBSITE_NODE_DEFAULT_VERSION'
          value: '14.17.0'
        }
      ]
      linuxFxVersion: 'DOCKER|hussnain786786/web_app2:latest'
    }
  }
}

module appGatewayModule './appGateway.bicep' = {
  name: 'appGatewayModule'
  params: {
    appGatewayName: appGatewayName
    virtualNetworkName: virtualNetworkName
    publicIPAddressName: publicIPAddressName
    location: location
  }
}


  
