variable "service" {
    default = "spa"
}
variable "environment" {}
variable "region" {
    default = {
        name = "East US"
        suffix = "eus"
    }
}
variable "domain" {
    default = "processfoundry.io"
}
