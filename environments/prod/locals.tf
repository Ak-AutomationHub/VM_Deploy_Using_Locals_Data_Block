locals {
  project     = "devopsproject"
  environment = "prod"
  region_code = "india"
  location    = "Central India"

  prefix = lower(
    "${local.project}-${local.environment}-${local.region_code}"
  )

  common_tags = {
    Environment = local.environment
    ManagedBy   = "Terraform"
    Project     = local.project
    Workflow    = "GitOps"
  }

  resource_groups = {
    "rg_01" = {
      name     = "${local.prefix}-rg-01"
      location = local.location
      tags     = local.common_tags
    }
  }

  virtual_networks = {
    "vnet_01" = {
      name                = "${local.prefix}-vnet-01"
      resource_group_name = local.resource_groups.rg_01.name
      location            = local.location
      address_space       = ["10.1.0.0/16"]
      tags                = local.common_tags
    }
  }

  subnets = {
    "snet_app_01" = {
      name                 = "${local.prefix}-snet-app-01"
      virtual_network_name = local.virtual_networks.vnet_01.name
      address_prefixes     = ["10.1.1.0/24"]
      resource_group_name  = local.resource_groups.rg_01.name

    }
  }

  public_ips = {
    "pip_app_01" = {
      name                = "${local.prefix}-pip-app-01"
      location            = local.location
      allocation_method   = "Static"
      sku                 = "Standard"
      resource_group_name = local.resource_groups.rg_01.name
      tags                = local.common_tags
    }
  }

  virtual_machines = {
    vm_app_01 = {

      name                = "${local.prefix}-vm-app-01"
      computer_name       = "appvm01"
      nic_name            = "${local.prefix}-nic-app-01"
      resource_group_name = local.resource_groups.rg_01.name
      location            = local.location
      size                = "Standard_D2s_v3"
      admin_username      = "devopsadmin"
      admin_password      = "Devops@12345"
      tags                = local.common_tags

      ip_configurations = {
        primary = {
          name = "ipconfig-primary"

          subnet_name = local.subnets.snet_app_01.name

          virtual_network_name = local.virtual_networks.vnet_01.name


          public_ip_name = local.public_ips.pip_app_01.name

          private_ip_address_allocation = "Dynamic"
        }
      }

      os_disk = {
        name                 = "${local.prefix}-osdisk-app-01"
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
      }

      source_image_reference = {
        publisher = "Canonical"
        offer     = "0001-com-ubuntu-server-jammy"
        sku       = "22_04-lts"
        version   = "latest"
      }
    }
  }

}

