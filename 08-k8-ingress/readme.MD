# Ingress controller

### IAM --> Roles, permissions, etc.
### K8 --> It is independent platform as a service. K8 has its own RBAC. Why should we integrate K8 RBAC and IAM. Because AWS services should have IAM permissions to create/manage other services. to create AWS services from K8 resources K8 service account should integrate with AWS IAM Role.

#### Variables 
REGION_CODE=us-east-1
CLUSTER_NAME=roboshop

## 1. create OIDC provider

	```
	eksctl utils associate-iam-oidc-provider \
        --region $REGION_CODE \
        --cluster $CLUSTER_NAME \
        --approve
	```
    {--region <region-code> \ 
     --cluster <your-cluster-name> \}

## 2. Download an IAM policy for the LBC using one of the following commands:
   ### If your cluster is in any other region except china and US:
	```
	curl -o iam-policy.json https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.13.2/docs/install/iam_policy.json
	```
   ### By using this url we are generating IAM policy
	```
	cat iam-policy.json
	```

## 3. Create an IAM policy named AWSLoadBalancerControllerIAMPolicy. If you downloaded a different policy, 
   ### Replace iam-policy with the name of the policy that you downloaded.

	```
	aws iam create-policy \
		--policy-name AWSLoadBalancerControllerIAMPolicy \
		--policy-document file://iam-policy.json
	```

## 4. Create an IAM role and Kubernetes ServiceAccount for the LBC. Use the ARN from the previous step.
    ```
	eksctl create iamserviceaccount \
	--cluster=<cluster-name> \
	--namespace=kube-system \
	--name=aws-load-balancer-controller \
	--attach-policy-arn=arn:aws:iam::<AWS_ACCOUNT_ID>:policy/AWSLoadBalancerControllerIAMPolicy \
	--override-existing-serviceaccounts \
	--region <region-code> \
	--approve
    ```

   ### To check whether aws-load-balancer-controller installed or not
    ```
    kubectl get sa -n kube-system
    ```

Then install load blancer controller drivers:
=============================================
Once completed that add ingress controller to cluster

## 1. Install helm (Optional)
	```
	curl -fsSL https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
	```
	
## 2. Add the EKS chart repo to Helm
	```
	helm repo add eks https://aws.github.io/eks-charts
	```
## 3. If upgrading the chart via helm upgrade, install the TargetGroupBinding CRDs. (Optional)
	```
	wget https://raw.githubusercontent.com/aws/eks-charts/master/stable/aws-load-balancer-controller/crds/crds.yaml
    ```
    ```
	kubectl apply -f crds.yaml
	```
## 4. Helm install command for clusters with IRSA:
	```
	helm install aws-load-balancer-controller eks/aws-load-balancer-controller -n kube-system --set clusterName=<cluster-name> --set serviceAccount.create=false --set serviceAccount.name=aws-load-balancer-controller
	```
   ### To check whether aws-load-balancer-controller drivers running or not
    ```
    kubectl get pods -n kube-system
    ```