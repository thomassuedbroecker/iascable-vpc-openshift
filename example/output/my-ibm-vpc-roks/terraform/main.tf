module "cluster" {
  source = "cloud-native-toolkit/ocp-vpc/ibm"
  version = "1.15.4"

  cos_id = module.cos.id
  disable_public_endpoint = var.cluster_disable_public_endpoint
  exists = var.cluster_exists
  flavor = var.cluster_flavor
  force_delete_storage = var.cluster_force_delete_storage
  ibmcloud_api_key = var.ibmcloud_api_key
  kms_enabled = var.cluster_kms_enabled
  kms_id = var.cluster_kms_id
  kms_key_id = var.cluster_kms_key_id
  kms_private_endpoint = var.cluster_kms_private_endpoint
  login = var.cluster_login
  name = var.cluster_name
  name_prefix = var.name_prefix
  ocp_entitlement = var.cluster_ocp_entitlement
  ocp_version = var.ocp_version
  region = var.region
  resource_group_name = module.resource_group.name
  sync = module.resource_group.sync
  tags = var.cluster_tags == null ? null : jsondecode(var.cluster_tags)
  vpc_name = module.ibm-vpc-subnets.vpc_name
  vpc_subnet_count = module.ibm-vpc-subnets.count
  vpc_subnets = module.ibm-vpc-subnets.subnets
  worker_count = var.worker_count
}
module "cos" {
  source = "cloud-native-toolkit/object-storage/ibm"
  version = "4.0.3"

  label = var.cos_label
  name_prefix = var.name_prefix
  plan = var.cos_plan
  provision = var.cos_provision
  resource_group_name = module.resource_group.name
  resource_location = var.cos_resource_location
  tags = var.cos_tags == null ? null : jsondecode(var.cos_tags)
}
module "ibm-vpc" {
  source = "cloud-native-toolkit/vpc/ibm"
  version = "1.16.0"

  address_prefix_count = var.ibm-vpc_address_prefix_count
  address_prefixes = var.ibm-vpc_address_prefixes == null ? null : jsondecode(var.ibm-vpc_address_prefixes)
  base_security_group_name = var.ibm-vpc_base_security_group_name
  internal_cidr = var.ibm-vpc_internal_cidr
  name = var.ibm-vpc_name
  name_prefix = var.name_prefix
  provision = var.ibm-vpc_provision
  region = var.region
  resource_group_name = module.resource_group.name
  tags = var.ibm-vpc_tags == null ? null : jsondecode(var.ibm-vpc_tags)
}
module "ibm-vpc-gateways" {
  source = "cloud-native-toolkit/vpc-gateways/ibm"
  version = "1.9.0"

  provision = var.ibm-vpc-gateways_provision
  region = var.region
  resource_group_id = module.resource_group.id
  tags = var.ibm-vpc-gateways_tags == null ? null : jsondecode(var.ibm-vpc-gateways_tags)
  vpc_name = module.ibm-vpc.name
}
module "ibm-vpc-subnets" {
  source = "cloud-native-toolkit/vpc-subnets/ibm"
  version = "1.13.2"

  _count = var.ibm-vpc-subnets__count
  acl_rules = var.ibm-vpc-subnets_acl_rules == null ? null : jsondecode(var.ibm-vpc-subnets_acl_rules)
  gateways = module.ibm-vpc-gateways.gateways
  ipv4_address_count = var.ibm-vpc-subnets_ipv4_address_count
  ipv4_cidr_blocks = var.ibm-vpc-subnets_ipv4_cidr_blocks == null ? null : jsondecode(var.ibm-vpc-subnets_ipv4_cidr_blocks)
  label = var.ibm-vpc-subnets_label
  provision = var.ibm-vpc-subnets_provision
  region = var.region
  resource_group_name = module.resource_group.name
  tags = var.ibm-vpc-subnets_tags == null ? null : jsondecode(var.ibm-vpc-subnets_tags)
  vpc_name = module.ibm-vpc.name
  zone_offset = var.ibm-vpc-subnets_zone_offset
}
module "resource_group" {
  source = "cloud-native-toolkit/resource-group/ibm"
  version = "3.2.16"

  ibmcloud_api_key = var.ibmcloud_api_key
  resource_group_name = var.resource_group_name
  sync = var.resource_group_sync
}
