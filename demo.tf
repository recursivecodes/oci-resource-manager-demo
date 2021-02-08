variable "compartment_ocid" {}
variable "region" {}
variable "bucket_name" {}

provider "oci" {
  tenancy_ocid = var.tenancy_ocid
  user_ocid = var.user_ocid
  fingerprint = var.fingerprint
  private_key = var.private_key
  private_key_paswword = var.private_key_paswword
  region = var.region
}

data "oci_objectstorage_namespace" "namespace" {
    compartment_id = var.compartment_ocid
}

resource "oci_objectstorage_bucket" "create_bucket" {
    # required
    compartment_id = var.compartment_ocid
    name = var.bucket_name
    namespace = data.oci_objectstorage_namespace.namespace.namespace

    # optional
    access_type = "NoPublicAccess" # <---- updated from "ObjectRead"
}

output "new_bucket" {
  value = oci_objectstorage_bucket.create_bucket
}