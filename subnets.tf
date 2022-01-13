# Copyright (c) 2022 Oracle and/or its affiliates.

resource "oci_core_subnet" "test_vcn1" {
  vcn_id                     = oci_core_vcn.vcn1.id
  cidr_block                 = "192.168.0.16/28"
  compartment_id             = var.compartment_ocid
  display_name               = "test"
  prohibit_public_ip_on_vnic = false
  dns_label                  = "test"
  availability_domain        = null
  route_table_id             = oci_core_route_table.public_vcn1.id
  dhcp_options_id = oci_core_dhcp_options.test_vcn1.id
}

resource "oci_core_subnet" "dns_vcn1" {
  vcn_id                     = oci_core_vcn.vcn1.id
  cidr_block                 = "192.168.0.0/28"
  compartment_id             = var.compartment_ocid
  display_name               = "dns"
  prohibit_public_ip_on_vnic = true
  dns_label                  = "dns"
  availability_domain        = null
  route_table_id             = oci_core_route_table.dns_vcn1.id
}


resource "oci_core_subnet" "test_vcn2" {
  vcn_id                     = oci_core_vcn.vcn2.id
  cidr_block                 = "10.0.0.16/28"
  compartment_id             = var.compartment_ocid
  display_name               = "test"
  prohibit_public_ip_on_vnic = false
  dns_label                  = "test"
  availability_domain        = null
  route_table_id             = oci_core_route_table.public_vcn2.id
  dhcp_options_id = oci_core_dhcp_options.test_vcn2.id
}

resource "oci_core_subnet" "dns_vcn2" {
  vcn_id                     = oci_core_vcn.vcn2.id
  cidr_block                 = "10.0.0.0/28"
  compartment_id             = var.compartment_ocid
  display_name               = "dns"
  prohibit_public_ip_on_vnic = true
  dns_label                  = "dns"
  availability_domain        = null
  route_table_id             = oci_core_route_table.dns_vcn2.id
}
