# 🛒 Secure E-Commerce Microservices Platform

![CI Status](https://github.com/rajumb0232/E-Commerce-Microservice/actions/workflows/CI-pipeline.yml/badge.svg)
![Docker](https://img.shields.io/badge/Docker-Enabled-blue.svg)
![Security](https://img.shields.io/badge/Security-Trivy%20Scanned-green)

## 📋 Project Overview

This project is a **Cloud-Native E-Commerce Microservices Platform** designed to demonstrate solid **DevSecOps**, **CI/CD**, and **Container Orchestration** skills.

It simulates a **production-ready architecture** where services are decoupled, scalable, and securely built using automated pipelines.

## 🏗 Architecture & Technology Stack

### Core Infrastructure Components

- **Service Discovery:** HashiCorp Consul (service registration & health checks)
- **API Gateway:** Spring Cloud Gateway (single entry point & routing)
- **Config Server:** Centralized configuration (Git-backed)
- **Caching Layer:** Redis
- **Databases:** MySQL 8.0 (database-per-service pattern)

### Microservices

- **User Service:** Authentication & user management (JWT-based security)
- **Product Service:** Product catalog & inventory
- **Order Service:** Order lifecycle & processing

Each service is independently built, scanned, and deployed.

## 🚀 DevSecOps CI/CD Pipeline (GitHub Actions)

The CI/CD pipeline is defined in:

.github/workflows/CI-pipeline.yml

### Key Features

#### Parallel Builds (Matrix Strategy)

- Services built in parallel:
  - `config-server`
  - `api-gateway`
  - `user-service`
  - `product-service`
  - `order-service`

This significantly reduces pipeline execution time.

#### Security Scanning (Trivy)

- Container images are scanned for **CRITICAL** and **HIGH** vulnerabilities
- Two output formats:
  - **SARIF** (GitHub Security tab)
  - **Plain text reports** (human-readable)

#### Artifact Management

- Each scan result is uploaded as an artifact
- A dedicated job aggregates all reports into:

global_security_report.txt

#### Automated Notifications

- A consolidated security report is sent via **SMTP email**
- Ensures fast feedback after each pipeline execution

## 🛠 Local Development & Deployment

### Prerequisites

- Docker
- Docker Compose
- Java 17+
- Git

### 1. Clone the Repository

```bash
git clone https://github.com/rajumb0232/E-Commerce-Microservice.git
cd E-Commerce-Microservice


2. Environment Variables

Create a .env file at the root of the project.

⚠️ Never commit this file

GIT_USER=your_git_username
GIT_PASS=your_git_token
MYSQL_ROOT_PASSWORD=root

3. Build and Run the Full Stack
docker-compose up -d --build

4. Access Services
Service	URL / Port	Description
Consul UI	http://localhost:8500
	Service registry dashboard
API Gateway	http://localhost:8080
	Application entry point
Config Server	http://localhost:1000
	Centralized configuration server
User DB	localhost:3306	MySQL database (User Service)
⚙️ GitHub Actions Configuration

Configure the following Repository Secrets:

DOCKER_USERNAME – Docker Hub username

DOCKER_PASSWORD – Docker Hub access token

MAIL_USERNAME – SMTP sender email

MAIL_PASSWORD – SMTP application password

🛡 Security Best Practices Implemented

Continuous container vulnerability scanning

Private Docker network isolation (ecom-network)

Health checks for dependency readiness

Secrets injected via environment variables

No hardcoded credentials in the source code

📜 Utility Scripts

A helper script is available for manual Docker operations:

chmod +x build-and-push.sh
./build-and-push.sh

📈 Roadmap / Next Improvements

Kubernetes migration (EKS / Minikube)

Helm charts for release management

External secrets (Vault / AWS Secrets Manager)

DAST integration (OWASP ZAP)

Observability stack (Prometheus + Grafana)

Author: Otniel TAMINI
Role: DevOps Engineer