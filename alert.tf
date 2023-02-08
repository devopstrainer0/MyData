provider "google" {
  version = "2.8.0"
}

resource "google_monitoring_alert_policy" "data_flow_failure_alert" {
  display_name = "data_flow_failure_alert"

  combiner = "OR"

  conditions {
    condition_threshold {
      filter = "metric.type = \"dataflow.googleapis.com/job/is_failed\" AND resource.type = \"dataflow_job\""

      comparison = "COMPARISON_EQ"
      threshold_value = 1.0
      duration = "60s"
    }
  }

  notification_channels = [
    google_monitoring_notification_channel.example.id,
  ]
}

resource "google_monitoring_notification_channel" "example" {
  display_name = "example-notification-channel"

  type = "email"
  labels = {
    env = "test"
  }

  email_address = "user@example.com"
}
