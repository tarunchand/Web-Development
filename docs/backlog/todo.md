# Project TODO

## Backlog

### Development Environment

#### Setup
- [ ] Set up an extension to work with MD5 files
- [ ] Set up Git Credentials in Dev Container
- [ ] Set up Prettier Extension Configuration
- [ ] Set up Prettier Extension as a Default Formatter
- [ ] Configure the Dev Environment in such a way as to keep the possibility of switching to a different IDE with very minimal changes. (For ex:- relying on .prettierrc configuration file instead of relying on vscode settings.json to set prettier configuration)
- [ ] Configure Live Server to work with Dev Containers
- [ ] Set up all recommended VSCode extensions and validate their configuration
- [ ] Set up keybindings script to install the keybindings.template.json
    - [ ] Use the settings context hack by setting a custom flag in your dev container and use the above custom flag in the when clause for the keybindings in the keybindings.template.json to ensure these shortcuts never conflict with other projects.
- [ ] Set up extensions and tooling for HTML
- [ ] Set up devcontainers.json
- [ ] Linter Integration - [Integrating ESLint with Prettier](https://prettier.io/docs/integrating-with-linters.html)

#### Verification
- [ ] Automated tests to verify whether the development environment is set up successfully
    - [ ] Extensions
        - [ ] Automated tests to verify whether all the extensions are installed successfully
        - [ ] Automated tests to verify extension settings
    - [ ] Keybindings
        - [ ] Automated tests to verify the installation of keybindings

### Project source code
- [ ] Update the project folder structure to src/...
    - [ ] Update the settings.json to reflect the new folder structure for extensions like HTML CSS Support

### Documentation
- [ ] Init docs folder structure
- [ ] Update the documentation table in ReadMe to include all the relevant documentation and refer to the correct paths
- [ ] Technical Writing for Software Developers
- [ ] Document best practices for Git Commit Messages
- [ ] Document most commonly used shortcuts in vscode-shortcuts.md and update the file vscode-shortcuts.md
- [ ] Document the usage of working with MD5 files (https://code.visualstudio.com/docs/languages/markdown) in VSCode and install an extension to work with MD5 files and document its usage and its shortcuts in vscode-shortcuts.md under Language-Specific Shortcuts or create a new file called md5-cheatsheet.md under reference if necessary.
- [ ] Updating the documentation to make consistent use of spacing when defining tables with the help of MD5 editing extension.
- [ ] Updating development-ecosystem.md
- [ ] Updating development-ecosystem.md with comprehensive HTML tooling as per industry standard
- [ ] Install spell checker extension


## In Progress

### Development Environment

#### Setup
- [ ] Init Development Environment
- [ ] Development Ecosystem
    - [ ] Code Quality
        - [ ] Language Server (LSP)
            - [ ] HTML
            - [ ] CSS
            - [ ] JavaScript
        - [ ] Formatter
            - [ ] HTML
            - [ ] CSS
            - [ ] JavaScript
        - [ ] Linter
            - [ ] HTML
            - [ ] CSS
            - [ ] JavaScript
        - [ ] Static Analysis
        - [ ] Type Checker
    - [ ] Testing
        - [ ] Test Framework
        - [ ] Coverage Tool
    - [ ] Security
        - [ ] Security Scanner
    - [ ] Build & Packaging
        - [ ] Dependency Management
        - [ ] Build Tool
    - [ ] Development
        - [ ] Debugger
        - [ ] Profiler
        - [ ] Documentation Generator
    - [ ] Source Control
        - [ ] Git Integration
        - [ ] Pre-Commit Hooks
    - [ ] Automation
        - [ ] CI/CD Integration
    - [ ] Developer Experience (DX)
        - [ ] Productivity
            - [ ] Emmet
            - [ ] Oh My Zsh
            - [ ] Path Intellisense
            - [ ] Gitlens
            - [ ] Error Lens
            - [ ] TODO Highlight
            - [ ] IntelliCode
            - [ ] Github Copilot or OpenAI Codex
        - [ ] Live Development
            - [ ] Live Server
        - [ ] Accessibility & Compliance
            - [ ] axe DevTools Accessibility Audit
            - [ ] Lighthouse Audit
            - [ ] WCAG Validators
        - [ ] Quality Assurance
            - [ ] Spell Checker
            - [ ] Lighthouse
            - [ ] W3C Validation

## Completed

### YYYY-MM-DD
- [X] (To be Updated)