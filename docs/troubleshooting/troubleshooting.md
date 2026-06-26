# Troubleshooting Guide

## Purpose
Common development issues and their resolutions.

# VS Code Issues

## CSS IntelliSense Not Working

### Symptoms
- No CSS suggestions in HTML files

### Resolution
Verify:
```json
{
    "css.enabledLanguages": [
        "html"
    ]
}
```
is configured in User Settings. See [SETUP.md](docs/SETUP.md)

# Dev Container Issues

## Container Fails to Start

### Resolution
1. Rebuild container
```text
Dev Containers: Rebuild Container
```

2. Review logs
```text
Dev Containers: Show Container Log
```

# Formatting Issues

## Prettier Not Running

### Resolution
Verify:
- Extension installed
- .prettierrc exists
- Format on Save enabled

# Docker Issues

## Docker Daemon Not Running

### Resolution
Start Docker Desktop or Docker service.

# Adding New Issues
Use this format:

## Issue Title

### Symptoms
...

### Cause
...

### Resolution
...
