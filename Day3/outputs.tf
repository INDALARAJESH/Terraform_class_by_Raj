output "instance_ip" {
  value = aws_instance.ec2.public_ip
}

output "vpc_id" {
    value = aws_vpc.test1.id 
}

output "subnet" {
    value = aws_subnet.public.id
}