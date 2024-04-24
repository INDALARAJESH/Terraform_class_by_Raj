variable "ec2_type" {
    type = string
    default = "t2.micro"
    description = "instance type"
}

variable "cidr" {
    type = string
    default = "10.0.0.0/16"
    description = "cidr"
}

variable "subnet_id" {
    type = string
    default = "10.0.0.0/24"
    description = "subnet cidr"
  
}
