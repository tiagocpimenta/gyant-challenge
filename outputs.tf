#Define Output

output "ip" {
  value = aws_eip.instance.public_ip
}

output "public_dns" {
    value = aws_eip.instance.public_dns
}
