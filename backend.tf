resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraform-state-backend-ferry"
  
}

resource "aws_dynamodb_table" "terraform_locks" {
  name           = "terraform-state-locks"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

output "aws_s3_state_bucket" {
  value = aws_s3_bucket.terraform_state.bucket
}

resource "aws_dynamodb_table" "customer_data" {
  name           = "CustomerData"
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "customer_id"

  attribute {
    name = "customer_id"
    type = "S"
  }
}

