output "publicip" {
    value = aws_instance.name[*].id
}