#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# 1. Install Xcode Command Line Tools.
echo "Checking for Xcode Command Line Tools..."
if ! xcode-select -p &>/dev/null; then
    echo "Xcode Command Line Tools not found. Installing..."
    xcode-select --install
    echo "Please follow the prompts to complete the installation."
    # Note: The CLI tools installation is interactive. You might need to re-run the script after installation.
else
    echo "Xcode Command Line Tools are already installed."
fi

# 2. Check if Homebrew is installed; if not, install it.
echo "Checking for Homebrew..."
if ! command -v brew &>/dev/null; then
    echo "Homebrew not found. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Homebrew is already installed."
fi

# 3. Check and install cmake and libuv if they are not installed.
for package in cmake libuv; do
    if ! brew list "$package" &>/dev/null; then
        echo "Installing $package..."
        brew install "$package"
    else
        echo "$package is already installed."
    fi
done

# 4. Clone llama.cpp repository if it does not already exist.
if [ ! -d "llama.cpp" ]; then
    echo "Cloning llama.cpp repository..."
    git clone https://github.com/ggml-org/llama.cpp.git
else
    echo "The llama.cpp directory already exists. Skipping clone."
fi

# 5. Build llama.cpp.
cd llama.cpp
mkdir -p build
cd build

echo "Running CMake configuration..."
cmake -DLLAMA_METAL=ON -DLLAMA_BUILD_RPC=ON ..

echo "Compiling the project..."
make

echo "Build complete."
