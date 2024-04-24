resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  
  tags = {
    Name = "vpc"
  }
}

resource "aws_subnet" "name" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet_cidr
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "r12" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route_table" "example" {
  vpc_id = aws_vpc.main.id

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
  vpc_id = aws_vpc.main.id

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
  ami                    = "ami-080e1f13689e07408"
  key_name               = "id_rsa"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.sg.id]
  subnet_id              = aws_subnet.name.id
  depends_on             = [aws_security_group.sg]

 provisioner "remote-exec" {
    inline = [
      "touch hello.txt",
      "echo helloworld remote provisioner >> hello.txt",
    ]
  }
  connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ubuntu"
      private_key = file("C:/Users/DELL/.ssh/id_rsa")
      timeout     = "4m"
   } 
  tags = {
    Name = "ec2"
  }
}

resource "aws_key_pair" "deployer" {
  key_name   = "id_rsa"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDZIgnIEXN03RulacvFJDMOUoVr5t7YUo1++gJUfAGMbTcRaQhuCQAxUfxEGyVaJaqKIySAhksm89vUeuIg+I5DcMz48kDphwBnewwS5ivOz88/QkQ2GO0KamnMsjRUsMujYZH/pNaLSQmrLGv4fRUulsKqvSiF0jRsEh+LKD4Bbh6TuEqvs6IbLKYmt7Do0xPXubUie1jyrHapMzJMEBpC8Bbyrs92OFCsfpYEDiOrPjMS2i5Q+SAJziEuEitqg4lBtdBZaEArWUwm+zmXHKXOtQsD5SDiWnXVYphNWXBNAZdRG2YjGlYwDq1bixPFl4zMtPbiB8Pz0xIf+T/2u315 DELL@DESKTOP-RJ70ITN"
}

