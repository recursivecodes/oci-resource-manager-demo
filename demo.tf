variable "compartment_ocid" {}
variable "region" {}
variable "bucket_name" {}
variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key" {}
variable "private_key_password" {}

provider "oci" {
  tenancy_ocid = var.tenancy_ocid != null ? var.tenancy_ocid : null
  user_ocid = var.user_ocid != null ? var.user_ocid : null
  fingerprint = var.fingerprint != null ? var.fingerprint : null
  private_key = var.private_key != null ? var.private_key : null
  private_key_password = var.private_key_password != null ? var.private_key_password : null
  region = var.region
}

data "oci_objectstorage_namespace" "namespace" {
    compartment_id = var.compartment_ocid
}

resource "oci_objectstorage_bucket" "create_bucket" {
    compartment_id = var.compartment_ocid
    name = var.bucket_name
    namespace = data.oci_objectstorage_namespace.namespace.namespace
    access_type = "NoPublicAccess"
}

output "new_bucket" {
  value = oci_objectstorage_bucket.create_bucket
}