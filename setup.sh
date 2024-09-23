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
