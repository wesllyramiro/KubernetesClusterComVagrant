echo "[TASK 1] Instalando Docker"

sudo apt-get update >/dev/null 2>&1

sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common >/dev/null 2>&1

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - >/dev/null 2>&1

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable" >/dev/null 2>&1

sudo apt-get update >/dev/null 2>&1 
sudo apt-get install -y docker-ce docker-ce-cli containerd.io >/dev/null 2>&1

echo "[TASK 2] Habilitando docker server"
sudo systemctl enable docker >/dev/null 2>&1

echo "[TASK 3] Instalando repositorio e ferramentas do kubernetes"

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add - >/dev/null 2>&1

cat <<EOF | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main 
EOF

sudo apt-get update >/dev/null 2>&1

echo "[TASK 4] Instalando kubernetes (kubelet, kubeadm, kubectl)"
sudo apt-get install -y kubelet kubeadm kubectl >/dev/null 2>&1

sudo apt-mark hold kubelet kubeadm kubectl >/dev/null 2>&1

echo "[TASK 5] Desabilitando swap"
swapoff -a >/dev/null 2>&1

# echo "[TASK 6] Habilitar autenticacao no ssh"
# sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
# systemctl reload sshd >/dev/null 2>&1

# echo "[TASK 7] Set root password"
# echo "kubeadmin" | passwd --stdin root >/dev/null 2>&1

# echo "export TERM=xterm" >> /etc/bashrc

# cat >>sudo /etc/hosts<<EOF
# 192.168.33.10 master
# 192.168.33.11 slave1
# 192.168.33.12 slave2 
# EOF