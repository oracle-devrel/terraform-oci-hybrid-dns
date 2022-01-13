# Copyright (c) 2022 Oracle and/or its affiliates.

resource "oci_core_instance" "test_vcn1" {
  availability_domain = data.oci_identity_availability_domains.this.availability_domains[0].name
  compartment_id      = var.compartment_ocid
  display_name        = "test"
  shape               = local.compute_shape
  shape_config {
    memory_in_gbs = 8
    ocpus = 1
  }
  instance_options {
    are_legacy_imds_endpoints_disabled = true
  }
  create_vnic_details {
    assign_private_dns_record = true
    assign_public_ip          = true
    display_name              = "test"
    hostname_label            = "test"
    nsg_ids = [
      oci_core_network_security_group.test_vcn1.id
    ]
    skip_source_dest_check = false
    subnet_id              = oci_core_subnet.test_vcn1.id
  }
  metadata = {
    ssh_authorized_keys = local.ssh_public_keys
  }
  source_details {
    source_id   = local.latest_ol8_image_id
    source_type = "image"

    boot_volume_size_in_gbs = 50
  }
  preserve_boot_volume = false

  lifecycle {
    ignore_changes = [defined_tags["Oracle-Tags.CreatedBy"], defined_tags["Oracle-Tags.CreatedOn"]]
  }
  defined_tags = {
    "${oci_identity_tag_namespace.devrel.name}.${oci_identity_tag.release.name}" = local.release
  }
}

resource "oci_core_instance" "test_vcn2" {
  availability_domain = data.oci_identity_availability_domains.this.availability_domains[0].name
  compartment_id      = var.compartment_ocid
  display_name        = "test"
  shape               = local.compute_shape
  shape_config {
    memory_in_gbs = 8
    ocpus = 1
  }
  instance_options {
    are_legacy_imds_endpoints_disabled = true
  }
  create_vnic_details {
    assign_private_dns_record = true
    assign_public_ip          = true
    display_name              = "test"
    hostname_label            = "test"
    nsg_ids = [
      oci_core_network_security_group.test_vcn2.id
    ]
    skip_source_dest_check = false
    subnet_id              = oci_core_subnet.test_vcn2.id
  }
  metadata = {
    ssh_authorized_keys = local.ssh_public_keys
  }
  source_details {
    source_id   = local.latest_ol8_image_id
    source_type = "image"

    boot_volume_size_in_gbs = 50
  }
  preserve_boot_volume = false

  lifecycle {
    ignore_changes = [defined_tags["Oracle-Tags.CreatedBy"], defined_tags["Oracle-Tags.CreatedOn"]]
  }
  defined_tags = {
    "${oci_identity_tag_namespace.devrel.name}.${oci_identity_tag.release.name}" = local.release
  }
}