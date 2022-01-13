# Copyright (c) 2022 Oracle and/or its affiliates.

#########
resource "oci_core_network_security_group" "test_vcn1" {
  compartment_id        = var.compartment_ocid
  vcn_id                = oci_core_vcn.vcn1.id
  display_name          = "test"
  
  lifecycle {
    ignore_changes = [defined_tags["Oracle-Tags.CreatedBy"], defined_tags["Oracle-Tags.CreatedOn"]]
  }
  defined_tags = {
    "${oci_identity_tag_namespace.devrel.name}.${oci_identity_tag.release.name}" = local.release
  }
}

# ingress rules - from VCN2
resource "oci_core_network_security_group_security_rule" "i_test_vcn1_from_vcn2" {
  network_security_group_id = oci_core_network_security_group.test_vcn1.id
  direction             = "INGRESS"
  protocol              = "all"
  description           = "Inbound from VCN2"
  source                = oci_core_vcn.vcn2.cidr_block
  source_type           = local.nsg_types["cidr"]
  stateless             = false
}

# egress rules - to VCN2
resource "oci_core_network_security_group_security_rule" "e_test_vcn1_to_vcn2" {
  network_security_group_id = oci_core_network_security_group.test_vcn1.id
  direction             = "EGRESS"
  protocol              = "all"
  description           = "Outbound to VCN2"
  destination           = oci_core_vcn.vcn2.cidr_block
  destination_type      = local.nsg_types["cidr"]
  stateless             = false
}

# egress rules - to VCN1
resource "oci_core_network_security_group_security_rule" "e_test_vcn1_to_vcn1" {
  network_security_group_id = oci_core_network_security_group.test_vcn1.id
  direction             = "EGRESS"
  protocol              = "all"
  description           = "Outbound to VCN1"
  destination           = oci_core_vcn.vcn1.cidr_block
  destination_type      = local.nsg_types["cidr"]
  stateless             = false
}

#########
resource "oci_core_network_security_group" "dns_vcn1" {
  compartment_id        = var.compartment_ocid
  vcn_id                = oci_core_vcn.vcn1.id
  display_name          = "dns"
  
  lifecycle {
    ignore_changes = [defined_tags["Oracle-Tags.CreatedBy"], defined_tags["Oracle-Tags.CreatedOn"]]
  }
  defined_tags = {
    "${oci_identity_tag_namespace.devrel.name}.${oci_identity_tag.release.name}" = local.release
  }
}

# ingress rules - from VCN2
resource "oci_core_network_security_group_security_rule" "i_dns_vcn1_from_vcn2" {
  network_security_group_id = oci_core_network_security_group.dns_vcn1.id
  direction             = "INGRESS"
  protocol              = "17"
  description           = "Inbound from VCN2"
  source                = oci_core_subnet.dns_vcn2.cidr_block
  source_type           = local.nsg_types["cidr"]
  stateless             = false
  
  udp_options {
    destination_port_range {
      max = "53"
      min = "53"
    }
  }
}

# ingress rules - from test NSG
resource "oci_core_network_security_group_security_rule" "i_dns_vcn1_from_test" {
  network_security_group_id = oci_core_network_security_group.dns_vcn1.id
  direction             = "INGRESS"
  protocol              = "17"
  description           = "Inbound from test NSG"
  source                = oci_core_network_security_group.test_vcn1.id
  source_type           = local.nsg_types["nsg"]
  stateless             = false
  
  udp_options {
    destination_port_range {
      max = "53"
      min = "53"
    }
  }
}

# egress rules - to VCN2
resource "oci_core_network_security_group_security_rule" "e_dns_vcn1_to_vcn2" {
  network_security_group_id = oci_core_network_security_group.dns_vcn1.id
  direction             = "EGRESS"
  protocol              = "17"
  description           = "Outbound to VCN2"
  destination           = oci_core_subnet.dns_vcn2.cidr_block
  destination_type      = local.nsg_types["cidr"]
  stateless             = false
  
  udp_options {
    destination_port_range {
      max = "53"
      min = "53"
    }
  }
}


#########
resource "oci_core_network_security_group" "test_vcn2" {
  compartment_id        = var.compartment_ocid
  vcn_id                = oci_core_vcn.vcn2.id
  display_name          = "test"
  
  lifecycle {
    ignore_changes = [defined_tags["Oracle-Tags.CreatedBy"], defined_tags["Oracle-Tags.CreatedOn"]]
  }
  defined_tags = {
    "${oci_identity_tag_namespace.devrel.name}.${oci_identity_tag.release.name}" = local.release
  }
}

# ingress rules - from VCN2
resource "oci_core_network_security_group_security_rule" "i_test_vcn2_from_vcn1" {
  network_security_group_id = oci_core_network_security_group.test_vcn2.id
  direction             = "INGRESS"
  protocol              = "all"
  description           = "Inbound from VCN1"
  source                = oci_core_vcn.vcn1.cidr_block
  source_type           = local.nsg_types["cidr"]
  stateless             = false
}

# egress rules - to VCN2
resource "oci_core_network_security_group_security_rule" "e_test_vcn2_to_vcn1" {
  network_security_group_id = oci_core_network_security_group.test_vcn2.id
  direction             = "EGRESS"
  protocol              = "all"
  description           = "Outbound to VCN1"
  destination           = oci_core_vcn.vcn1.cidr_block
  destination_type      = local.nsg_types["cidr"]
  stateless             = false
}

# egress rules - to VCN2
resource "oci_core_network_security_group_security_rule" "e_test_vcn2_to_vcn2" {
  network_security_group_id = oci_core_network_security_group.test_vcn2.id
  direction             = "EGRESS"
  protocol              = "all"
  description           = "Outbound to VCN2"
  destination           = oci_core_vcn.vcn2.cidr_block
  destination_type      = local.nsg_types["cidr"]
  stateless             = false
}

#########
resource "oci_core_network_security_group" "dns_vcn2" {
  compartment_id        = var.compartment_ocid
  vcn_id                = oci_core_vcn.vcn2.id
  display_name          = "dns"
  
  lifecycle {
    ignore_changes = [defined_tags["Oracle-Tags.CreatedBy"], defined_tags["Oracle-Tags.CreatedOn"]]
  }
  defined_tags = {
    "${oci_identity_tag_namespace.devrel.name}.${oci_identity_tag.release.name}" = local.release
  }
}

# ingress rules - from VCN2
resource "oci_core_network_security_group_security_rule" "i_dns_vcn2_from_vcn1" {
  network_security_group_id = oci_core_network_security_group.dns_vcn2.id
  direction             = "INGRESS"
  protocol              = "17"
  description           = "Inbound from VCN1"
  source                = oci_core_subnet.dns_vcn1.cidr_block
  source_type           = local.nsg_types["cidr"]
  stateless             = false
  
  udp_options {
    destination_port_range {
      max = "53"
      min = "53"
    }
  }
}

# ingress rules - from test NSG
resource "oci_core_network_security_group_security_rule" "i_dns_vcn2_from_test" {
  network_security_group_id = oci_core_network_security_group.dns_vcn2.id
  direction             = "INGRESS"
  protocol              = "17"
  description           = "Inbound from test NSG"
  source                = oci_core_network_security_group.test_vcn2.id
  source_type           = local.nsg_types["nsg"]
  stateless             = false
  
  udp_options {
    destination_port_range {
      max = "53"
      min = "53"
    }
  }
}


# egress rules - to VCN2
resource "oci_core_network_security_group_security_rule" "e_dns_vcn2_to_vcn1" {
  network_security_group_id = oci_core_network_security_group.dns_vcn2.id
  direction             = "EGRESS"
  protocol              = "17"
  description           = "Outbound to VCN1"
  destination           = oci_core_subnet.dns_vcn1.cidr_block
  destination_type      = local.nsg_types["cidr"]
  stateless             = false
  
  udp_options {
    destination_port_range {
      max = "53"
      min = "53"
    }
  }
}