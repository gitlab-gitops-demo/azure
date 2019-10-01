data "gitlab_group" "gitops-demo-apps" {
  full_path = "gitops-demo/apps"
}

provider "gitlab" {
  alias   = "use-pre-release-plugin"
  version = "v2.99.0"
}
resource "gitlab_group_cluster" "aks_cluster" {
  provider           = "gitlab.use-pre-release-plugin"
  group              = "${data.gitlab_group.gitops-demo-apps.id}"
  name               = "${azurerm_kubernetes_cluster.aks.name}"
  domain             = "aks.gitops-demo.com"
  environment_scope  = "aks/*"
  kubernetes_api_url = "${azurerm_kubernetes_cluster.aks.kube_config.0.host}"
  kubernetes_token   = "${data.kubernetes_secret.gitlab-admin-token.data.token}"
  kubernetes_ca_cert = "${trimspace(base64decode(azurerm_kubernetes_cluster.aks.kube_config.0.cluster_ca_certificate))}"

}