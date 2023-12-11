# resource "aws_s3_bucket" "lambda_code" {
#   bucket = "terraform-lambda-code-ferry"
# }

# resource "aws_secretsmanager_secret" "postgres_master_account" {
#   name        = "postgres_master_account"
#   description = "Postgres master account credentials"
# }
# resource "random_password" "password" {
#   length  = 16
#   special = true
# }

# resource "aws_secretsmanager_secret_version" "db_secret" {
#   secret_id = aws_secretsmanager_secret.postgres_master_account.id
#   secret_string = jsonencode({
#     username = "dbaasadmin1"
#     password = random_password.password.result
#   })
# }

# resource "aws_secretsmanager_secret_rotation" "postgres_rotation" {
#   secret_id                   = aws_secretsmanager_secret.postgres_master_account.id
#   rotation_lambda_arn         = aws_lambda_function.postgres_rotation.arn
#   rotation_rules {
#     automatically_after_days = 30
#   }
# }

# resource "aws_lambda_function" "postgres_rotation" {
#   function_name = "postgres_rotation_function"
#   role          = aws_iam_role.lambda_exec_role.arn
#   handler       = "lambda_function.handler"

#   runtime     = "python3.8"
#   s3_bucket   = aws_s3_bucket.lambda_code.id
#   s3_key      = "lambda_function.zip"

#   environment {
#     variables = {
#       SECRETS_MANAGER_ENDPOINT = "secretsmanager.${var.aws_region}.amazonaws.com"
#     }
#   }
# }


# resource "aws_iam_role" "lambda_exec_role" {
#   name = "lambda_exec_role_for_secret_rotation"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Action = "sts:AssumeRole",
#         Effect = "Allow",
#         Principal = {
#           Service = "lambda.amazonaws.com"
#         },
#       },
#     ],
#   })
# }

# resource "aws_iam_role_policy_attachment" "lambda_exec_role_attach" {
#   role       = aws_iam_role.lambda_exec_role.name
#   policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
# }

# resource "aws_s3_object" "lambda_code" {
#   bucket = aws_s3_bucket.lambda_code.id
#   key    = "lambda_function.zip"  
#   source = "bin/lambda_function.zip"    
#   # etag   = filemd5("lambda_function.zip")
# }

# resource "aws_lambda_permission" "allow_secret_rotation" {
#   statement_id  = "AllowExecutionFromSecretsManager"
#   action        = "lambda:InvokeFunction"
#   function_name = aws_lambda_function.postgres_rotation.function_name
#   principal     = "secretsmanager.amazonaws.com"
#   source_arn    = aws_secretsmanager_secret.postgres_master_account.arn
# }


