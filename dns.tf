# Copyright (c) 2022 Oracle and/or its affiliates.

resource "oci_dns_resolver" "vcn1" {
  depends_on = [
    oci_core_vcn.vcn1,
    oci_core_vcn.vcn2,
  ]
  resolver_id = data.oci_core_vcn_dns_resolver_association.vcn1.dns_resolver_id
  scope = "PRIVATE"
  
  ## BEGIN UNCOMMENT AFTER INITIAL DEPLOY
  # attached_views {
  #   view_id = data.oci_dns_views.vcn1.views[0].id
  # }
  # rules {
  #   action = "FORWARD"
  #   destination_addresses = [ local.vcn2_dns_listener["ip"] ]
  #   source_endpoint_name = local.vcn1_dns_forwarder["name"]
  #   qname_cover_conditions = [ oci_core_vcn.vcn2.vcn_domain_name ]
  # }
  ## END UNCOMMENT AFTER INITIAL DEPLOY
  
  lifecycle {
    ignore_changes = [defined_tags["Oracle-Tags.CreatedBy"], defined_tags["Oracle-Tags.CreatedOn"]]
  }
  defined_tags = {
    "${oci_identity_tag_namespace.devrel.name}.${oci_identity_tag.release.name}" = local.release
  }
}

resource "oci_dns_resolver_endpoint" "vcn1_forwarder" {
  depends_on = [
    oci_core_vcn.vcn1,
    oci_core_subnet.dns_vcn1
  ]
  resolver_id = oci_dns_resolver.vcn1.id
  is_forwarding = true
  is_listening = false
  name = local.vcn1_dns_forwarder["name"]
  subnet_id = oci_core_subnet.dns_vcn1.id
  forwarding_address = local.vcn1_dns_forwarder["ip"]
  scope = "PRIVATE"
  
  nsg_ids = [ 
    oci_core_network_security_group.dns_vcn1.id
  ]
}


resource "oci_dns_resolver_endpoint" "vcn1_listener" {
  depends_on = [
    oci_core_vcn.vcn1,
    oci_core_subnet.dns_vcn1
  ]
  resolver_id = oci_dns_resolver.vcn1.id
  is_forwarding = false
  is_listening = true
  name = local.vcn1_dns_listener["name"]
  subnet_id = oci_core_subnet.dns_vcn1.id
  listening_address = local.vcn1_dns_listener["ip"]
  scope = "PRIVATE"
  
  nsg_ids = [ 
    oci_core_network_security_group.dns_vcn1.id
  ]
}



##############
resource "oci_dns_resolver" "vcn2" {
  depends_on = [
    oci_core_vcn.vcn1,
    oci_core_vcn.vcn2,
  ]
  resolver_id = data.oci_core_vcn_dns_resolver_association.vcn2.dns_resolver_id
  scope = "PRIVATE"
  
  ## BEGIN UNCOMMENT AFTER INITIAL DEPLOY
  # attached_views {
  #   view_id = data.oci_dns_views.vcn2.views[0].id
  # }
  # rules {
  #   action = "FORWARD"
  #   destination_addresses = [ local.vcn1_dns_listener["ip"] ]
  #   source_endpoint_name = local.vcn2_dns_forwarder["name"]
  #   qname_cover_conditions = [ oci_core_vcn.vcn1.vcn_domain_name ]
  # }
  ## END UNCOMMENT AFTER INITIAL DEPLOY
  
  lifecycle {
    ignore_changes = [defined_tags["Oracle-Tags.CreatedBy"], defined_tags["Oracle-Tags.CreatedOn"]]
  }
  defined_tags = {
    "${oci_identity_tag_namespace.devrel.name}.${oci_identity_tag.release.name}" = local.release
  }
}

resource "oci_dns_resolver_endpoint" "vcn2_forwarder" {
  depends_on = [
    oci_core_vcn.vcn2,
    oci_core_subnet.dns_vcn2
  ]
  resolver_id = oci_dns_resolver.vcn2.id
  is_forwarding = true
  is_listening = false
  name = local.vcn2_dns_forwarder["name"]
  subnet_id = oci_core_subnet.dns_vcn2.id
  forwarding_address = local.vcn2_dns_forwarder["ip"]
  scope = "PRIVATE"
  
  nsg_ids = [ 
    oci_core_network_security_group.dns_vcn2.id
  ]
}

resource "oci_dns_resolver_endpoint" "vcn2_listener" {
  depends_on = [
    oci_core_vcn.vcn2,
    oci_core_subnet.dns_vcn2
  ]
  resolver_id = oci_dns_resolver.vcn2.id
  is_forwarding = false
  is_listening = true
  name = local.vcn2_dns_listener["name"]
  subnet_id = oci_core_subnet.dns_vcn2.id
  listening_address = local.vcn2_dns_listener["ip"]
  scope = "PRIVATE"
  
  nsg_ids = [ 
    oci_core_network_security_group.dns_vcn2.id
  ]
}
