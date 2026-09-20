#!/usr/bin/env bash

# Fetches the Ansible Vault password from Bitwarden, so this works from any
# machine (not just one with a macOS Keychain) as long as the `bw` CLI is
# installed and unlocked there.
#
# ITEM_NAME must be a Bitwarden *Login* item (bw get password only reads the
# password field of Login items, not Secure Notes) whose password field holds
# your vault password.
#
# Requires an already-unlocked bw session, i.e. $BW_SESSION set in the
# environment - however you keep that alive (bw unlock, a shell hook on new
# terminals, etc.) is up to you; this script doesn't unlock anything itself.
ITEM_NAME="ansible-vault-password"

if [ -z "$BW_SESSION" ]; then
    echo "BW_SESSION is not set - unlock your Bitwarden vault first (bw unlock)." >&2
    exit 1
fi

bw get password "$ITEM_NAME" --session "$BW_SESSION"
