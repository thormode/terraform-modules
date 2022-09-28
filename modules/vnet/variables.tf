variable "vnetName" {
  type        = string
  description = "Name of Virtual network"
}

variable "addressSpace" {
  type        = list(string)
  description = "Address space of Virtual network"
}

variable "rgName" {
  type = string
  description = "Name of Resource Group"
}

variable "location" {
  type        = string
  description = "Location of Resource Group"
}

variable "subnetsToCreate" {
  type = list(object({
    name          = string
    addressPrefix = string
  }))

}
