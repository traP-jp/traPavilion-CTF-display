terraform {
  required_providers {
    grafana = {
      source  = "grafana/grafana"
      version = ">= 1.24.0"
    }
  }
}

provider "grafana" {
  url  = var.grafana_url
  auth = var.grafana_api_key
}

variable "grafana_url" {
  type = string
}

variable "grafana_api_key" {
  type = string
}

resource "grafana_data_source" "prometheus" {
  name        = "Prometheus"
  type        = "prometheus"
  url         = "http://prometheus:9090"
  access_mode = "proxy"
  is_default  = true
}

resource "grafana_dashboard" "example" {
  config_json = file("${path.module}/dashboards/example.json")
}
