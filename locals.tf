# Copyright (c) 2021 Oracle and/or its affiliates.

locals {
  nsg_types = {
    cidr : "CIDR_BLOCK",
    svc : "SERVICE_CIDR_BLOCK",
    nsg : "NETWORK_SECURITY_GROUP"
  }

  dest_types = {
    cidr = "CIDR_BLOCK",
    svc  = "SERVICE_CIDR_BLOCK"
  }

  release = "1.0"

  private_key    = try(file(var.private_key_path), var.private_key)
  ssh_public_key = try(file(var.ssh_pub_key_path), var.ssh_pub_key)

  ssh_public_keys = join("\n", [
    trimspace(local.ssh_public_key)
  ])
  
  latest_ol8_image_id = data.oci_core_images.latest_ol8.images[0].id
  compute_shape = var.compute_shape
  
  num_ads = length(data.oci_identity_availability_domains.this.availability_domains)
  num_fds = { for i in range(local.num_ads):
                i => length(data.oci_identity_fault_domains.this[i])
  }
  
  vcn1_dns_listener = {
    ip = "192.168.0.2"
    name = "listener"
  }
  vcn1_dns_forwarder = {
    ip = "192.168.0.3"
    name = "forwarder"
  }
  vcn2_dns_listener = {
    ip = "10.0.0.2"
    name = "listener"
  }
  vcn2_dns_forwarder = {
    ip = "10.0.0.3"
    name = "forwarder"
  }
}