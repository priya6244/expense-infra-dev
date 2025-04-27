variable "project_name" {
    default = "expense"
}

variable "environment" {
    default = "dev"
}

variable "common_tags" {
    default = {
        Project = "expense"
        Terraform = "true"
        Environment = "dev"
    }
}


variable "zone_name" {
    default = "haridev.online"
}

variable "zone_id" {
    default = "Z0319298P5GCQ7XL0T6L"
}