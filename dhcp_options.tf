# Copyright (c) 2022 Oracle and/or its affiliates.

resource "oci_core_dhcp_options" "test_vcn1" {
  compartment_id = var.compartment_ocid
  vcn_id = oci_core_vcn.vcn1.id
  display_name = "test"
  
  options {
    type = "DomainNameServer"
    server_type = "CustomDnsServer"
    custom_dns_servers = [ oci_dns_resolver_endpoint.vcn1_listener.listening_address ]
  }

  options {
    type = "SearchDomain"
    search_domain_names = [ oci_core_vcn.vcn1.vcn_domain_name ]
  }
}

resource "oci_core_dhcp_options" "test_vcn2" {
  compartment_id = var.compartment_ocid
  vcn_id = oci_core_vcn.vcn2.id
  display_name = "test"
  
  options {
    type = "DomainNameServer"
    server_type = "CustomDnsServer"
    custom_dns_servers = [ oci_dns_resolver_endpoint.vcn2_listener.listening_address ]
  }

  options {
    type = "SearchDomain"
    search_domain_names = [ oci_core_vcn.vcn2.vcn_domain_name ]
  }
}

