output "instanceid" {
    value = aws_instance.name[*].id
}
