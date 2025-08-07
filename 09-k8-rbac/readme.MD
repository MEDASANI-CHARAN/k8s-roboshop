# Ingress controller

#### Variables 
REGION_CODE=us-east-1
CLUSTER_NAME=roboshop

## 1. create OIDC provider

	eksctl utils associate-iam-oidc-provider \
        --region $REGION_CODE \
        --cluster $CLUSTER_NAME \
        --approve

    {--region <region-code> \ 
     --cluster <your-cluster-name> \}
    
## 2. Create secret in secret manager

## 3. create policy and attach permissions

## 4. Create an IAM role and Kubernetes ServiceAccount for the LBC. Use the ARN from the previous step.

	eksctl create iamserviceaccount \
	--cluster=roboshop \
	--namespace=roboshop \
	--name=roboshop-mysql-secret-reader \
	--attach-policy-arn=arn:aws:iam::009160060207:policy/RoboShopMYSQLSecretReader \
	--override-existing-serviceaccounts \
	--region us-east-1 \
	--approve

### ✅ 1. Using eksctl get iamserviceaccount

eksctl get iamserviceaccount --cluster roboshop --region us-east-1

### ✅ 2. Using kubectl to list service accounts

kubectl get serviceaccounts -n kube-system

### To check whether secret access from CLI

aws secretsmanager get-secret-value \
    --secret-id roboshop/mysql/password