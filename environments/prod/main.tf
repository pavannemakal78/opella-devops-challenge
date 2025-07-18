module "vnet" {
  source              = "../../modules/vnet"
  vnet_name           = "prod-vnet"
  location            = "eastus"
  resource_group_name = "prod-rg"
  address_space       = ["10.1.0.0/16"]
  subnet_names        = ["subnet1", "subnet2"]
  subnet_prefixes     = ["10.1.1.0/24", "10.1.2.0/24"]
  tags                = { environment = "prod" }
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                = "prod-vm"
  resource_group_name = "prod-rg"
  location            = "eastus"
  size                = "Standard_B1s"
  admin_username      = "azureuser"
  admin_password      = "Password123!"
  network_interface_ids = [module.vnet.subnet_ids[0]]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
}