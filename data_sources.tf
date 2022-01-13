# Copyright (c) 2022 Oracle and/or its affiliates.

data "oci_identity_region_subscriptions" "home_region_subscriptions" {
  tenancy_id = var.tenancy_ocid

  filter {
    name   = "is_home_region"
    values = [true]
  }
}

data "oci_identity_availability_domains" "this" {
  compartment_id = var.tenancy_ocid
}

data "oci_identity_fault_domains" "this" {
  count = length(data.oci_identity_availability_domains.this.availability_domains)
  availability_domain = data.oci_identity_availability_domains.this.availability_domains[count.index].name
  compartment_id = var.tenancy_ocid
}

data "oci_core_images" "latest_ol8" {
  compartment_id           = var.tenancy_ocid
  operating_system         = "Oracle Linux"
  operating_system_version = 8.0
  shape                    = local.compute_shape
  state                    = "AVAILABLE"
  sort_by                  = "TIMECREATED"
  sort_order               = "DESC"
}


data "oci_core_vcn_dns_resolver_association" "vcn1" {
  vcn_id = oci_core_vcn.vcn1.id
}

data "oci_core_vcn_dns_resolver_association" "vcn2" {
  vcn_id = oci_core_vcn.vcn2.id
}

data "oci_dns_views" "vcn1" {
  depends_on = [ oci_core_vcn.vcn1 ]
  compartment_id = var.compartment_ocid
  scope = "PRIVATE"
  display_name = "vcn1"
}

data "oci_dns_views" "vcn2" {
  depends_on = [ oci_core_vcn.vcn2 ]
  compartment_id = var.compartment_ocid
  scope = "PRIVATE"
  display_name = "vcn2"
}