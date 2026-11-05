output "app_url" {
  description = "Open this in your browser after apply"
  value       = "http://${module.web.alb_dns_name}"
}

output "asg_name" {
  value = module.web.asg_name
}
