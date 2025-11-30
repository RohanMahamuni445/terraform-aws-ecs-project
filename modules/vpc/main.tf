resource "aws_vpc" "terravpc" {
    cidr_block = var.vpc_cidr_block
    enable_dns_hostnames = true

    tags = {
      name = "Terraform_vpc"
    }

}

resource "aws_internet_gateway" "terraprojectIGW" {
  vpc_id = aws_vpc.terravpc.id

  tags = {
    name = "Terraform-IGW"
  }
  
}

resource "aws_eip" "terraeip" {
  domain = "vpc"
  
}


resource "aws_subnet" "publicsub" {
    count = length((var.public_subnet_cidr))
    vpc_id = aws_vpc.terravpc.id
    cidr_block = var.public_subnet_cidr[count.index]
    map_public_ip_on_launch = true
    availability_zone = var.availabilityzones[count.index]

    tags = {
      name = "TerraformPublic-subnet-${count.index +1}"
    }

}

resource "aws_nat_gateway" "terranatgwpub" {
  allocation_id = aws_eip.terraeip.id
  subnet_id = aws_subnet.publicsub.id

  tags = {
    name = "Terraform_Nat_Gw"
    
  }
  
}

resource "aws_route_table" "terra_public_tr" {
  vpc_id = aws_vpc.terravpc.id

  route = {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.terraprojectIGW.id
  }

  tags = {
    name = "TerraPublic_RT"
  }
  
}

resource "aws_route_table_association" "pubassociation" {
  count = length(aws_subnet.publicsub)
  subnet_id = aws_subnet.publicsub[count.index].id
  route_table_id = aws_route_table.terra_public_tr.id
}


resource "aws_subnet" "privatesub" {
    count = length((var.private_subnet_cidr))
    vpc_id = aws_vpc.terravpc.id
    cidr_block = var.private_subnet_cidr[count.index]
    availability_zone = var.availabilityzones[count.index]

    tags = {
      name = "TerraformPrivate-subnet-${count.index +1}"
    }

}

resource "aws_route_table" "terra_private_rt" {
  vpc_id = aws_vpc.terravpc.id

  route = {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.id
  }

  tags = {
    name = "private_rt"
  }

}


resource "aws_route_table_association" "privateassociation" {
  count = length(aws_subnet.privatesub)
  route_table_id = aws_route_table.terra_private_rt.id
  subnet_id = aws_subnet.privatesub[count.index].id
}

