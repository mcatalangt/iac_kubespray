export SERVICE_ACCOUNT="[EMAIL_ADDRESS]"
export REPO="mcatalangt/iac_kubespray"

gcloud iam service-accounts add-iam-policy-binding "${SERVICE_ACCOUNT}" \
  --project="${PROJECT_ID}" \
  --role="roles/iam.workloadIdentityUser" \
  --member="principalSet://iam.googleapis.com/projects/${PROJECT_NUMBER}/locations/global/workloadIdentityPools/github-actions-pool/attribute.repository/${REPO}"



  gcloud iam service-accounts add-iam-policy-binding "github-actions-sa@lakehouse-475923.iam.gserviceaccount.com" \
  --project="lakehouse-475923" \
  --role="roles/iam.workloadIdentityUser" \
  --member="principalSet://iam.googleapis.com/projects/397005106927/locations/global/workloadIdentityPools/github-actions-pool/attribute.repository/mcatalangt/iac_kubespray"