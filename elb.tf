module "elb_http" {
  source 					= "terraform-aws-modules/elb/aws"
  name 						= "${var.elb_name}-${terraform.workspace}"

  subnets         			= ["${module.vpc.public_subnets}"]
  security_groups 			= ["${aws_security_group.elb_sg.id}"]
  internal					= false

  listener = [
    {
      instance_port     	= "80"
      instance_protocol 	= "HTTP"
      lb_port           	= "80"
      lb_protocol       	= "HTTP"
    },
  ]

  health_check = [
    {
      target              	= "HTTP:80/"
      interval            	= 30
      healthy_threshold   	= 2
      unhealthy_threshold 	= 2
      timeout             	= 5
    },
  ]

  access_logs = [
    {
      bucket 				= "${var.namespace}-${terraform.workspace}-${lookup(local.context_variables[terraform.workspace], "access_logs_bucket_name")}"
	}
  ]

  number_of_instances 		= 2
  instances          		= ["${module.ec2_1.id[0]}","${module.ec2_2.id[0]}"] 

  tags 						= {
								Terraform 	= "true"
								Environment	= "${var.namespace}-${terraform.workspace}"
							  }
}