# 1. Update the system
sudo apt update && sudo apt upgrade -y

# 2. Enable swap memory
sudo fallocate -l 2G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab

# 3. Check the space
free -h

# 4. Install k3s :
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--kubelet-arg fail-swap-on=false" sh -

# 5. Veirfy
sudo kubectl get nodes

# 6. Configure kubectl access
mkdir -p ~/.kube
sudo cp /etc/rancher/k3s/k3s.yaml ~/.kube/config
sudo chown $USER:$USER ~/.kube/config

# 7. Install ArgoCD
kubectl create namespace argocd
kubectl apply -n argocd -f \
https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# 8. Access ArgoCd using port forwarding
kubectl port-forward svc/argocd-server -n argocd 8080:443 --address 0.0.0.0

echo "ArgoCd has been successfully installed"



