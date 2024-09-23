#!/bin/bash

# Update package lists
echo "Updating package lists..."
sudo apt-get update

# Install necessary packages
echo "Installing git, unzip, python3, python3-venv, and python3-pip..."
sudo apt-get install -y git unzip python3 python3-venv python3-pip

# Check git version
echo "Checking git version..."
git --version

# Clone the repository
echo "Cloning the repository..."
git clone https://github.com/sam-pitcher/regenerate-looker-sa-keys.git

# Change to the repository directory
cd regenerate-looker-sa-keys || { echo "Failed to change directory"; exit 1; }

# Create a virtual environment
echo "Creating a virtual environment..."
python3 -m venv venv

# Activate the virtual environment
echo "Activating the virtual environment..."
source venv/bin/activate

pip3 install -r requirements.txt

echo "Setup complete. You are now in the 'regenerate-looker-sa-keys' directory with the virtual environment activated."
