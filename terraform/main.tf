resource "azurerm_resource_group" "rg" {
  name     = "aks-h09-rg"
  location = "canadacentral"
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks-h09-cluster"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "aksh09"

  default_node_pool {
    name       = "default"
    node_count = 1
    min_count  = 1
    max_count  = 3
    vm_size    = "Standard_B2s"
    type       = "VirtualMachineScaleSets"
    enable_auto_scaling = true
  }

  identity {
    type = "SystemAssigned"
  }

  kubernetes_version = null # automatically uses the latest available version

  tags = {
    Environment = "CST8918"
    Project     = "Hybrid-H09"
  }
}
