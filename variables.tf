# Copyright (c) 2022 Oracle and/or its affiliates.


variable "tenancy_ocid" {
  description = "OCI tenant OCID, more details can be found at https://docs.cloud.oracle.com/en-us/iaas/Content/API/Concepts/apisigningkey.htm#five"
}
variable "region" {
  description = "OCI Region as documented at https://docs.cloud.oracle.com/en-us/iaas/Content/General/Concepts/regions.htm"
  default     = "us-phoenix-1"
}
variable "compartment_ocid" {
  default     = ""
  description = "The compartment OCID to deploy resources to"
}
variable "user_ocid" {
  default     = ""
  description = "OCI user OCID, more details can be found at https://docs.cloud.oracle.com/en-us/iaas/Content/API/Concepts/apisigningkey.htm#five"
}
variable "fingerprint" {
  default     = ""
  description = "'API Key' fingerprint, more details can be found at https://docs.cloud.oracle.com/en-us/iaas/Content/General/Concepts/credentials.htm#two"
}
variable "private_key" {
  default     = ""
  description = "The private key (provided as a string value)"
}
variable "private_key_path" {
  default     = ""
  description = "Path to private key used to create OCI 'API Key', more details can be found at https://docs.cloud.oracle.com/en-us/iaas/Content/General/Concepts/credentials.htm#two"
}
variable "private_key_password" {
  default     = ""
  description = "The password to use for the private key"
}
variable "ssh_pub_key_path" {
  type        = string
  default     = ""
  description = "The path to the SSH public key to use for the compute instances."
}
variable "ssh_pub_key" {
  type        = string
  default     = ""
  description = "The SSH public key contents to use for the compute instances."
}


variable "compute_shape" {
  type        = string
  description = "See https://docs.oracle.com/en-us/iaas/Content/Compute/References/computeshapes.htm for the different compute shapes available."
  default     = "VM.Standard.A1.Flex"
}

variable "permitted_access_cidr" {
  type = string
  description = "The CIDR block permitted to access the servers"
}