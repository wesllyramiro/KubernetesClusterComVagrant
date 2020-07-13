echo "[TASK 1] Iniciando kubernetes master"
sudo kubeadm init --apiserver-advertise-address=192.168.33.10 --pod-network-cidr=10.244.0.0/16 >> sudo /root/kubeinit.log 2>/dev/null

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

echo "[TASK 2] Implementando pod network"
sudo kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

echo "[TASK 3] Comando para adicionar novo node"
sudo kubeadm token create --print-join-command 