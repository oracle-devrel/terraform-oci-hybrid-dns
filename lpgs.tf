# Copyright (c) 2022 Oracle and/or its affiliates.

resource "oci_core_local_peering_gateway" "lpg_vcn1" {
  compartment_id = var.compartment_ocid
  vcn_id = oci_core_vcn.vcn1.id
  display_name = "lpg_to_vcn2"
  peer_id = oci_core_local_peering_gateway.lpg_vcn2.id
}

resource "oci_core_local_peering_gateway" "lpg_vcn2" {
  compartment_id = var.compartment_ocid
  vcn_id = oci_core_vcn.vcn2.id
  display_name = "lpg_to_vcn1"
}
