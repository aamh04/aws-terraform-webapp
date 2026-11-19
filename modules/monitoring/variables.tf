variable "name" {
  type = string
}

variable "alert_email" {
  description = "Email for alarm notifications (leave empty to skip subscription)"
  type        = string
  default     = ""
}

variable "asg_name" {
  type = string
}

variable "alb_arn_suffix" {
  type = string
}

variable "target_group_arn_suffix" {
  type = string
}
