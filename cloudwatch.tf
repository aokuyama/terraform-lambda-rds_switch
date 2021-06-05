resource "aws_cloudwatch_event_rule" "rds_switch" {
  for_each            = var.schedules
  name                = each.key
  description         = each.key
  schedule_expression = each.value.schedule
}

resource "aws_cloudwatch_event_target" "rds_switch" {
  for_each = var.schedules
  rule     = each.key
  arn      = aws_lambda_function.rds_switch.arn
  input    = jsonencode(each.value.target)
}
