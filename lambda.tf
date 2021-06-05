resource "aws_lambda_function" "rds_switch" {
  function_name = "rds_switch"
  role          = aws_iam_role.rds_switch.arn
  package_type  = "Image"
  image_uri     = var.image-lambda-rds_switch
}
