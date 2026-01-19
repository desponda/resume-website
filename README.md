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

## Resume Management

### Quick Update & Regenerate

To update your resume content and regenerate all PDFs:

```bash
# 1. Edit the LaTeX files in resumes/ directory
vim resumes/daniel_esponda_resume_3page.tex

# 2. Regenerate all resume versions
./regenerate-resume.sh

# 3. Commit and deploy
git add .
git commit -m "Update resume: [your changes]"
git push
```

The script automatically:
- ✅ Compiles 3-page, 2-page, and 1-page versions
- ✅ Copies the main resume to `public/` directory
- ✅ Validates LaTeX compilation
- ✅ Cleans up temporary files

**Resume Files:**
- `resumes/daniel_esponda_resume_3page.tex` - Full detailed version (recommended)
- `resumes/daniel_esponda_resume_2page.tex` - Concise version
- `resumes/daniel_esponda_resume_1page.tex` - Executive summary

See `resumes/README.md` for detailed update instructions and tips.

## Deployment

Deployed automatically via ArgoCD when changes are pushed to main:

1. GitHub Actions builds and pushes Docker image to GHCR
2. ArgoCD detects changes and syncs to Kubernetes cluster
3. Website is live at https://dresponda.com

## Structure

```
.
├── resumes/                   # Resume source files (LaTeX)
│   ├── daniel_esponda_resume_3page.tex
│   ├── daniel_esponda_resume_2page.tex
│   ├── daniel_esponda_resume_1page.tex
│   └── README.md             # Resume update guide
├── public/                    # Website files
│   ├── index.html            # Main HTML
│   ├── style.css             # Styles
│   └── Daniel_Esponda_Resume.pdf
├── k8s/                      # Kubernetes manifests
│   └── helm/resume-website/  # Helm chart
├── .github/workflows/        # CI/CD
├── regenerate-resume.sh      # Resume compilation script
├── Dockerfile                # Container definition
└── nginx.conf               # nginx configuration
```

## ArgoCD Application

```bash
kubectl apply -f argocd/application.yaml
```

## License

© 2026 Daniel Esponda. All rights reserved.
