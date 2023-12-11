# variable "username" {
#   description = "username for master db user"
#   type = string
# }

# variable "password" {
#   description = "password for master db password"
#   type = string
#   sensitive = true
# }


variable "aws_region" {
  description = "AWS region"
  default = "eu-west-1"
}

variable "app_name" {
  description = "App Name"
  type = string
}

variable "app_id" {
  description = "App Id"
  type = string
}
