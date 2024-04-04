resource "random_id" "random_id" {
  keepers = {
    resource_group = azurerm_resource_group.main.name
  }
  byte_length = 8
}

resource "azurerm_storage_account" "main" {
  name                     = "diag${random_id.random_id.hex}"
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "staging"
  }
}
