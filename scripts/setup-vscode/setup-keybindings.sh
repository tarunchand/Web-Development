#!/usr/bin/env bash

set -euo pipefail

# =========================================================
# VS Code Keybindings Bootstrap Script
# =========================================================
#
# This script:
#   1. Creates a symlink inside the repo:
#        .vscode/keybindings.json
#            -> global VS Code keybindings.json
#
#   2. Merges template keybindings into the global file
#
#   3. Detects conflicts interactively
#
#   4. Avoids duplicate entries
#
#   5. Is safe to rerun multiple times
#
# =========================================================

# ---------------------------------------------------------
# Utility Logging Functions
# ---------------------------------------------------------

log() {
    echo
    echo "========================================================="
    echo "$1"
    echo "========================================================="
}

step() {
    echo
    echo "[STEP] $1"
}

info() {
    echo "[INFO] $1"
}

warn() {
    echo "[WARN] $1"
}

success() {
    echo "[SUCCESS] $1"
}

# ---------------------------------------------------------
# Resolve Important Paths
# ---------------------------------------------------------

log "Resolving Paths"

step "Determining repository root"

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"

info "Repository root resolved to:"
info "$REPO_ROOT"

step "Defining important file paths"

TEMPLATE="$REPO_ROOT/.vscode/keybindings.template.json"
LINK_PATH="$REPO_ROOT/.vscode/keybindings.json"
GLOBAL_FILE="$HOME/.config/Code/User/keybindings.json"

info "Template file:"
info "$TEMPLATE"

info "Symlink path:"
info "$LINK_PATH"

info "Global VS Code keybindings file:"
info "$GLOBAL_FILE"

# ---------------------------------------------------------
# Validate Dependencies
# ---------------------------------------------------------

log "Checking Dependencies"

step "Checking whether jq is installed"

if command -v jq >/dev/null 2>&1; then
    success "jq is installed"
else
    warn "jq is NOT installed"
    echo
    echo "Please install jq before running this script."
    echo
    echo "Ubuntu/Debian:"
    echo "  sudo apt install jq"
    echo
    echo "Fedora:"
    echo "  sudo dnf install jq"
    echo
    echo "Arch Linux:"
    echo "  sudo pacman -S jq"
    exit 1
fi

# ---------------------------------------------------------
# Ensure VS Code User Directory Exists
# ---------------------------------------------------------

log "Preparing VS Code User Directory"

USER_DIR="$(dirname "$GLOBAL_FILE")"

step "Ensuring VS Code user directory exists"

info "Directory: $USER_DIR"

mkdir -p "$USER_DIR"

success "Directory verified"

# ---------------------------------------------------------
# Ensure Global Keybindings File Exists
# ---------------------------------------------------------

log "Preparing Global keybindings.json"

step "Checking whether global keybindings.json exists"

if [ -f "$GLOBAL_FILE" ]; then

    success "Global keybindings.json already exists"

else

    warn "Global keybindings.json does not exist"

    step "Creating empty keybindings.json"

    echo "[]" > "$GLOBAL_FILE"

    success "Created empty global keybindings.json"
fi

# ---------------------------------------------------------
# Create Symlink Inside Repo
# ---------------------------------------------------------

log "Creating Repository Symlink"

step "Checking whether repo symlink already exists"

if [ -L "$LINK_PATH" ]; then

    success "Symlink already exists"

    info "Current symlink target:"
    info "$(readlink "$LINK_PATH")"

else

    warn "Symlink does not exist"

    step "Removing existing file if necessary"

    rm -f "$LINK_PATH"

    success "Old file removed (if present)"

    step "Creating symbolic link"

    ln -s "$GLOBAL_FILE" "$LINK_PATH"

    success "Symlink created successfully"

    echo
    echo "$LINK_PATH"
    echo "    ->"
    echo "$GLOBAL_FILE"
fi

# ---------------------------------------------------------
# Validate JSON Files
# ---------------------------------------------------------

log "Validating JSON Files"

step "Validating global keybindings.json"

jq empty "$GLOBAL_FILE" >/dev/null

success "Global keybindings.json is valid JSON"

step "Validating template keybindings file"

jq empty "$TEMPLATE" >/dev/null

success "Template file is valid JSON"

# ---------------------------------------------------------
# Create Temporary Working Copy
# ---------------------------------------------------------

log "Preparing Temporary Working Copy"

step "Creating temporary file"

TMP_FILE="$(mktemp)"

info "Temporary file path:"
info "$TMP_FILE"

step "Copying global keybindings into temporary file"

cp "$GLOBAL_FILE" "$TMP_FILE"

success "Temporary working copy prepared"

# ---------------------------------------------------------
# Begin Merge Process
# ---------------------------------------------------------

log "Beginning Merge Process"

COUNT=$(jq 'length' "$TEMPLATE")

info "Number of template keybindings found: $COUNT"

for ((i=0; i<COUNT; i++)); do

    echo
    echo
    echo "#########################################################"
    echo "Processing Template Entry $((i + 1)) of $COUNT"
    echo "#########################################################"

    ENTRY=$(jq ".[$i]" "$TEMPLATE")

    KEY=$(echo "$ENTRY" | jq -r '.key')
    COMMAND=$(echo "$ENTRY" | jq -r '.command')

    step "Reading template entry"

    info "Key: $KEY"
    info "Command: $COMMAND"

    # -----------------------------------------------------
    # Check Existing Binding
    # -----------------------------------------------------

    step "Searching for existing bindings using same key"

    EXISTING=$(jq \
        --arg key "$KEY" \
        '.[] | select(.key == $key)' \
        "$TMP_FILE")

    # -----------------------------------------------------
    # No Existing Binding
    # -----------------------------------------------------

    if [ -z "$EXISTING" ]; then

        success "No existing binding found"

        step "Appending new keybinding"

        jq \
          --argjson entry "$ENTRY" \
          '. += [$entry]' \
          "$TMP_FILE" > "$TMP_FILE.new"

        mv "$TMP_FILE.new" "$TMP_FILE"

        success "Keybinding added successfully"

        continue
    fi

    # -----------------------------------------------------
    # Existing Binding Found
    # -----------------------------------------------------

    warn "Existing binding detected"

    EXISTING_COMMAND=$(echo "$EXISTING" | jq -r '.command')

    info "Existing command:"
    info "$EXISTING_COMMAND"

    # -----------------------------------------------------
    # Exact Duplicate
    # -----------------------------------------------------

    if [ "$EXISTING_COMMAND" = "$COMMAND" ]; then

        success "Exact same keybinding already exists"
        info "Skipping duplicate entry"

        continue
    fi

    # -----------------------------------------------------
    # Conflict Detected
    # -----------------------------------------------------

    log "Conflict Detected"

    echo "Key:"
    echo "  $KEY"

    echo
    echo "Existing command:"
    echo "  $EXISTING_COMMAND"

    echo
    echo "Template command:"
    echo "  $COMMAND"

    echo
    echo "A decision is required."

    while true; do

        echo
        read -rp "Do you want to replace the existing binding? (y/n): " ANSWER

        case "$ANSWER" in

            y|Y)

                step "Replacing existing keybinding"

                jq \
                  --arg key "$KEY" \
                  --argjson entry "$ENTRY" \
                  'map(if .key == $key then $entry else . end)' \
                  "$TMP_FILE" > "$TMP_FILE.new"

                mv "$TMP_FILE.new" "$TMP_FILE"

                success "Existing binding replaced"

                break
                ;;

            n|N)

                info "Keeping existing binding"
                info "Template binding skipped"

                break
                ;;

            *)

                warn "Invalid input"
                info "Please enter either y or n"
                ;;
        esac
    done

done

# ---------------------------------------------------------
# Save Final Result
# ---------------------------------------------------------

log "Saving Final Result"

step "Writing merged keybindings into global file"

cp "$TMP_FILE" "$GLOBAL_FILE"

success "Global keybindings updated successfully"

step "Removing temporary file"

rm -f "$TMP_FILE"

success "Temporary file removed"

# ---------------------------------------------------------
# Final Summary
# ---------------------------------------------------------

log "Setup Complete"

info "Repository symlink:"
info "$LINK_PATH"

info "Global keybindings file:"
info "$GLOBAL_FILE"

success "Keybindings bootstrap completed successfully"

echo
echo "You can now open the repository in VS Code."
echo