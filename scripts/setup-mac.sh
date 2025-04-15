#!/bin/bash

echo "Setting up project environment..."

# Check for Node.js installation
if ! command -v node &> /dev/null; then
    echo "Node.js is not installed! Please install Node.js 22 using one of these methods:"
    echo "1. From https://nodejs.org/"
    echo "2. Using nvm: curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash"
    exit 1
fi

# Check Node.js version
NODE_VERSION=$(node -v)
if [[ $NODE_VERSION != v22* ]]; then
    echo "Warning: This project is designed for Node.js 22"
    echo "Current version: $NODE_VERSION"
    echo "We recommend using Node.js 22 for this project"
    echo "If you have nvm installed, run: nvm install 22 && nvm use 22"
    sleep 3
fi

# Check if pnpm is already installed
if ! command -v pnpm &> /dev/null; then
    echo "pnpm is not installed. Attempting to install..."
    
    # Try enabling Corepack
    echo "Enabling Corepack for pnpm..."
    corepack enable 2>/dev/null || {
        echo "Error enabling Corepack. You might need sudo access."
        echo "Try running one of these commands:"
        echo "1. sudo corepack enable"
        echo "2. npm install -g pnpm@10.1.0 (might also need sudo)"
        
        # Ask if user wants to continue without pnpm
        read -p "Do you want to continue setup without installing pnpm? (y/n): " CONTINUE
        if [[ $CONTINUE != "y" && $CONTINUE != "Y" ]]; then
            echo "Setup aborted. Please install pnpm and try again."
            exit 1
        fi
    }
fi

# Check again if pnpm is now available
if command -v pnpm &> /dev/null; then
    # Install dependencies
    echo "Installing dependencies..."
    pnpm install
else
    echo "pnpm is not available. You'll need to manually install dependencies with:"
    echo "1. Install pnpm with: sudo corepack enable OR sudo npm install -g pnpm@10.1.0"
    echo "2. Run: pnpm install"
fi

# Make script executable (if needed in future runs)
chmod +x "$(dirname "$0")/setup-mac.sh" 2>/dev/null || true

echo "Setup complete!"
echo "Once pnpm is installed and dependencies are installed, run 'pnpm dev' to start the development server."