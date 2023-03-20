variable "service" {
  default = "servicename"
}
variable "environment" {}
variable "region" {
  default = {
    name   = "East US"
    suffix = "eus"
  }
}
variable "domain" {
  default = "domain.com"
}
