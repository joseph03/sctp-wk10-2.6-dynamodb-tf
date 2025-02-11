/*
#create dynamodb using module
module "dynamodb_table" {
  source  = "terraform-aws-modules/dynamodb-table/aws"
  version = "2.0.0"

  name          = "joseph-table"
  hash_key      = "id"
  range_key     = "title"
  table_class   = "STANDARD"

  attributes = [
    {
      name = "id"
      type = "N"
    },
    {
      name = "title"
      type = "S"
    },
    {
      name = "age"    #all attributes need to be indexed
      type = "N"
    }
  ]

   global_secondary_indexes = [
    {
      name            = "AgeIndex"
      hash_key        = "age"
      projection_type = "ALL"
    }
  ]
  
}
*/

module "dynamodb_book" {
  source = "terraform-aws-modules/dynamodb-table/aws"

  name         = "joseph-bookinventory"
  //billing_mode = "PAY_PER_REQUEST"  # On-demand pricing (remove for provisioned throughput)

  hash_key  = "ISBN"
  range_key = "Genre"

  attributes = [
    {
      name = "ISBN"
      type = "S"
    },
    {
      name = "Genre"
      type = "S"
    },
    {
      name = "version"    #all attributes need to be indexed
      type = "N"
    }
  ]

   global_secondary_indexes = [
    {
      name            = "VerIndex"
      hash_key        = "version"
      projection_type = "ALL"
    }
  ]

  tags = {
    Name        = "Joseph's Book Inventory"
    Environment = "dev"
  }
}

/* error
#create table using resource
resource "aws_dynamodb_table" "resource_bookinventory" {   
  #cannot use numberic eg 2
  # resource name must have different value from name below
  name         = "joseph-resource-bookinventory"           #cannot use numberic eg 2
  #for resource, billing mode or read, write capacity of at least 1 is required
  #billing_mode = "PAY_PER_REQUEST"  # On-demand pricing; remove for provisioned throughput
  read_capacity  = 5
  write_capacity = 5

  hash_key  = "ISBN"
  range_key = "Genre"

  attribute {
    name = "ISBN"
    type = "S"
  }

  attribute {
    name = "Genre"
    type = "S"
  }

  tags = {
    Name        = "Joseph's second Book Inventory"   #cannot use numberic eg 2
    Environment = "dev"
  }
}
*/

