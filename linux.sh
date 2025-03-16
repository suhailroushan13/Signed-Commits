#!/bin/bash

# Function to install GPG (Linux only)
install_gpg() {
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        echo "Installing GPG..."
        sudo apt update && sudo apt install -y gnupg
    else
        echo "For Windows, download GPG4Win from: https://www.gpg4win.org/get-gpg4win.html"
        echo "For Mac, use Homebrew: brew install gnupg"
    fi
}

# Configure Git username and email
echo "Configuring Git username and email..."
read -p "Enter your GitHub username: " GIT_USER
read -p "Enter your GitHub email: " GIT_EMAIL

git config --global user.name "$GIT_USER"
git config --global user.email "$GIT_EMAIL"

# Install GPG if not installed
echo "Checking for GPG installation..."
if ! command -v gpg &> /dev/null; then
    install_gpg
fi

# Generate GPG key
echo "Generating GPG key..."
gpg --full-generate-key

# Get the GPG key ID
KEY_ID=$(gpg --list-secret-keys --keyid-format LONG | grep 'sec' | awk '{print $2}' | cut -d'/' -f2)
if [ -z "$KEY_ID" ]; then
    echo "Failed to retrieve GPG key ID. Please generate one manually."
    exit 1
fi

echo "Your GPG key ID: $KEY_ID"

# Export and copy the public key
echo "Exporting public key..."
gpg --armor --export "$KEY_ID" > gpg_public_key.txt
cat gpg_public_key.txt

echo "Copy the above public key and add it to your GitHub account (Settings > SSH and GPG keys > New GPG Key)"
read -p "Press Enter after you have added the key to GitHub..."

# Configure Git to use GPG signing
git config --global user.signingkey "$KEY_ID"
git config --global commit.gpgsign true

echo "Git signing setup completed successfully!"
