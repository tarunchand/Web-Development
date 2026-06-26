# Dev Container Documentation

## Purpose
This document describes the development container configuration.

# Container Configuration
Location:
```text
.devcontainer/devcontainer.json
```

# Development Environment

## Image
```text
mcr.microsoft.com/devcontainers/javascript-node:4-24-trixie
```
For more information, please refer to [Image source](https://github.com/devcontainers/images/tree/main/src/javascript-node)

# Container Startup Process
1. Container build
2. Container start
3. Extension installation
4. Workspace initialization

# Customizations
Document:
- Custom commands ?
- Startup scripts ?
- Environment variables ?
- Port forwarding ?

# Rebuilding Container
Run:
```text
Dev Containers: Rebuild Container
```
Use when:
- devcontainer.json changes
- Dockerfile changes
- Dependency changes

# Best Practices
- Keep container reproducible
- Avoid machine-specific paths
- Document manual setup requirements
- Commit container configuration files
