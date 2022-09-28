module "test" {
  source       = "./modules/vnet"
  rgName       = "testRg"
  vnetName     = "vnet-test"
  addressSpace = ["10.0.0.0/24"]
  location     = "West Europe"
  subnetsToCreate = [
    {
      addressPrefix = cidrsubnet("10.0.0.0/24", 4, 1)
      name          = "subnet1"
    },
    {
      addressPrefix = cidrsubnet("10.0.0.0/24", 4, 2)
      name          = "subnet2"
    }

  ]

}
