/*

variable "name" {
  type        = string
  description = "Name of the VPC"
}

variable "environment" {
  type        = string
  description = "Name of Environment this VPC is meant to house"
}





variable "availability_zones_dmz" {
  type        = list
  description = "List of availability zones"
}

variable "availability_zones_int" {
  type        = list
  description = "List of availability zones"
}


variable "dmz_subnet_cidr_blocks" {
  type        = list
  description = "List of private subnet CIDR blocks"
}

variable "int_subnet_cidr_blocks" {
  type        = list
  description = "List of private subnet CIDR blocks"
}

#variable "tags" {
#  type        = map(string)
#  description = "Extra tags to attach to the VPC resources"
#}

# variable "vpc_id" {}

*/
#=======================================================
#vpc variable
variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "vpc_tags" {
  type        = map(string)
  description = "vpc_tags"
}

# variable "vpc_id" {
#   type        = list
#   description = "vpc id"
# }

#=======================================================
#Public subnet 

variable "pub_sub" {
#  type        = bool
}

variable "pub_sub_tags" {
  type        = map(string)
  description = "pub_sub_tags"
}

variable "pub_sub_name" {
  type        = string
  description = "Name of the subnet"
}

variable "pub_sub_cidr" {
  type        = list
  description = "List of public subnet CIDR blocks"
}

variable "pub_az" {
  type        = list
  description = "List of availability zones"
}

variable "igw_tags" {
  type        = map(string)
  description = "igw_tags"
}

variable "pub_rt" {
  type        = map(string)
  description = "pub_rt"
}

#=======================================================
#Private subnet

variable "private_sub" {
  type        = bool
}

variable "private_sub_tags" {
  type        = map(string)
  description = "private_sub_tags"
}

variable "private_sub_name" {
  type        = string
  description = "Name of the subnet"
}

variable "private_sub_cidr" {
  type        = list
  description = "List of private subnet CIDR blocks"
}

variable "private_az" {
  type        = list
  description = "List of availability zones for private subnet"
}

variable "eip_tags" {
  type        = map(string)
  description = "eip_tags"
}

variable "ngw_tags" {
  type        = map(string)
  description = "ngw_tags"
}

variable "private_rt" {
  type        = map(string)
  description = "private_rt"
}

# variable "pub_az_aws" {
#   type        = list(string)
#   description = "pub_az_aws"
# }
#==================================================
###EC2

variable "jumpbox" {
  type    = bool
}

variable "ami_id" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "instance_type" {
  type        = string
  description = "instance_type"
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "vpc_security_group_ids"
}

variable "key_name" {
  type        = string
  description = "key_name"
}

variable "ebs_optimized" {
  type        = bool
  description = "ebs_optimized"
}

variable "volume_type" {
  type        = string
  description = "volume_type"
}

variable "volume_size" {
  type        = string
  description = "volume_size"
}

variable "delete_on_termination" {
  type        = bool
  description = "delete_on_termination"
}

variable "jumpbox_name" {
  type        = string
  description = "jumpbox_name"
}

variable "jumpbox_tags" {
  type        = map(string)
  description = "jumpbox_tags"
}

variable "target_name" {
  type        = string
  description = "target_name"
}