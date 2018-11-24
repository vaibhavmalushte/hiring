variable "namespace" {
	description 		= "Namespace"
	default				= "soltius-hiring"
}

variable "environment" {
	description 		= "Environment"
	default				= "dev"
}

variable "region" {
	description 		= "Region"
	default     		= "us-east-2"
}


variable "azs" {
	description 		= "Avaliability Zones"
	type    			= "map"
	default 			= {
							"us-east-2" = ["us-east-2a", "us-east-2b"]
						}
}

variable "vpc_cidr_block" {
	description = "The top-level CIDR block for the VPC."
	default     = "10.0.0.0/16"
}

variable "elb_name" {
	description 		= "The ELB name"
	default     		= "my-web-elb"  
}

variable "public_subnet_cidr_blocks" {
	description 		= "The Public subnet CIDR blocks."
	default     		= ["10.0.101.0/24", "10.0.102.0/24"]
}
variable "private_subnet_cidr_blocks" {
	description 		= "The private subnet CIDR blocks."
	default     		= ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "db_subnet_cidr_blocks" {
	description 		= "The private subnet CIDR blocks."
	default     		= ["10.0.51.0/24", "10.0.52.0/24"]
}

variable "ami_id" {
	type    			= "map"
	default 			= {
							"us-east-2" = "ami-04811f5ff471dab4c"
							"us-east-1" = "ami-0cce3ec107ce40cf6"
						}
}


#If required SSH access enable this
#variable "ssh_key_name" {
#	description 		= "The SSH key name"
#	default				= "my-test-key"
#}

variable "user_data" {
	description 		= "Bootstrap script for webserver"
	default		=	<<EOF
#!/bin/bash
service httpd start
chkconfig httpd on
usermod -a -G apache ec2-user
chown -R ec2-user:apache /var/www
chmod 2775 /var/www
find /var/www -type d -exec chmod 2775 {} \;
find /var/www -type f -exec chmod 0664 {} \;
echo '<?php echo "\"Hello New Company!\""; ?>' > /var/www/html/index.php
EOF
}

variable "main_domain" {
	description 		= "The domain name"
	default 			=   "myexample.com"
}