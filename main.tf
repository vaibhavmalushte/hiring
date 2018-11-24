provider "aws" {
  region     					= "${var.region}"
}

module "vpc" {
  source 						= "terraform-aws-modules/vpc/aws"
  
  azs             				= ["${var.azs[var.region]}"]
  #name 							= "${var.vpc_name}"
  name 							= "${lookup(local.context_variables[terraform.workspace], "vpc_name")}"
  cidr 							= "${var.vpc_cidr_block}"
 
  #enable_nat_gateway			= true
  private_subnets 				= "${var.private_subnet_cidr_blocks}"
  public_subnets  				= "${var.public_subnet_cidr_blocks}"
	
  	
  create_database_subnet_group	= true
  database_subnets				= "${var.db_subnet_cidr_blocks}"
  
  tags 							= {
									Terraform 	= "true"
									Environment	= "${var.namespace}-${var.environment}"
								}
}