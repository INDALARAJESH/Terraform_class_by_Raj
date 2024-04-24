# resource "aws_instance" "ec2" {
#     ami = data.aws_ami.ubuntu.id
#     instance_type = "t2.micro"
#     tags = {
#       Name = "ec2"
#     }
# }



# resource "aws_vpc" "test1" {
#   cidr_block = "10.0.0.0/16"
#   tags = {
#     Name = "vpc_test-2"
#   }
# }

resource "aws_subnet" "public" {
    cidr_block = "172.31.128.0/20"
    vpc_id = data.aws_vpc.vpc.id
    tags = {
      Name = "pub-sub"
    }
}
