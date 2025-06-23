# Rails Application - Complete DevOps Pipeline

A comprehensive Ruby on Rails application demonstrating modern DevOps practices with Docker containerization, Kubernetes orchestration, ArgoCD GitOps deployment, and Tekton CI/CD pipelines.

## Architecture Overview

This project showcases a full DevOps workflow for a Rails application with PostgreSQL database, featuring:

- **Containerization**: Docker multi-stage builds with separate app and database containers
- **Orchestration**: Kubernetes deployment with StatefulSet for PostgreSQL
- **GitOps**: ArgoCD for declarative continuous deployment
- **CI/CD**: Tekton pipelines for automated build and push workflows
- **Ingress**: NGINX ingress controller for traffic management

## Contents

- [Quick Start](#-quick-start)
- [Docker Setup](#-docker-setup)
- [Kubernetes Deployment](#-kubernetes-deployment)
- [ArgoCD GitOps](#-argocd-gitops)
- [Tekton Pipelines](#-tekton-pipelines)
- [Project Structure](#-project-structure)
- [Documentation References](#-documentation-references)

## Quick Start

### Prerequisites

| Tool | Version | Purpose |
|------|---------|---------|
| Docker | 20.10+ | Container runtime |
| Docker Compose | 2.0+ | Multi-container orchestration |
| Kubernetes | 1.20+ | Container orchestration |
| Minikube | 1.25+ | Local Kubernetes cluster |
| kubectl | 1.20+ | Kubernetes CLI |
| ArgoCD | 2.5+ | GitOps deployment |
| Tekton | 0.40+ | CI/CD pipelines |

### Quick Demo

```bash
# Clone the repository
git clone https://github.com/srikxcipher/rails_app.git
cd rails_app

# Docker deployment
docker pull srikant25/railsapp:latest
docker-compose up

# Kubernetes deployment
chmod +x k8s-scripts/*.sh
./k8s-scripts/get-all-up.sh
```

## Docker Setup

### Container Architecture

- **Rails Application**: Multi-stage Dockerfile with Ruby 3.2 and Rails 7
- **PostgreSQL Database**: Official PostgreSQL 15 image with custom initialization
- **Networking**: Docker Compose bridge network for service communication

### Quick Commands

```bash
# Ensure Docker daemon is running
sudo systemctl start docker

# Pull pre-built image
docker pull srikant25/railsapp:latest

# Start the application stack
docker-compose up -d

# View application
# Navigate to http://localhost:3000
```

### Files Structure

```
├── Dockerfile                 # Multi-stage Rails application build
├── docker-compose.yaml        # Multi-container orchestration
├── init.sql                   # PostgreSQL initialization script
└── bin/docker-entrypoint      # Container entry point script
```

## Kubernetes Deployment

### Architecture Components

- **Namespace**: `rails-app` for resource isolation
- **PostgreSQL**: StatefulSet with persistent volume claims
- **Rails App**: Deployment with rolling update strategy
- **Services**: ClusterIP for internal communication, NodePort for external access
- **Ingress**: NGINX controller for HTTP routing

### Automated Deployment

Set permissions and execute deployment scripts:

```bash
# Set execution permissions
chmod +x k8s-scripts/*.sh

# Automated deployment sequence
./k8s-scripts/01-start-minikube.sh      # Initialize Minikube cluster
./k8s-scripts/02-create-namespace.sh    # Create rails-app namespace
./k8s-scripts/03-deploy-postgres.sh     # Deploy PostgreSQL StatefulSet
./k8s-scripts/04-deploy-rails-app.sh    # Deploy Rails application
./k8s-scripts/05-enable-and-deploy-ingress.sh  # Configure ingress
./k8s-scripts/06-status-check.sh        # Verify deployment status
```

### Manual Access & Verification

```bash
# Access application via NodePort
minikube service webapp-service -n rails-app

# Connect to PostgreSQL for debugging
./k8s-scripts/07-connect-postgres.sh

# Check deployment status
kubectl get all -n rails-app
```

### Kubernetes Resources

| Resource | File | Purpose |
|----------|------|---------|
| PostgreSQL StatefulSet | [`kubernetes-files/dbdeploy.yaml`](kubernetes-files/dbdeploy.yaml) | Database persistence |
| Database Service | [`kubernetes-files/dbservice.yaml`](kubernetes-files/dbservice.yaml) | Internal DB access |
| Rails Deployment | [`kubernetes-files/webdeploy.yaml`](kubernetes-files/webdeploy.yaml) | Application pods |
| Web Service | [`kubernetes-files/webservice.yaml`](kubernetes-files/webservice.yaml) | Load balancing |
| Ingress Controller | [`kubernetes-files/ingress.yaml`](kubernetes-files/ingress.yaml) | HTTP routing |

### Cleanup

```bash
# Destroy all resources
./k8s-scripts/99-destroy-all.sh
```

## ArgoCD GitOps

### GitOps Workflow

ArgoCD continuously monitors the Git repository and automatically synchronizes the desired state with the Kubernetes cluster.

### Configuration Files

| Component | File | Description |
|-----------|------|-------------|
| Application Definition | [`config/argocd/application.yaml`](config/argocd/application.yaml) | ArgoCD app configuration |
| Config Map | [`config/argocd/argocd-cm.yaml`](config/argocd/argocd-cm.yaml) | ArgoCD server settings |
| RBAC Configuration | [`config/argocd/argocd-rbac-cm.yaml`](config/argocd/argocd-rbac-cm.yaml) | Role-based access control |
| Manual Setup Guide | [`config/argocd/argo-cd-manual.txt`](config/argocd/argo-cd-manual.txt) | Step-by-step instructions |

### Key Features

- **Declarative Configuration**: Infrastructure as Code approach
- **Automated Sync**: Continuous deployment from Git repository
- **Rollback Capability**: Easy reversion to previous application states
- **Multi-Environment Support**: Separate configurations for dev/staging/prod

## Tekton Pipelines

### Installation

- Installation and overview | [`tekton/tekton-inst.txt`](tekton/tekton-inst.txt) 

### Pipeline Architecture

The Tekton pipeline automates the complete CI/CD workflow:

1. **Source Code Fetch**: Clone repository from GitHub
2. **Container Build**: Build Docker image using Kaniko
3. **Image Push**: Upload to Docker Hub registry
4. **Deployment Trigger**: Notify ArgoCD for automatic deployment

### Pipeline Components

| Resource | File | Purpose |
|----------|------|---------|
| Git Clone Task | [`tekton/git-clone-task.yaml`](tekton/git-clone-task.yaml) | Source code retrieval |
| Kaniko Build Task | [`tekton/kaniko-task.yaml`](tekton/kaniko-task.yaml) | Containerless image building |
| Pipeline Definition | [`tekton/pipeline.yaml`](tekton/pipeline.yaml) | Workflow orchestration |
| Pipeline Execution | [`tekton/pipelinerun.yaml`](tekton/pipelinerun.yaml) | Runtime configuration |
| Service Account | [`tekton/service-account.yaml`](tekton/service-account.yaml) | Authentication setup |
| Docker Credentials | [`tekton/docker-credentials.yaml`](tekton/docker-credentials.yaml) | Registry authentication |

### Pipeline Execution

```bash
# Initialize and execute Tekton components
./tekton/tek-init-script.sh

# Monitor pipeline execution
kubectl get pods --namespace tekton-pipelines --watch

# Access Tekton Dashboard
kubectl --namespace tekton-pipelines port-forward svc/tekton-dashboard 9097:9097
# Visit: http://localhost:9097
```

### Cleanup Tekton Resources

```bash
# Remove all Tekton resources
./tekton/tek-del-script.sh
```

## Project Structure

```
rails_app/
├── app/                       # Rails application code
├── config/                    # Application & ArgoCD configuration
│   └── argocd/               # ArgoCD GitOps manifests
├── kubernetes-files/          # Kubernetes deployment manifests
├── k8s-scripts/              # Automated deployment scripts
├── tekton/                   # CI/CD pipeline definitions
├── Dockerfile                # Container build instructions
├── docker-compose.yaml       # Local development stack
└── README.md                 # This documentation
```

## Documentation References

### Core Technologies

| Technology | Official Documentation | Quick Start |
|------------|----------------------|-------------|
| **Docker** | [docs.docker.com](https://docs.docker.com/) | [Get Started Guide](https://docs.docker.com/get-started/) |
| **Kubernetes** | [kubernetes.io](https://kubernetes.io/docs/) | [Learning Path](https://kubernetes.io/docs/tutorials/) |
| **Minikube** | [minikube.sigs.k8s.io](https://minikube.sigs.k8s.io/docs/) | [Installation Guide](https://minikube.sigs.k8s.io/docs/start/) |

### DevOps Tools

| Tool | Documentation | Tutorials |
|------|---------------|-----------|
| **ArgoCD** | [argo-cd.readthedocs.io](https://argo-cd.readthedocs.io/en/stable/) | [Getting Started](https://argo-cd.readthedocs.io/en/stable/getting_started/) |
| **Tekton** | [tekton.dev/docs](https://tekton.dev/docs/) | [Tutorial](https://tekton.dev/docs/getting-started/) |
| **Tekton Dashboard** | [tekton.dev/docs/dashboard](https://tekton.dev/docs/dashboard/) | [Installation](https://github.com/tektoncd/dashboard#install-dashboard) |
| **NGINX Ingress** | [kubernetes.github.io/ingress-nginx](https://kubernetes.github.io/ingress-nginx/) | [Deployment Guide](https://kubernetes.github.io/ingress-nginx/deploy/) |

### Container Registry

| Registry | Purpose | Access |
|----------|---------|--------|
| **Docker Hub** | Public image repository | [hub.docker.com/r/srikant25/railsapp](https://hub.docker.com/r/srikant25/railsapp) |

## Check this out 

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

