output "azs_info" {
  value = module.vpc.az_info.names
}

output "default_vpc" {
  value = module.vpc.default_vpc
}

output "default_vpc_main" {
  value = module.vpc.default_vpc_main
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "database_subnet_ids" {
  value = module.vpc.database_subnet_ids
}