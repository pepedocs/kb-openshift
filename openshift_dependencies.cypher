// OpenShift Component Dependencies Knowledge Graph
// Relationship: A -[:DEPENDS]-> B means A depends on B

// =============================================================================
// CORE COMPONENTS
// =============================================================================

// Create the core components
CREATE (apiserver:Component {
  name: 'kube-apiserver-master-X', 
  type: 'control_plane',
  category: 'static_pod',
  description: 'Kubernetes API server'
})

CREATE (kubelet:Component {
  name: 'kubelet',
  type: 'node_agent',
  category: 'systemd_service',
  description: 'Node agent that manages pods'
})

CREATE (etcd:Component {
  name: 'etcd-master-X',
  type: 'datastore',
  category: 'static_pod',
  description: 'Distributed key-value store for cluster state'
})

// =============================================================================
// COMPONENTS THAT DEPEND ON KUBE-APISERVER
// =============================================================================

// Control Plane Components
CREATE (scheduler:Component {
  name: 'kube-scheduler-master-X',
  type: 'control_plane', 
  category: 'static_pod',
  description: 'Pod scheduler'
})

CREATE (controller_mgr:Component {
  name: 'kube-controller-manager-master-X',
  type: 'control_plane',
  category: 'static_pod', 
  description: 'Kubernetes controllers'
})

CREATE (openshift_controller:Component {
  name: 'openshift-controller-manager-X',
  type: 'control_plane',
  category: 'pod',
  description: 'OpenShift controllers'
})

CREATE (oauth_apiserver:Component {
  name: 'openshift-oauth-apiserver-X',
  type: 'control_plane',
  category: 'pod',
  description: 'OAuth API server'
})

// Cluster Operators
CREATE (cvo:Component {
  name: 'cluster-version-operator',
  type: 'cluster_operator',
  category: 'pod',
  description: 'Cluster version operator'
})

CREATE (config_op:Component {
  name: 'cluster-config-operator', 
  type: 'cluster_operator',
  category: 'pod',
  description: 'Config operator'
})

CREATE (dns_op:Component {
  name: 'cluster-dns-operator',
  type: 'cluster_operator',
  category: 'pod', 
  description: 'DNS operator'
})

CREATE (ingress_op:Component {
  name: 'cluster-ingress-operator',
  type: 'cluster_operator',
  category: 'pod',
  description: 'Ingress operator'
})

CREATE (network_op:Component {
  name: 'cluster-network-operator',
  type: 'cluster_operator',
  category: 'pod',
  description: 'Network operator'
})

CREATE (storage_op:Component {
  name: 'cluster-storage-operator',
  type: 'cluster_operator', 
  category: 'pod',
  description: 'Storage operator'
})

CREATE (aro_operator:Component {
  name: 'aro-operator',
  type: 'cluster_operator',
  category: 'pod',
  description: 'Azure Red Hat OpenShift operator'
})

// Machine Management
CREATE (mco:Component {
  name: 'machine-config-operator',
  type: 'machine_management',
  category: 'pod',
  description: 'Machine config operator'
})

CREATE (mc_controller:Component {
  name: 'machine-config-controller',
  type: 'machine_management',
  category: 'pod', 
  description: 'Machine config controller'
})

CREATE (machine_api_op:Component {
  name: 'machine-api-operator',
  type: 'machine_management',
  category: 'pod',
  description: 'Machine API operator'
})

// =============================================================================
// COMPONENTS THAT KUBELET DEPENDS ON
// =============================================================================

CREATE (crio:Component {
  name: 'crio',
  type: 'container_runtime',
  category: 'systemd_service',
  description: 'Container runtime interface'
})

CREATE (systemd:Component {
  name: 'systemd',
  type: 'system_infrastructure',
  category: 'systemd_service',
  description: 'Init system and service manager'
})

CREATE (network_mgr:Component {
  name: 'NetworkManager',
  type: 'system_infrastructure',
  category: 'systemd_service',
  description: 'Host network management'
})

CREATE (dnsmasq:Component {
  name: 'dnsmasq',
  type: 'networking',
  category: 'systemd_service',
  description: 'Local DNS resolver and DHCP service'
})

// =============================================================================
// COMPONENTS THAT DEPEND ON KUBELET
// =============================================================================

// Node-Level Networking
CREATE (sdn_node:Component {
  name: 'sdn',
  type: 'networking',
  category: 'daemonset',
  description: 'SDN node agent on each worker'
})

CREATE (ovnkube_node:Component {
  name: 'ovnkube-node',
  type: 'networking',
  category: 'daemonset',
  description: 'OVN node agent on each worker'
})

CREATE (openvswitch:Component {
  name: 'openvswitch',
  type: 'networking',
  category: 'daemonset',
  description: 'Open vSwitch daemon on each node'
})

CREATE (ovs_node:Component {
  name: 'ovs-node',
  type: 'networking',
  category: 'daemonset',
  description: 'OVS configuration pod'
})

CREATE (node_resolver:Component {
  name: 'node-resolver-X',
  type: 'networking',
  category: 'daemonset',
  description: 'Node-local DNS cache'
})

// Node Monitoring
CREATE (node_exporter:Component {
  name: 'node-exporter-X',
  type: 'monitoring',
  category: 'daemonset',
  description: 'Node metrics collection'
})

CREATE (node_ca:Component {
  name: 'node-ca-X',
  type: 'security',
  category: 'daemonset',
  description: 'Certificate authority pods'
})

// Machine Config
CREATE (mcd:Component {
  name: 'machine-config-daemon-X',
  type: 'machine_management',
  category: 'daemonset',
  description: 'Machine config daemon on each node'
})

// Application Workloads
CREATE (app_pods:Component {
  name: 'application-pods',
  type: 'workload',
  category: 'pod',
  description: 'All application pods scheduled to the node'
})

// =============================================================================
// DEPENDENCY RELATIONSHIPS
// =============================================================================

// etcd dependencies on network infrastructure
CREATE (etcd)-[:DEPENDS]->(systemd)
CREATE (etcd)-[:DEPENDS]->(network_mgr)

// Dependencies on etcd
CREATE (apiserver)-[:DEPENDS]->(etcd)

// Dependencies on kube-apiserver
CREATE (scheduler)-[:DEPENDS]->(apiserver)
CREATE (controller_mgr)-[:DEPENDS]->(apiserver)
CREATE (openshift_controller)-[:DEPENDS]->(apiserver)
CREATE (oauth_apiserver)-[:DEPENDS]->(apiserver)
CREATE (cvo)-[:DEPENDS]->(apiserver)
CREATE (config_op)-[:DEPENDS]->(apiserver)
CREATE (dns_op)-[:DEPENDS]->(apiserver)
CREATE (ingress_op)-[:DEPENDS]->(apiserver)
CREATE (network_op)-[:DEPENDS]->(apiserver)
CREATE (storage_op)-[:DEPENDS]->(apiserver)
CREATE (mco)-[:DEPENDS]->(apiserver)
CREATE (mc_controller)-[:DEPENDS]->(apiserver)
CREATE (machine_api_op)-[:DEPENDS]->(apiserver)
CREATE (aro_operator)-[:DEPENDS]->(apiserver)
CREATE (kubelet)-[:DEPENDS]->(apiserver)

// Kubelet dependencies
CREATE (kubelet)-[:DEPENDS]->(crio)
CREATE (kubelet)-[:DEPENDS]->(systemd)
CREATE (kubelet)-[:DEPENDS]->(network_mgr)

// Machine config dependencies
CREATE (mc_controller)-[:DEPENDS]->(mco)
CREATE (mcd)-[:DEPENDS]->(mco)
CREATE (mcd)-[:DEPENDS]->(systemd)

// Components that depend on machine config (node configuration)
CREATE (kubelet)-[:DEPENDS]->(mcd)
CREATE (crio)-[:DEPENDS]->(mcd)
CREATE (systemd)-[:DEPENDS]->(mcd)
CREATE (network_mgr)-[:DEPENDS]->(mcd)
CREATE (dnsmasq)-[:DEPENDS]->(mcd)

// dnsmasq dependencies and relationships
CREATE (dnsmasq)-[:DEPENDS]->(systemd)
CREATE (dnsmasq)-[:DEPENDS]->(network_mgr)
CREATE (kubelet)-[:DEPENDS]->(dnsmasq)
CREATE (node_resolver)-[:DEPENDS]->(dnsmasq)

// Dependencies on kubelet
CREATE (sdn_node)-[:DEPENDS]->(kubelet)
CREATE (ovnkube_node)-[:DEPENDS]->(kubelet)
CREATE (openvswitch)-[:DEPENDS]->(kubelet)
CREATE (ovs_node)-[:DEPENDS]->(kubelet)
CREATE (node_resolver)-[:DEPENDS]->(kubelet)
CREATE (node_exporter)-[:DEPENDS]->(kubelet)
CREATE (node_ca)-[:DEPENDS]->(kubelet)
CREATE (mcd)-[:DEPENDS]->(kubelet)
CREATE (app_pods)-[:DEPENDS]->(kubelet)

// =============================================================================
// USEFUL QUERIES
// =============================================================================

// Find all components that depend on etcd
// MATCH (component)-[:DEPENDS]->(etcd:Component {name: 'etcd-master-X'})
// RETURN component.name, component.type, component.category

// Verify etcd relationships exist
// MATCH (etcd:Component {name: 'etcd-master-X'})
// OPTIONAL MATCH (dependent)-[:DEPENDS]->(etcd)
// RETURN etcd.name, collect(dependent.name) as depends_on_etcd

// Find all components that depend on kube-apiserver
// MATCH (component)-[:DEPENDS]->(apiserver:Component {name: 'kube-apiserver-master-X'})
// RETURN component.name, component.type, component.category

// Find all components that kubelet depends on
// MATCH (kubelet:Component {name: 'kubelet'})-[:DEPENDS]->(dependency)
// RETURN dependency.name, dependency.type, dependency.category

// Find all components that depend on kubelet
// MATCH (component)-[:DEPENDS]->(kubelet:Component {name: 'kubelet'})
// RETURN component.name, component.type, component.category

// Get the full dependency view for kubelet (both directions)
// MATCH (kubelet:Component {name: 'kubelet'})
// OPTIONAL MATCH (kubelet)-[:DEPENDS]->(dependencies)
// OPTIONAL MATCH (dependents)-[:DEPENDS]->(kubelet)
// RETURN kubelet.name, 
//        collect(DISTINCT dependencies.name) as depends_on,
//        collect(DISTINCT dependents.name) as depended_by

// Find all dependency chains from apiserver
// MATCH path = (apiserver:Component {name: 'kube-apiserver-master-X'})<-[:DEPENDS*]-(end)
// RETURN path

// Count dependencies by type
// MATCH (component)-[:DEPENDS]->(target)
// RETURN target.name, count(*) as dependents
// ORDER BY dependents DESC

// Find components with no dependencies (root components)
// MATCH (component:Component)
// WHERE NOT (component)-[:DEPENDS]->()
// RETURN component.name, component.type

// Find components that nothing depends on (leaf components)
// MATCH (component:Component)
// WHERE NOT ()-[:DEPENDS]->(component)
// RETURN component.name, component.type