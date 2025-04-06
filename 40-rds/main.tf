module "db" {
  source = "terraform-aws-modules/rds/aws"
  create_db_option_group = false
  create_db_parameter_group = false
  create_monitoring_role = false

  identifier = local.resource_name #expense-dev

  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = "db.t3.micro"
  allocated_storage = 5

  db_name  = "transactions"
  username = "root"
  password = "ExpenseApp1"
  port     = "3306"

  manage_master_user_password = false
  skip_final_snapshot = true
  vpc_security_group_ids = [local.mysql_sg_id]

  tags = merge (
    var.common_tags,
    var.rds_tags
  )

  # DB subnet group
  db_subnet_group_name = local.database_subnet_group_name

  # DB parameter group
  family = "mysql8.0"

  # DB option group
  major_engine_version = "8.0"

  parameters = [
    {
      name  = "character_set_client"
      value = "utf8mb4"
    },
    {
      name  = "character_set_server"
      value = "utf8mb4"
    }
  ]

  options = [
    {
      option_name = "MARIADB_AUDIT_PLUGIN"

      option_settings = [
        {
          name  = "SERVER_AUDIT_EVENTS"
          value = "CONNECT"
        },
        {
          name  = "SERVER_AUDIT_FILE_ROTATIONS"
          value = "37"
        },
      ]
    },
  ]
}

module "records" {
  source  = "terraform-aws-modules/route53/aws//modules/records"

  zone_name = var.zone_name #haridev.online -> main domainname

  records = [
    {
      name    = "mysql-${var.environment}" #mysql-dev -> sub-domainname
      type    = "CNAME"
      ttl     = 1
      records = [
        module.db.db_instance_address
      ]
      allow_overwrite = true
    },
  ]
}

# module "db" {
#   source = "terraform-aws-modules/rds/aws"

#   # Disable creation of RDS instance(s)
#   create_db_instance = false

#   # Disable creation of option group - provide an option group or default AWS default
#   create_db_option_group = false

#   # Disable creation of parameter group - provide a parameter group or default to AWS default
#   create_db_parameter_group = false

#   # Enable creation of subnet group (disabled by default)
#   create_db_subnet_group = true

#   # Enable creation of monitoring IAM role
#   create_monitoring_role = true

#   # ... omitted
# }