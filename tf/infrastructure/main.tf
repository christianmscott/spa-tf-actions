resource "azurerm_resource_group" "main" {
  name     = "rg-${var.service}-${var.environment}-${var.region.suffix}"
  location = var.region.name
  tags = {
    app         = "${var.service}"
    environment = "${var.environment}"
    created-by  = "terraform"
  }
}
resource "azurerm_storage_account" "main" {
  name                     = trim("sa${var.service}${var.environment}", "-.,/")
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  network_rules {
    default_action = "Allow"
  }
  static_website {
    index_document = "index.html"
  }
  tags = {
    app         = "${var.service}"
    environment = "${var.environment}"
    created-by  = "terraform"
  }
}
resource "azurerm_storage_container" "main" {
  name                  = "${var.service}${var.environment}"
  storage_account_name  = azurerm_storage_account.main.name
  container_access_type = "container"
}
data "azurerm_resource_group" "init" {
  name = "rg-${var.service}-init-${var.region.suffix}"
}
resource "azurerm_dns_cname_record" "main" {
  name                = var.environment
  zone_name           = "${var.service}.${var.domain}"
  resource_group_name = data.azurerm_resource_group.init.name
  ttl                 = 300
  record              = azurerm_storage_account.main.primary_web_host
  tags = {
    app         = "${var.service}"
    environment = "${var.environment}"
    created-by  = "terraform"
  }
}