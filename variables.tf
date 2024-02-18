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

variable "ami" {
  description = "Amazon machine image"
  type        = string
  default     = "ami-01b32e912c60acdfa" # Ubuntu 22.04 LTS 
}

variable "instance_type" {
  description = "ec2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "bucket_prefix" {
  description = "S3 bucket prefix"
  type        = string
}