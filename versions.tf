# Copyright (c) 2022 Oracle and/or its affiliates.

terraform {
  required_version = ">= 1.0.0"
  
  required_providers {
    oci = {
      source = "hashicorp/oci"
      version = ">= 4.58.0"
    }
  }
}
