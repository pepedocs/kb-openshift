#!/bin/bash

# Neo4j Docker Setup Script
echo "Setting up Neo4j Docker container..."

# Pull Neo4j image
docker pull neo4j:latest

# Create a data directory for persistence
mkdir -p neo4j_data

# Run Neo4j container
docker run -d \
    --name neo4j-openshift \
    -p 7474:7474 -p 7687:7687 \
    -v $(pwd)/neo4j_data:/data \
    -e NEO4J_AUTH=neo4j/password123 \
    neo4j:latest

echo "Neo4j is starting up..."
echo "Web interface will be available at: http://localhost:7474"
echo "Username: neo4j"
echo "Password: password123"
echo ""
echo "Wait about 30 seconds for Neo4j to fully start, then you can load the Cypher file."
echo ""
echo "To load the OpenShift graph, you can:"
echo "1. Open http://localhost:7474 in your browser"
echo "2. Copy and paste the contents of openshift_availability_graph.cypher"
echo "3. Or use cypher-shell: docker exec -it neo4j-openshift cypher-shell -u neo4j -p password123"