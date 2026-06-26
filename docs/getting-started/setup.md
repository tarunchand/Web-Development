# Developer Setup Guide

## Purpose
This document describes all manual setup steps required for development.

# Prerequisites

## Required Software
- Visual Studio Code
- Docker Desktop / Docker Engine
- Dev Containers Extension

# Initial Setup

## Clone Repository
```bash
git clone <repository-url>
```

## Open in VS Code
Open the project folder.

## Start Dev Container
Ctrl+Shift+P
```text
Dev Containers: Reopen in Container
```

# Recommended Extensions
Extensions are defined in:
```text
.vscode/extensions.json
```
Install all recommended extensions.

# Manual VS Code Settings
The following settings cannot be distributed through the repository and must be configured manually.

## HTML CSS Support
Extension:
```text
ecmel.vscode-html-css
```

### User Setting
Open:
```text
Preferences: Open User Settings (JSON)
```
Add:
```json
{
    "css.enabledLanguages": [
        "html"
    ]
}
```

### Reason
Enables CSS IntelliSense within HTML files.

# Workspace Validation
Verify the following:
- [ ] Dev Container starts successfully
- [ ] Extensions installed
- [ ] CSS IntelliSense works
- [ ] Formatting works
- [ ] Launch configurations available
- [ ] Tasks execute correctly
