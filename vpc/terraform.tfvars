access_key = ""

secret_key = ""

######################################
#VPC tags
vpc_cidr = "10.0.0.0/23"

vpc_tags = {
  Name = "arya_vpc"
  Env  = "Dev"
}

#===================================
#Public Subnet

pub_sub = true

pub_sub_tags = {
  Env = "Dev"
}

pub_sub_name = "arya_pub_sub"

pub_sub_cidr = ["10.0.0.0/25", "10.0.0.128/25"]

pub_az = ["us-west-2a", "us-west-2b"]

igw_tags = {
  Name = "arya_igw"
  Env  = "Dev"
}

pub_rt = {
  Name = "arya_pub_rt"
  Env  = "Dev"
}

#====================================
#private

private_sub = true


private_sub_tags = {
  Env = "Dev"
}

private_sub_name = "arya_private_sub"

private_sub_cidr = ["10.0.1.0/25", "10.0.1.128/25"]

private_az = ["us-west-2c", "us-west-2d"]

eip_tags = {
  Name = "arya_eip"
  Env  = "Dev"
}

ngw_tags = {
  Name = "arya_ngw"
  Env  = "Dev"
}

private_rt = {
  Name = "arya_private_rt"
  Env  = "Dev"
}

#=========================================
#Jumbox

jumpbox = true

ami_id = "ami-0eb5115914ccc4bc2"

instance_type = "t3.micro"

vpc_security_group_ids = null

key_name = "eesha"

ebs_optimized = true

volume_type = "gp2"

volume_size = "20"

delete_on_termination = true

jumpbox_name = "mahii_jb"

jumpbox_tags = {
  Env = "Dev"
}

target_name = "mahii_target"