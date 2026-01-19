# Daniel Esponda - Professional Resume Website

Professional resume website for dresponda.com, deployed on Kubernetes with ArgoCD.

## Overview

Modern, responsive single-page website featuring:
- Clean, professional design with glassmorphism effects
- Downloadable PDF resume
- Mobile-first responsive layout
- Optimized performance with nginx
- Kubernetes-native deployment

## Tech Stack

- **Frontend**: HTML5, CSS3 (vanilla)
- **Server**: nginx (Alpine)
- **Container**: Docker
- **Orchestration**: Kubernetes (Helm)
- **GitOps**: ArgoCD
- **CI/CD**: GitHub Actions
- **Registry**: GitHub Container Registry

## Local Development

```bash
# Serve locally with Python
cd public
python3 -m http.server 8000

# Or with Docker
docker build -t resume-website .
docker run -p 8080:80 resume-website
```

Visit http://localhost:8000 or http://localhost:8080

## Deployment

Deployed automatically via ArgoCD when changes are pushed to main:

1. GitHub Actions builds and pushes Docker image to GHCR
2. ArgoCD detects changes and syncs to Kubernetes cluster
3. Website is live at https://dresponda.com

## Structure

```
.
├── public/                    # Website files
│   ├── index.html            # Main HTML
│   ├── style.css             # Styles
│   └── Daniel_Esponda_Resume.pdf
├── k8s/                      # Kubernetes manifests
│   └── helm/resume-website/  # Helm chart
├── .github/workflows/        # CI/CD
├── Dockerfile                # Container definition
└── nginx.conf               # nginx configuration
```

## ArgoCD Application

```bash
kubectl apply -f argocd/application.yaml
```

## License

© 2026 Daniel Esponda. All rights reserved.
