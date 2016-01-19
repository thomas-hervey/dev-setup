#!/usr/bin/env bash

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `osxprep.sh` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Step 1: Update the OS and Install Xcode Tools
echo "------------------------------"
echo "Updating OSX.  If this requires a restart, run the script again."
sudo softwareupdate -iva # Install all available updates

echo "------------------------------"
echo "Installing Xcode Command Line Tools."
xcode-select --install # Install Xcode command line tools

echo "installing oh-my-zsh"
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
mv custom.zshrc.zsh ~/.oh-my-zsh/custom/custom.zshrc.zsh