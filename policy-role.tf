# Fetch AWS Account ID
data "aws_caller_identity" "current" {}

# Fetch AWS Region
data "aws_region" "current" {}

# Define IAM Policy for DynamoDB Read Access
resource "aws_iam_policy" "dynamodb_read_policy" {
  name        = "joseph-dynamodb-read-policy"
  description = "Policy to allow read and list operations on DynamoDB table joseph-bookinventory"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        "Effect": "Allow",
        "Action": "dynamodb:ListTables",
        "Resource": "*"     #need this to test aws dynamodb list-tables    
      },
      {
        "Effect": "Allow",
        "Action": [
          "dynamodb:Scan",
          "dynamodb:GetItem",
          "dynamodb:Query"
        ],
        "Resource": "arn:aws:dynamodb:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:table/joseph-bookinventory"
      }
    ]
  })
}

# Define IAM Role for EC2
resource "aws_iam_role" "ec2_role" {
  name = "joseph-ec2-dynamodb-read-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        "Effect": "Allow",
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "ec2.amazonaws.com"
        }
      }
    ]
  })
}

# Attach Policy to Role
resource "aws_iam_role_policy_attachment" "attach_dynamodb_read_policy" {
  policy_arn = aws_iam_policy.dynamodb_read_policy.arn
  role       = aws_iam_role.ec2_role.name
}
