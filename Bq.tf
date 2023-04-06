provider "google" {
  credentials = file("<PATH_TO_YOUR_SERVICE_ACCOUNT_KEY_JSON>")
  project     = "<YOUR_PROJECT_ID>"
  region      = "us-central1"
  zone        = "us-central1-a"
}

resource "google_project_dataset_iam_binding" "dataset_binding" {
  project_id = "<YOUR_PROJECT_ID>"
  dataset_id = "<YOUR_DATASET_ID>"
  role       = "roles/bigquery.user"

  members = [
    "serviceAccount:<YOUR_SERVICE_ACCOUNT_EMAIL>"
  ]
}
