# Copyright (c) 2021 Oracle and/or its affiliates.

resource "oci_core_internet_gateway" "vcn1" {
  compartment_id = var.compartment_ocid
  display_name   = "vcn1"
  vcn_id         = oci_core_vcn.vcn1.id

  enabled = true

  lifecycle {
    ignore_changes = [defined_tags["Oracle-Tags.CreatedBy"], defined_tags["Oracle-Tags.CreatedOn"]]
  }
  defined_tags = {
    "${oci_identity_tag_namespace.devrel.name}.${oci_identity_tag.release.name}" = local.release
  }
}

resource "oci_core_internet_gateway" "vcn2" {
  compartment_id = var.compartment_ocid
  display_name   = "vcn2"
  vcn_id         = oci_core_vcn.vcn2.id

  enabled = true

  lifecycle {
    ignore_changes = [defined_tags["Oracle-Tags.CreatedBy"], defined_tags["Oracle-Tags.CreatedOn"]]
  }
  defined_tags = {
    "${oci_identity_tag_namespace.devrel.name}.${oci_identity_tag.release.name}" = local.release
  }
}
