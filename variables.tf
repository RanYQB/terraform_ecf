variable "region" {
  description = "Default region"
  type        = string
  default     = "eu-west-3"
}

variable "app_name" {
  description = "Goldenline pyspark application"
  type        = string
  default     = "pyspark-app"
}

variable "bucket_prefix" {
  description = "S3 bucket prefix"
  type = string
  default = "gl-pyspark"
}