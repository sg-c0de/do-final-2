data "gitlab_project" "do-final-2" {
  id             = var.gitlab_project_id
}

resource "gitlab_project_hook" "do-final-2" {
  project               = var.gitlab_project_id
  url                   = "${var.gitlab_hook_protocol}://jenkins.lb-${replace(module.yandex_compute["lb"].external_ip[0], ".", "-")}.nip.io/project/do-final"
  token                 = var.jenkins_webhook_token
  enable_ssl_verification = false
  push_events           = true
  push_events_branch_filter = "master"
  job_events            = false
  merge_requests_events = false
  note_events           = false
  pipeline_events       = false
  issues_events         = false
  releases_events       = false
  tag_push_events       = false
  wiki_page_events      = false

}
