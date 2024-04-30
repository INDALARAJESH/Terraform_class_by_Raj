# module "vpc" {
#   source = "git@github.com:INDALARAJESH/modules.git//vpc?ref=v1.2.2"
#   vpc_cidr = var.vpc_cidr
#   tags = var.tags
# }

# variable "vpc_cidr" {
#   default = "10.0.0.0/16"
  
# }

# variable "tags" {
#   default = "RAJ"
# }

module "raj" {
  source = "git@github.com:INDALARAJESH/modules.git//ec2?ref=v1.2.2"
}