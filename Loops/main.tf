resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "timing-11"
    Terraform = "true"
    Environment = "DEV"
  }
  }

  resource "aws_subnet" "public_subnet"{
    count = length(var.public_subnet_cidr) #count2
    vpc_id = aws_vpc.main.id
    cidr_block = var.public_subnet_cidr[count.index]
    availability_zone = var.azs[count.index]

    tags={
      Name = var.public_subnet_names[count.index]
    }  
  }

  resource "aws_subnet" "private_subnet"{
    for_each = var.private_subnets
    vpc_id = aws_vpc.main.id
    cidr_block = each.value.cidr
    availability_zone = each.value.az

    tags={
      Name = each.value.Name
    }  
  }