# Copyright (c) 2021 Oracle and/or its affiliates.

resource "oci_core_route_table" "public_vcn1" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.vcn1.id
  display_name   = "public"

  route_rules {
    network_entity_id = oci_core_internet_gateway.vcn1.id
    description       = "Default route"
    destination       = "0.0.0.0/0"
    destination_type  = local.dest_types["cidr"]
  }
  route_rules {
    description = "Route to VCN2"
    destination_type = local.dest_types["cidr"]
    destination = "10.0.0.0/24"
    network_entity_id = oci_core_local_peering_gateway.lpg_vcn1.id
  }

  lifecycle {
    ignore_changes = [defined_tags["Oracle-Tags.CreatedBy"], defined_tags["Oracle-Tags.CreatedOn"]]
  }
  defined_tags = {
    "${oci_identity_tag_namespace.devrel.name}.${oci_identity_tag.release.name}" = local.release
  }
}

resource "oci_core_route_table" "dns_vcn1" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.vcn1.id
  display_name   = "dns"

  route_rules {
    description = "Route to VCN2"
    destination_type = local.dest_types["cidr"]
    destination = "10.0.0.0/24"
    network_entity_id = oci_core_local_peering_gateway.lpg_vcn1.id
  }

  lifecycle {
    ignore_changes = [defined_tags["Oracle-Tags.CreatedBy"], defined_tags["Oracle-Tags.CreatedOn"]]
  }
  defined_tags = {
    "${oci_identity_tag_namespace.devrel.name}.${oci_identity_tag.release.name}" = local.release
  }
}

resource "oci_core_route_table" "public_vcn2" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.vcn2.id
  display_name   = "public"

  route_rules {
    network_entity_id = oci_core_internet_gateway.vcn2.id
    description       = "Default route"
    destination       = "0.0.0.0/0"
    destination_type  = local.dest_types["cidr"]
  }
  route_rules {
    description = "Route to VCN1"
    destination_type = local.dest_types["cidr"]
    destination = "192.168.0.0/24"
    network_entity_id = oci_core_local_peering_gateway.lpg_vcn2.id
  }

  lifecycle {
    ignore_changes = [defined_tags["Oracle-Tags.CreatedBy"], defined_tags["Oracle-Tags.CreatedOn"]]
  }
  defined_tags = {
    "${oci_identity_tag_namespace.devrel.name}.${oci_identity_tag.release.name}" = local.release
  }
}

resource "oci_core_route_table" "dns_vcn2" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.vcn2.id
  display_name   = "dns"

  route_rules {
    description = "Route to VCN1"
    destination_type = local.dest_types["cidr"]
    destination = "192.168.0.0/24"
    network_entity_id = oci_core_local_peering_gateway.lpg_vcn2.id
  }

  lifecycle {
    ignore_changes = [defined_tags["Oracle-Tags.CreatedBy"], defined_tags["Oracle-Tags.CreatedOn"]]
  }
  defined_tags = {
    "${oci_identity_tag_namespace.devrel.name}.${oci_identity_tag.release.name}" = local.release
  }
}