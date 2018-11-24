resource "datadog_monitor" "cpu_usage" {
  name           = "CPU usage high"
  query          = "avg(last_5m):avg:aws.ec2.cpuutilization{*} by {host} > 80"
  type           = "query alert"
  notify_no_data = true
  include_tags   = true

  message = <<EOM
CPU usage high: {{value}}
EOM
}

module "datadog_elb_monitor" {
  source    		= "git::https://github.com/traveloka/terraform-datadog-elb"
  product_domain 	= "${var.namespace}"
  service        	= "${var.namespace}-${terraform.workspace}"
  lb_name        	= "${module.elb_http.this_elb_name}"
  lb_type        	= "classic"
  environment    	= "${terraform.workspace}"
  renotify_interval  = 0
  notify_audit       = false
  
  healthy_host_count_thresholds = {
    critical = 1
  }
}