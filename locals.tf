locals {
  name = "${var.app_name}"

  tags = {
    "Provisioner" = "terraform"
    "App Name"    = var.app_name
    "App-ID"      = var.app_id
  }
}
