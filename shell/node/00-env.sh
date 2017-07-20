# set global env

## 定义相关目录
# 01.ssl
pkg_dir=$HOME/install
ssl_work_dir=$pkg_dir/ssl_workdir
ssl_pkg_dir=$pkg_dir/pkg/cfssl
ssl_bin_dir=$ssl_pkg_dir/bin
ssl_config_dir=$ssl_pkg_dir/config

# 02.etcd
etcd_pkg_dir=$pkg_dir/pkg/etcd

# 04.kubernetes
test ! -d /etc/kubernetes/ssl && mkdir -p /etc/kubernetes/ssl
KUBE_APISERVER=https://192.168.61.71:6443 # kubelet 访问的 kube-apiserver 的地址
kube_pkg_dir=$pkg_dir/pkg/kubernetes
kube_tar_file=$kube_pkg_dir/bin/kubernetes-server-linux-amd64.tar.gz
kube_bin_file=$kube_pkg_dir/bin/kubernetes/server/bin

# 04.flanneld
flanneld_dir=$pkg_dir/pkg/flanneld
flanneld_config=$flanneld_dir/config
flanneld_rpm_file=$flanneld_dir/bin
NET_INTERFACE_NAME=eno16777984

# 05.docker
docker_pkg_dir=$basedir/pkg/docker

# 06. base-env
# 当前部署的机器 IP
CURRENT_IP=$(ip add|sed -nr 's#.*inet (.*)/24.*global (.*$)#\1#gp'|head -n 1)

# 建议用 未用的网段 来定义服务网段和 Pod 网段
# 服务网段 (Service CIDR），部署前路由不可达，部署后集群内使用 IP:Port 可达
SERVICE_CIDR="10.254.0.0/16"

# POD 网段 (Cluster CIDR），部署前路由不可达，**部署后**路由可达 (flanneld 保证)
CLUSTER_CIDR="172.18.0.0/16"

# 服务端口范围 (NodePort Range)
NODE_PORT_RANGE="10000-35000"

# flanneld 网络配置前缀
FLANNEL_ETCD_PREFIX="/kubernetes/network"

# 集群 DNS 服务 IP (从 SERVICE_CIDR 中预分配)
CLUSTER_DNS_SVC_IP="10.254.0.2"

# 集群 DNS 域名
CLUSTER_DNS_DOMAIN="cluster.local."

###################################
# etcd
###################################
# 当前部署的机器名称
NODE_NAME=$(hostname|awk -F"." '{print $1}')
# etcd 集群所有机器 IP
NODE_IPS="192.168.61.71 192.168.61.72 192.168.61.73"
## etcd 集群各机器名称和对应的IP、端口
ETCD_NODES=node71=https://192.168.61.71:2380,node72=https://192.168.61.72:2380,node73=https://192.168.61.73:2380

## etcd 集群服务地址列表
ETCD_ENDPOINTS="https://192.168.61.71:2379,https://192.168.61.72:2379,https://192.168.61.73:2379"