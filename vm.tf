module "virtual_machine" {
  source = "./vm"

  name = "azurerm_linux_virtual_machine"
  resource_group_name = azurerm_resource_group.main.name

  vm_size = "Standard_D2s_v3"
  os_disk_size_gb = 128
  admin_username = "adminuser"
  admin_password = "Pa$$w0rd123!"
}
