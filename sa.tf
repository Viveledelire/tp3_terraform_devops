module "storage_account" {
  source = "./sa"

  name = "azurerm_storage_account"
  resource_group_name = azurerm_resource_group.main.name

  sku = "Standard_LRS"
}
