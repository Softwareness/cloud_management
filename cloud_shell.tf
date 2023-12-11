resource "aws_cloud9_environment_ec2" "this" {
  name                 = "cloud_9_environment"
  instance_type        = "t2.micro"
  automatic_stop_time_minutes = 60
  image_id = "resolve:ssm:/aws/service/cloud9/amis/ubuntu-22.04-x86_64"
  tags = local.tags
}

data "aws_instance" "cloud9_instance" {
  filter {
    name = "tag:aws:cloud9:environment"
    values = [
    aws_cloud9_environment_ec2.this.id]
  }
  tags = local.tags
}

output "cloud9_url" {
  value = "https://${var.aws_region}.console.aws.amazon.com/cloud9/ide/${aws_cloud9_environment_ec2.this.id}"
}

# resource "aws_iam_user" "this" {
#   name = "service.cpds_cloud9"
#   tags = local.tags
# }

# resource "aws_iam_user_policy_attachment" "admin_access" {
#   user = aws_iam_user.this.name
#   policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
# }

# resource "aws_cloud9_environment_membership" "this" {
#   environment_id = aws_cloud9_environment_ec2.this.id
#   permissions    = "read-write"
#   user_arn       = aws_iam_user.this.arn
# }

resource "aws_cloud9_environment_membership" "myAccount" {
  environment_id = aws_cloud9_environment_ec2.this.id
  permissions    = "read-write"
  user_arn       = "arn:aws:iam::491649323445:user/mac-admin"
}