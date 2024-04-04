resource "random_pet" "rg_name" {
  prefix = var.resource_group_name_prefix
}

resource "azurerm_resource_group" "main" {
  location = var.resource_group_location
  name     = random_pet.rg_name.id
}
