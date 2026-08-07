module "resource_group" {
  source = "../../modules/azurerm_resource_group"

  resource_groups = local.resource_groups
}

module "virtual_network" {
  source = "../../modules/azurerm_virtual_network"

  virtual_networks = local.virtual_networks

  depends_on = [module.resource_group]
}

module "subnet" {
  source = "../../modules/azurerm_subnet"

  subnets = local.subnets

  depends_on = [module.virtual_network]
}

module "public_ip" {
  source = "../../modules/azurerm_public_ip"

  public_ips = local.public_ips

  depends_on = [module.resource_group]
}

module "virtual_machine" {
  source = "../../modules/azurerm_virtual_machine"

  virtual_machines = local.virtual_machines

  depends_on = [
    module.subnet,
    module.public_ip
  ]
}
