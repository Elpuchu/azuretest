# Creamos la primera máquina virtual
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine

resource "azurerm_linux_virtual_machine" "aztVM" {
    count               = length(var.vms)
    name                = "aztVm-${var.vms[count.index]}"
    resource_group_name = azurerm_resource_group.aztrg.name
    location            = azurerm_resource_group.aztrg.location
    size                = var.vm_size
    admin_username      = var.ssh_user
    network_interface_ids = [ azurerm_network_interface.aztestNic[count.index].id ]
    disable_password_authentication = true

    admin_ssh_key {
        username   = var.ssh_user
        public_key = file(var.public_key_path)
    }

    os_disk {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }

    plan {
        name      = "centos-8-stream-free"
        product   = "centos-8-stream-free"
        publisher = "cognosys"
    }

    source_image_reference {
        publisher = "cognosys"
        offer     = "centos-8-stream-free"
        sku       = "centos-8-stream-free"
        version   = "1.2019.0810"
    }

    boot_diagnostics {
        storage_account_uri = azurerm_storage_account.aztStAcnt.primary_blob_endpoint
    }

    tags = {
        environment = "azuretest"
    }

}
