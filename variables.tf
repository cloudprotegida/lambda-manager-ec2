variable "region" {
  default = "us-east-1"
}

variable "project" {
  default = "lambda-manager-ec2"
}

variable "profile" {
  default = "default"
}

variable "lambda_timeout" {
    default = 60
}

variable lambda_file {
    default = {
        file1 = "startec2"
        file2 = "stopec2"
    }
}

variable "tags" {
  default = {
    Name    = "lambda-manager-ec2"
    Product = "lambda"
    Team    = "sre"
  }
}

variable "sched_expr" {
  default = {
    start = "cron(0 07 ? * MON-FRI *)"
    stop  = "cron(0 20 ? * MON-FRI *)"
  }
}

variable "lambda_env" {
  default = {
    KEY   = "automate"
    VALUE = "Auto-Shutdown"
  }
}
