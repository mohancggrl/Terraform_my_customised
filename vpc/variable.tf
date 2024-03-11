variable "access_key" {
  description = "AWS ACCESS_KEY"
  default     = ""
}

variable "secret_key" {
  description = "AWS SECRET_KEY"
  default     = ""
}

######################################

#VPC tags
variable "vpc_cidr" {
  description = "CIDR for the whole VPC"
  type        = string
  default     = "10.0.0.0/23"
}

variable "vpc_tags" {
  type        = map(string)
  description = "vpc_tags"
  default = {
    Name = "eesha_vpc"
    Env  = "Dev"
  }
}

#===================================
#Public Subnet

variable "pub_sub" {
  type        = bool
  default     = true
  description = "create sub net"
}

variable "pub_sub_tags" {
  type        = map(string)
  description = "public subnet extra tags"
  default = {
    Env = "Dev"
  }
}

variable "pub_sub_name" {
  type        = string
  description = "Name of the subnet"
  default     = "eesha_pub_sub"
}

variable "pub_sub_cidr" {
  type        = list(any)
  description = "List of public subnet CIDR blocks"
  default     = ["10.0.0.0/25", "10.0.0.128/25"]
  # default     = []
}

variable "pub_az" {
  type        = list(any)
  description = "List of availability zones"
  default     = ["us-west-2a", "us-west-2b"]
  #  default     = []
}

variable "igw_tags" {
  type        = map(string)
  description = "IGW tags"
  default = {
    Name = "eesha_igw"
    Env  = "Dev"
  }
}

variable "pub_rt" {
  type        = map(string)
  description = "pub rout table"
  default = {
    Name = "eesha_pub_rt"
    Env  = "Dev"
  }
}

#====================================
#private

variable "private_sub" {
  type        = bool
  default     = true
  description = "create sub net"
}

variable "private_sub_tags" {
  type        = map(string)
  description = "privatelic subnet extra tags"
  default = {
    Env = "Dev"
  }
}

variable "private_sub_name" {
  type        = string
  description = "Name of the subnet"
  default     = "eesha_private_sub"
}

variable "private_sub_cidr" {
  type        = list(any)
  description = "List of privatelic subnet CIDR blocks"
  default     = ["10.0.1.0/25", "10.0.1.128/25"]
}

variable "private_az" {
  type        = list(any)
  description = "List of availability zones"
  default     = ["us-west-2c", "us-west-2d"]
}

variable "eip_tags" {
  type        = map(string)
  description = "IGW tags"
  default = {
    Name = "eesha_eip"
    Env  = "Dev"
  }
}

variable "ngw_tags" {
  type        = map(string)
  description = "IGW tags"
  default = {
    Name = "eesha_ngw"
    Env  = "Dev"
  }
}

variable "private_rt" {
  type        = map(string)
  description = "private rout table"
  default = {
    Name = "eesha_private_rt"
    Env  = "Dev"
  }
}

#=========================================
#Jumbox

variable "jumpbox" {
  type        = bool
  default     = true
  description = "create sub net"
}

variable "ami_id" {
  type        = string
  description = "ami_id"
  default     = "ami-0f7197c592205b389"
}

variable "instance_type" {
  type        = string
  description = "instance_type"
  default     = "t3.micro"
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "vpc_security_group_ids"
  default     = null
}

variable "key_name" {
  type        = string
  description = "key_name"
  default     = "eesha"
}

variable "ebs_optimized" {
  type        = bool
  description = "ebs_optimized"
  default     = true
}

variable "volume_type" {
  type        = string
  description = "volume_type"
  default     = "gp2"
}

variable "volume_size" {
  type        = string
  description = "volume_size"
  default     = "20"
}

variable "delete_on_termination" {
  type        = bool
  description = "delete_on_termination"
  default     = true
}

variable "jumpbox_name" {
  type        = string
  description = "jumpbox_name"
  default     = "mahii_jb"
}

variable "jumpbox_tags" {
  type        = map(string)
  description = "jumpbox_tags"
  default = {
    Env = "Dev"
  }
}

variable "target_name" {
  type        = string
  description = "target_name"
  default     = "mahii_target"
}
