data "archive_file" "lambda_startec2" {
  type        = "zip"
  source_file  = "./lambda/${lambda_file[file1]}.py"
  output_path = "${lambda_file[file1]}.zip"
}

data "archive_file" "lambda_stopec2" {
  type        = "zip"
  source_file  = "./lambda/${lambda_file[file2]}.py"
  output_path = "${lambda_file[file2]}.zip"
}

# Criando os lambdas
resource "aws_lambda_function" "lambda_startec2" {
  filename                = data.archive_file.lambda_startec2.output_path
  function_name           = "${var.project}-${lambda_file[file1]}"
  role                    = aws_iam_role.cloudprotegida-ec2-lambda-role-stopstart.arn
  runtime                 = "python3.7"
  timeout                 = var.lambda_timeout
  handler                 = "${lambda_file[file1]}.lambda_handler"
  tags                    = var.tags
  source_code_hash        = filebase64sha256(data.archive_file.lambda_stopec2.output_path)
   environment {
    variables = {
      TARGET_TAG_KEY      = lookup(var.lambda_env, "KEY") 
      TARGET_TAG_VALUE    = lookup(var.lambda_env, "VALUE")
      REGION   = var.region
    }
 }
}

resource "aws_lambda_function" "lambda_stopec2" {
  filename                = data.archive_file.lambda_stopec2.output_path
  function_name           = "${var.project}-${lambda_file[file2]}"
  role                    = aws_iam_role.cloudprotegida-ec2-lambda-role-stopstart.arn
  runtime                 = "python3.7"
  timeout                 = var.lambda_timeout
  handler                 = "${lambda_file[file2]}.lambda_handler"
  tags                    = var.tags
  source_code_hash        = filebase64sha256(data.archive_file.lambda_stopec2.output_path)
   environment {
    variables = {
      TARGET_TAG_KEY      = lookup(var.lambda_env, "KEY") 
      TARGET_TAG_VALUE    = lookup(var.lambda_env, "VALUE")
    }
 }
}
