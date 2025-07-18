module "vnet" {
  source              = "../../modules/vnet"
  vnet_name           = "dev-vnet"
  location            = "eastus"
  resource_group_name = "dev-rg"
  address_space       = ["10.0.0.0/16"]
  subnet_names        = ["subnet1", "subnet2"]
  subnet_prefixes     = ["10.0.1.0/24", "10.0.2.0/24"]
  tags                = { environment = "dev" }
}
resource "azurerm_network_interface" "nic" {
  name                = "dev-nic"
  location            = "eastus"
  resource_group_name = "dev-rg"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = module.vnet.subnet_ids[0]
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                = "dev-vm"
  resource_group_name = "dev-rg"
  location            = "eastus"
  size                = "Standard_B1s"
  admin_username      = "azureuser"
  admin_password      = random_password.password.result
  network_interface_ids = [azurerm_network_interface.nic.id]
 admin_ssh_key {
    username    = "azureuser"
    public_key  = file("/Users/nemakalpavan/Git_Repos/opella-devops-challenge/environments/dev/id_rsa.pub")
 }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}

resource "random_password" "password" {
  length = 20
  special = true
  override_special = "#!"
}