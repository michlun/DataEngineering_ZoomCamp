variable "credentials" {
    description = "Credentials"
    default = "./keys/my-creds.json"
}

variable "region" {
    description = "Region"
    default = "europe-west10-a"
}

variable "project" {
    description = "Project"
    default = "dataeng-zoomcamp-412520"
}

variable "location" {
    description = "Project Location"
    default = "EU"
}

variable "bq_dataset_name" {
    description = "My BigQuery Dataset Name"
    default = "demo_dataset"
}

variable "gcs_bucket_name" {
    description = "My Storage Bucket Name"
    default = "dataeng-zoomcamp-412520-terra-bucket"
}

variable "gcs_storage_class" {
    description = "Bucket Storage Class"
    default = "STANDARD"
}
