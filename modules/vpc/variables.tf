variable "name" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "azs" {
  description = "Availability zones, one per public subnet"
  type        = list(string)
}

variable "public_subnet_cidrs" {
  type = list(string)
}
