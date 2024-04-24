resource "aws_instance" "ec2" {
    ami = data.aws_ami.ubuntu.id
    instance_type = var.ec2_type
    # tags = {
    #   Name = "ec2"
    # }
    tags = local.tags
}

resource "aws_vpc" "test1" {
  cidr_block = var.cidr
  # tags = {
  #   Name = "vpc_test-2"
  # }
  tags = local.tags
}

resource "aws_subnet" "public" {
    cidr_block = var.subnet_id
    vpc_id = aws_vpc.test1.id
    # tags = {
    #   Name = "pub-sub"
    # }
    tags = local.tags
}
