# Github Actions Assume Role
# This is a one-time setup per Github Account. So, once you build this role, all of your projects can use it to auth during github action steps

resource "aws_iam_openid_connect_provider" "github" {
url = "https://token.actions.githubusercontent.com"
client_id_list = [
"sts.amazonaws.com",
]
thumbprint_list = ["6938fd4d98bab03faadb97b34396831e3780aea1"]
}
data "aws_iam_policy_document" "github" {
statement {
effect = "Allow"
actions = ["sts:AssumeRoleWithWebIdentity"]

principals {
type = "Federated"
identifiers = [aws_iam_openid_connect_provider.github.arn]
}

condition {
test = "StringEquals"
variable = "token.actions.githubusercontent.com:aud"
values = ["sts.amazonaws.com"]
}

condition {
test = "StringLike"
variable = "token.actions.githubusercontent.com:sub"
values = ["repo:${var.github_workspace}/${var.github_repo}:*"]
}
}
}

resource "aws_iam_role" "github" {
name = "${var.project_prefix}-github-oidc"
assume_role_policy = data.aws_iam_policy_document.github.json
}