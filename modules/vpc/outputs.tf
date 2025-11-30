output "vpc_id" {
  value = aws_vpc.terravpc.id
}

output "public_subnet_ids" {
  value = aws_subnet.publicsub[*].id
}

output "private_subnet_ids" {
  value = aws_subnet.privatesub[*].id
}
output "nat_gateway_id" {
    value = aws_nat_gateway.terranatgwpub.id
  
}

output "igw_id" {
    value = aws_internet_gateway.terraprojectIGW.id
  
}
