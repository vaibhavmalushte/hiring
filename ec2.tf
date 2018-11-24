#Since we want to place our 2 EC2 instance in two different subnet, created 2 resources

module "ec2_1" {
  source 					= "terraform-aws-modules/ec2-instance/aws"
  name						= "webserver-1"	

  ami						= "${lookup(var.ami_id, var.region)}"
  instance_type         	= "${lookup(local.context_variables[terraform.workspace], "instance_class")}"
  #key_name              	= "${var.ssh_key_name}"

  monitoring            	= true
  vpc_security_group_ids	= ["${aws_security_group.my_web_server_sg.id}"]
  subnet_id             	= "${module.vpc.private_subnets[0]}"
  user_data					= "${var.user_data}"	
  tags 						= {
								Terraform 	= "true"
								Environment	= "${var.namespace}-${var.environment}"
							}  
}

module "ec2_2" ec2-2{
  source 					= "terraform-aws-modules/ec2-instance/aws"
  name						= "webserver-2"

  ami						= "${lookup(var.ami_id, var.region)}"
  instance_type         	= "${lookup(local.context_variables[terraform.workspace], "instance_class")}"
  #key_name              	= "${var.ssh_key_name}"
  monitoring            	= true
  vpc_security_group_ids	= ["${aws_security_group.my_web_server_sg.id}"]
  subnet_id             	= "${module.vpc.private_subnets[1]}"
  user_data					= "${var.user_data}"
  tags 						= {
								Terraform 	= "true"
								Environment	= "${var.namespace}-${var.environment}"
							}
}