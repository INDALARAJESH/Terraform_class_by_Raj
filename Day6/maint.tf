module "vpc" {
  source   = "../modules/vpc"
  vpc_cidr = var.vpc_cidr
  tags     = var.tags
}


resource "aws_subnet" "name" {
  vpc_id     = module.vpc.vpc_id
  cidr_block = var.subnet_cidr
  map_public_ip_on_launch = true
  depends_on = [module.vpc]
}

resource "aws_internet_gateway" "r12" {
  vpc_id = module.vpc.vpc_id
}

resource "aws_route_table" "example" {
  vpc_id = module.vpc.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.r12.id
  }

  tags = {
    Name = "example"
  }
}

resource "aws_route_table_association" "subnet_association" {
  subnet_id      = aws_subnet.name.id
  route_table_id = aws_route_table.example.id
}


resource "aws_security_group" "sg" {
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "ec2" {
  ami                    = "ami-04e5276ebb8451442"
  key_name               = "Raj"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.sg.id]
  subnet_id              = aws_subnet.name.id
  depends_on             = [aws_security_group.sg]

  tags = {
    Name = "ec2"
  }
}
