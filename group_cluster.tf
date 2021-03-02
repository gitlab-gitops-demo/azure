data "gitlab_group" "gitops-demo-apps" {
  full_path = "gitops-demo/apps"
}

data "gitlab_projects" "cluster-management-search" {
  # Returns a list of matching projects. limit to 1 result matching "cluster-management"
  group_id            = data.gitlab_group.gitops-demo-apps.id
  simple              = true
  search              = "cluster-management"
  per_page            = 1
  max_queryable_pages = 1
}

resource "gitlab_group_cluster" "aks_cluster" {
  group                 = data.gitlab_group.gitops-demo-apps.id
  name                  = azurerm_kubernetes_cluster.aks.name
  domain                = "aks.gitops-demo.com"
  environment_scope     = "aks/*"
  kubernetes_api_url    = azurerm_kubernetes_cluster.aks.kube_config.0.host
  kubernetes_token      = data.kubernetes_secret.gitlab-admin-token.data.token
  kubernetes_ca_cert    = trimspace(base64decode(azurerm_kubernetes_cluster.aks.kube_config.0.cluster_ca_certificate))
  management_project_id = data.gitlab_projects.cluster-management-search.projects.0.id
}
