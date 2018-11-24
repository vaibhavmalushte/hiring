module "db" {
  source = "terraform-aws-modules/rds/aws"

  identifier 					= "${terraform.workspace}-backend"

  engine            			= "mysql"
  engine_version    			= "5.7.19"
  instance_class    			= "${lookup(local.context_variables[terraform.workspace], "db_instance_class")}"
  allocated_storage 			= 5

  name     						= "${terraform.workspace}_web_db"
  username 						= "${lookup(local.context_variables[terraform.workspace], "db_username")}"
  password 						= "${lookup(local.context_variables[terraform.workspace], "db_password")}"
  port     						= "3306"


  vpc_security_group_ids 		= ["${aws_security_group.my_db_server_sg.id}"]

  maintenance_window 			= "Mon:00:00-Mon:03:00"
  backup_window      			= "03:00-06:00"

  monitoring_interval 			= "30"
  monitoring_role_name 			= "rdsmonitoringrole"
  create_monitoring_role 		= true

  subnet_ids 					= ["${module.vpc.database_subnets}"]

  family 						= "mysql5.7"

  final_snapshot_identifier 	= "${terraform.workspace}-web-db"

  deletion_protection 			= "${lookup(local.context_variables[terraform.workspace], "deletion_protection")}"

  create_db_option_group		= false
  parameters 					= [
									{
									  name	= "character_set_client"
									  value	= "utf8"
									},
									{
									  name	= "character_set_server"
									  value	= "utf8"
									}
								  ]
  
  tags 							= {
									Terraform 	= "true"
									Environment	= "${var.namespace}-${terraform.workspace}"
								}
}