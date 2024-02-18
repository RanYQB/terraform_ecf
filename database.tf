
resource "aws_dynamodb_table" "pyspark-db" {
  billing_mode     = "PAY_PER_REQUEST"
  hash_key         = "UserId"
  name             = "users"
  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"

  attribute {
    name = "UserId"
    type = "S"
  }
 
}

