// OpenShift kube-apiserver Direct Dependencies Knowledge Graph
// Relationship: A -[:DEPENDS]-> B means A depends on B

// Create the kube-apiserver node
CREATE (apiserver:Component {
  name: 'kube-apiserver-master-X', 
  type: 'control_plane',
  category: 'static_pod',
  description: 'Kubernetes API server'
})

// Create Control Plane Components that depend on API server
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

// Create Cluster Operators that depend on API server
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

// Create Machine Management components that depend on API server
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

// Create Node Agent that depends on API server
CREATE (kubelet:Component {
  name: 'kubelet',
  type: 'node_agent',
  category: 'systemd_service',
  description: 'Node agent'
})

// Create dependency relationships (all depend on kube-apiserver)
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
CREATE (kubelet)-[:DEPENDS]->(apiserver)

// Useful queries:

// Find all components that depend on kube-apiserver
// MATCH (component)-[:DEPENDS]->(apiserver:Component {name: 'kube-apiserver-master-X'})
// RETURN component.name, component.type, component.category

// Count dependencies by type
// MATCH (component)-[:DEPENDS]->(apiserver:Component {name: 'kube-apiserver-master-X'})
// RETURN component.type, count(*) as count
// ORDER BY count DESC

// Find components by category that depend on API server
// MATCH (component)-[:DEPENDS]->(apiserver:Component {name: 'kube-apiserver-master-X'})
// WHERE component.category = 'pod'
// RETURN component.name