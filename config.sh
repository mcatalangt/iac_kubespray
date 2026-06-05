


  gcloud iam service-accounts add-iam-policy-binding "github-actions-sa@lakehouse-475923.iam.gserviceaccount.com" \
  --project="lakehouse-475923" \
  --role="roles/iam.workloadIdentityUser" \
  --member="principalSet://iam.googleapis.com/projects/397005106927/locations/global/workloadIdentityPools/github-actions-pool/attribute.repository/mcatalangt/iac_kubespray"



  gcloud projects add-iam-policy-binding lakehouse-475923 \
  --member="serviceAccount:github-actions-sa@lakehouse-475923.iam.gserviceaccount.com" \
  --role="roles/compute.securityAdmin"

gcloud projects add-iam-policy-binding lakehouse-475923 \
  --member="serviceAccount:github-actions-sa@lakehouse-475923.iam.gserviceaccount.com" \
  --role="roles/compute.networkAdmin"
