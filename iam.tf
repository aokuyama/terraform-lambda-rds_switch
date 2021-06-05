resource "aws_iam_role" "rds_switch" {
  path = "/service-role/"
  assume_role_policy = jsonencode(
    {
      Statement = [
        {
          Action = "sts:AssumeRole"
          Effect = "Allow"
          Principal = {
            Service = "lambda.amazonaws.com"
          }
        },
      ]
      Version = "2012-10-17"
    }
  )
  managed_policy_arns = [
    aws_iam_policy.rds_switch.arn
  ]
}

resource "aws_iam_policy" "rds_switch" {
  path = "/service-role/"
  policy = jsonencode(
    {
      Statement = [
        {
          "Effect" : "Allow",
          "Action" : [
            "rds:StartDBInstance",
            "rds:StopDBInstance",
          ],
          "Resource" : [
            "arn:aws:rds:${var.region}:${data.aws_caller_identity.self.account_id}:*"
          ]
        },
        {
          Action   = "logs:CreateLogGroup"
          Effect   = "Allow"
          Resource = "arn:aws:logs:${var.region}:${data.aws_caller_identity.self.account_id}:*"
        },
        {
          Action = [
            "logs:CreateLogStream",
            "logs:PutLogEvents",
          ]
          Effect = "Allow"
          Resource = [
            "arn:aws:logs:${var.region}:${data.aws_caller_identity.self.account_id}:log-group:/aws/lambda/rds_switch:*"
          ]
        },
      ],
      Version = "2012-10-17"
    }
  )
}
