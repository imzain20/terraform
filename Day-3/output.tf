//output file to get the information about the EC2 instance
output "public_ip" {
  value = aws_instance.tf-1.public_ip
}

output "cpu_cores" {
    value = aws_instance.tf-1.cpu_core_count
}