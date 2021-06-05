variable "image-lambda-rds_switch" {
  type        = string
  description = "image-uri@hash"
}

variable "schedules" {
  type = map(object({
    schedule = string
    target   = map(string)
  }))
  default = {
    start-rds = {
      schedule = "cron(0 1 * * ? *)"
      target   = { rds-name = "start" }
    }
    stop-rds = {
      schedule = "cron(0 2 * * ? *)"
      target   = { rds-name = "stop" }
    }
  }
}
