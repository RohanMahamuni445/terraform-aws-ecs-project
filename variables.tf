variable "project_name" {}

variable "vpc_cidr_block" {}

variable "public_subnet_cidr" {
  type = list(string)
}

variable "private_subnet_cidr" {
  type = list(string)
}

variable "availabilityzones" {
  type = list(string)
}

variable "ecr_repository_name" {}

