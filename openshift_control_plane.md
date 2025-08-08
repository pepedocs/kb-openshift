# OpenShift Control Plane Pods/Applications

## Core Kubernetes Control Plane (Static Pods)
- **etcd-master-X** - etcd database instances
- **kube-apiserver-master-X** - Kubernetes API server
- **kube-controller-manager-master-X** - Kubernetes controllers
- **kube-scheduler-master-X** - Pod scheduler

## OpenShift API Services (Pods)
- **openshift-apiserver-X** - OpenShift API extensions
- **openshift-controller-manager-X** - OpenShift controllers
- **openshift-oauth-apiserver-X** - OAuth API server

## Cluster Operators (Pods)
- **cluster-version-operator** - CVO pod
- **cluster-config-operator** - Config operator pod
- **cluster-dns-operator** - DNS operator pod
- **cluster-ingress-operator** - Ingress operator pod
- **cluster-network-operator** - Network operator pod
- **cluster-storage-operator** - Storage operator pod

## Networking Stack (openshift-sdn)
### Control Plane Pods:
- **sdn-controller** - SDN master controller
### Node Pods (DaemonSet):
- **sdn** - SDN node agent on each worker
- **openvswitch** - Open vSwitch daemon on each node
- **ovs-node** - OVS configuration pod

## Networking Stack (ovn-kubernetes)
### Control Plane Pods:
- **ovnkube-master** - OVN control plane
- **ovn-dbserver-north** - OVN northbound database
- **ovn-dbserver-south** - OVN southbound database
### Node Pods (DaemonSet):
- **ovnkube-node** - OVN node agent on each worker

## DNS Services (Pods)
- **dns-default-X** - CoreDNS pods
- **node-resolver-X** - Node-local DNS cache (DaemonSet)

## Ingress/Routing (Pods)
- **router-default-X** - HAProxy router pods
- **router-internal-default-X** - Internal traffic router

## Authentication (Pods)
- **oauth-openshift-X** - OAuth server pods

## Image Registry (Pods)
- **image-registry-X** - Internal registry pods
- **node-ca-X** - Certificate authority pods (DaemonSet)

## Monitoring Stack (Pods)
- **prometheus-k8s-X** - Prometheus instances
- **alertmanager-main-X** - Alertmanager instances
- **prometheus-operator** - Prometheus operator
- **prometheus-adapter** - Metrics API adapter
- **grafana** - Grafana dashboard
- **node-exporter-X** - Node metrics (DaemonSet)
- **kube-state-metrics** - Kubernetes metrics

## Console (Pods)
- **console-X** - Web console pods
- **downloads-X** - CLI downloads service

## Machine API (Pods)
- **machine-api-operator** - Machine management
- **machine-api-controllers** - Machine controllers
- **cluster-autoscaler-operator** - Autoscaler operator

## Machine Config (Pods)
- **machine-config-operator** - MCO operator pod
- **machine-config-controller** - Machine config controller
- **machine-config-server** - Serves ignition configs
- **machine-config-daemon-X** - MCD on each node (DaemonSet)

## Storage (Pods)
- **csi-driver-X** - Storage drivers (varies by provider)
- **local-storage-operator** - Local storage management

## Security (Pods)
- **service-ca-X** - Service certificate authority
- **configmap-reloader-X** - Certificate reloaders

## Node-Level Host Processes (systemd services)
### Core Node Services:
- **kubelet** - Node agent communicating with API server
- **crio** - Container runtime interface
- **NetworkManager** - Host network management

### System Infrastructure:
- **systemd** - Init system and service manager
- **dbus** - System message bus
- **chronyd** - NTP time synchronization
- **rsyslog** - System logging

### Storage Services:
- **multipathd** - Multipath device management
- **rpcbind** - RPC port mapping service
- **iscsid** - iSCSI initiator daemon (if using iSCSI)

### Security Services:
- **sssd** - System Security Services Daemon (for LDAP/AD)
- **firewalld** - Host firewall management

### Hardware/Device Management:
- **udev** - Device manager
- **tuned** - System tuning daemon

Note: Some networking components like openvswitch may run as both host processes AND pods depending on the CNI configuration.