# Copyright (c) 2022 Oracle and/or its affiliates.

output "test_vcn1_ssh" {
  value = "ssh opc@${oci_core_instance.test_vcn1.public_ip}"
}

output "test_vcn2_ssh" {
  value = "ssh opc@${oci_core_instance.test_vcn2.public_ip}"
}
