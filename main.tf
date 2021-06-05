terraform {
  required_version = ">= 0.15.0"
}

provider "aws" {
  region = var.region
}

variable "region" {
  type    = string
  default = "ap-northeast-1"
}

data "aws_caller_identity" "self" {}

variable "image-lambda-rds_switch" {
  type        = string
  description = "image-uri@hash"
}
