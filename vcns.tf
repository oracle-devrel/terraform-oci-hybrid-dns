# Copyright (c) 2022 Oracle and/or its affiliates.

resource "oci_core_vcn" "vcn1" {
  compartment_id = var.compartment_ocid
  display_name   = "vcn1"

  cidr_blocks = [
    "192.168.0.0/24"
  ]
  lifecycle {
    ignore_changes = [defined_tags["Oracle-Tags.CreatedBy"], defined_tags["Oracle-Tags.CreatedOn"]]
  }
  defined_tags = {
    "${oci_identity_tag_namespace.devrel.name}.${oci_identity_tag.release.name}" = local.release
  }
  dns_label      = "vcn1"
  is_ipv6enabled = false
}

resource "oci_core_vcn" "vcn2" {
  compartment_id = var.compartment_ocid
  display_name   = "vcn2"

  cidr_blocks = [
    "10.0.0.0/24"
  ]
  lifecycle {
    ignore_changes = [defined_tags["Oracle-Tags.CreatedBy"], defined_tags["Oracle-Tags.CreatedOn"]]
  }
  defined_tags = {
    "${oci_identity_tag_namespace.devrel.name}.${oci_identity_tag.release.name}" = local.release
  }
  dns_label      = "vcn2"
  is_ipv6enabled = false
}