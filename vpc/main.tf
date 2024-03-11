provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  alias      = "origon"
  region     = "us-west-2"
}

# Create Network-VPC
module "vpc" {
  providers = {
    aws = aws.origon
  }
  source           = "./modules/vpc"
  vpc_cidr         = var.vpc_cidr
  vpc_tags         = var.vpc_tags
  pub_sub          = var.pub_sub
  pub_sub_cidr     = var.pub_sub_cidr
  pub_az           = var.pub_az
  pub_sub_tags     = var.pub_sub_tags
  pub_sub_name     = var.pub_sub_name
  igw_tags         = var.igw_tags
  pub_rt           = var.pub_rt
  private_sub      = var.private_sub
  private_sub_cidr = var.private_sub_cidr
  private_az       = var.private_az
  private_sub_tags = var.private_sub_tags
  private_sub_name = var.private_sub_name
  eip_tags         = var.eip_tags
  ngw_tags         = var.ngw_tags
  private_rt       = var.private_rt
  #========================================
  #ec2
  jumpbox                = var.jumpbox
  ami_id                 = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = var.vpc_security_group_ids
  key_name               = var.key_name
  ebs_optimized          = var.ebs_optimized
  volume_type            = var.volume_type
  volume_size            = var.volume_size
  delete_on_termination  = var.delete_on_termination
  jumpbox_name           = var.jumpbox_name
  target_name            = var.target_name
  jumpbox_tags           = var.jumpbox_tags
}
