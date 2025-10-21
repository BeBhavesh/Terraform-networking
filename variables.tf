variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  
}

variable "vpc_cidr" {
  description = "value"
  type = string
}

variable "public_subnets" {
  description = "value"
    type = list(string)
}
variable "private_subnets" {
  description = "value"
  type = list(string)
}
variable "availability_zones" {
  description = "value"
  type = list(string)
}