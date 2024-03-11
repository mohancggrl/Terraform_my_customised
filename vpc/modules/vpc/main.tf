# Create an VPC with the CIDR Range
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags                 = var.vpc_tags
}
#==========================================================
#Public Subnet
# Create Public Subnet
resource "aws_subnet" "pub_sub" {
  count                   = var.pub_sub && length(var.pub_sub_cidr) > 0 ? length(var.pub_sub_cidr) : 0
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = element(var.pub_sub_cidr, count.index)
#  cidr_block              = var.pub_sub_cidr[count.index]
  availability_zone       = length(var.pub_az) > 0 ? element(var.pub_az, count.index) : null
#  availability_zone       = var.pub_az[count.index]
  map_public_ip_on_launch = true
  tags = merge(
    var.pub_sub_tags,
    {
       Name          = format("${var.pub_sub_name}_%s", count.index +1)
#      Name          = format("${var.pub_sub_name}_%s_%s", element(var.pub_az, count.index), count.index +1)
#      Name          = format("${var.pub_sub_name}_%s_%s", element(var.pub_az, count.index) > 0 ? aws_subnet.pub_sub.availability_zone[count.inex] : 0, count.index +1)
      # Name                 = "${var.pub_sub_name}-${count.index + 1}",
      },
    )
}

# create Internet Gatway
resource "aws_internet_gateway" "igw" {
  count  = var.pub_sub && length(var.pub_sub_cidr) > 0 ? 1 : 0
  vpc_id = aws_vpc.vpc.id
  tags   = var.igw_tags
}

resource "aws_route_table" "pub_rt" {
  count  = var.pub_sub && length(var.pub_sub_cidr) > 0 ? 1 : 0
  vpc_id = aws_vpc.vpc.id
  tags   = var.pub_rt
}

resource "aws_route_table_association" "pub_rt_ass" {
  count  = var.pub_sub && length(var.pub_sub_cidr) > 0 ? length(var.pub_sub_cidr) : 0
  subnet_id      = aws_subnet.pub_sub[count.index].id
  route_table_id = aws_route_table.pub_rt[0].id
  depends_on     = [aws_route_table.pub_rt]
}

resource "aws_route" "pub_routes" {
  count  = var.pub_sub && length(var.pub_sub_cidr) > 0 ? 1 : 0
  route_table_id         = aws_route_table.pub_rt[0].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw[0].id
  depends_on             = [aws_route_table_association.pub_rt_ass]
}


#==================================================================
#Private Subnet
# Create Public Subnet
resource "aws_subnet" "private_sub" {
  count                   = var.private_sub && length(var.private_sub_cidr) > 0 ? length(var.private_sub_cidr) : 0
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = element(var.private_sub_cidr, count.index)
#  cidr_block              = var.private_sub_cidr[count.index]
  availability_zone       = length(var.private_az) > 0 ? element(var.private_az, count.index) : null
#  availability_zone       = var.private_az[count.index]
  map_public_ip_on_launch = false
  tags = merge(
    var.private_sub_tags,
    {
       Name          = format("${var.private_sub_name}_%s", count.index +1)
#      Name          = format("${var.private_sub_name}-%s_%s", element(var.private_az, count.index), count.index +1)
#      Name                 = "${var.private_sub_name}-${count.index + 1}",
      },
    )
}

# Create an NAT gateway to give our private subnet access the outside world 
resource "aws_eip" "eip_nat" {
  count  = var.pub_sub && length(var.pub_sub_cidr) > 0 && var.private_sub && length(var.private_sub_cidr) > 0 ? 1 : 0
  domain = "vpc"
  tags   = var.eip_tags
}

resource "aws_nat_gateway" "ngw" {
  count  = var.pub_sub && length(var.pub_sub_cidr) > 0 && var.private_sub && length(var.private_sub_cidr) > 0 ? 1 : 0
  depends_on    = [aws_internet_gateway.igw]
  allocation_id = aws_eip.eip_nat[0].id
  subnet_id     = aws_subnet.pub_sub[0].id
  tags   = var.ngw_tags
}

resource "aws_route_table" "private_rt" {
  count  = var.private_sub && length(var.private_sub_cidr) > 0 ? 1 : 0
  vpc_id = aws_vpc.vpc.id
  tags   = var.private_rt
}

resource "aws_route_table_association" "private_rt_ass" {
  count  = var.private_sub && length(var.private_sub_cidr) > 0 ? length(var.private_sub_cidr) : 0
  subnet_id      = aws_subnet.private_sub[count.index].id
  route_table_id = aws_route_table.private_rt[0].id
  depends_on     = [aws_route_table.private_rt]
}

resource "aws_route" "private_routes" {
  count  = var.pub_sub && length(var.pub_sub_cidr) > 0 && var.private_sub && length(var.private_sub_cidr) > 0 ? 1 : 0
  route_table_id         = aws_route_table.private_rt[0].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.ngw[0].id
  depends_on             = [aws_route_table_association.private_rt_ass, aws_nat_gateway.ngw]
}

################################################################################
# Instance
################################################################################

resource "aws_instance" "jumpBox" {
  count  = var.jumpbox && var.pub_sub && length(var.pub_sub_cidr) > 0 ? 1 : 0
  ami                  = var.ami_id
  instance_type        = var.instance_type
  # user_data                   = var.user_data
  subnet_id              = aws_subnet.pub_sub[0].id
  vpc_security_group_ids = var.vpc_security_group_ids
  key_name             = var.key_name
  #associate_public_ip_address = var.associate_public_ip_address
  ebs_optimized = var.ebs_optimized

  root_block_device {
    volume_type           = var.volume_type
    volume_size           = var.volume_size
    delete_on_termination = var.delete_on_termination
  }
  tags = merge(
    var.jumpbox_tags,
    {
       Name       = format("${var.jumpbox_name}_%s", count.index +1)
      },
    )
}

#========================================================================
#Target servers
# resource "aws_instance" "target" {
#   count  = var.jumpbox && var.private_sub && length(var.private_sub_cidr) > 0 ? 1 : 0
#   ami                  = var.ami_id
#   instance_type        = var.instance_type
#   # user_data                   = var.user_data
#   subnet_id              = aws_subnet.private_sub[0].id
#   vpc_security_group_ids = var.vpc_security_group_ids
#   key_name             = var.key_name
#   #associate_public_ip_address = var.associate_public_ip_address
#   ebs_optimized = var.ebs_optimized

#   root_block_device {
#     volume_type           = var.volume_type
#     volume_size           = var.volume_size
#     delete_on_termination = var.delete_on_termination
#   }
#   tags = merge(
#     var.jumpbox_tags,
#     {
#        Name       = format("${var.target_name}_%s", count.index +1)
#       },
#     )
# }