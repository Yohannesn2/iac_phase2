param publicIPAddressName string = 'phase1pbip'
param location string = 'canadacentral'

resource publicIPAddress 'Microsoft.Network/publicIPAddresses@2021-02-01' = {
  name: publicIPAddressName
  location: location
  sku: {
    name: 'Standard' // Set the SKU to "Standard"
  }
  properties: {
    publicIPAllocationMethod: 'Static'
  }
}

output publicIPAddressId string = publicIPAddress.id
