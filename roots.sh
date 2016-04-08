#!/usr/bin/env bash

# Install command-line tools using Homebrew.

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi
brew update # Make sure we’re using the latest Homebrew
brew upgrade --all # Upgrade any already-installed formulae
##
# Link kegs before any installs
ls -1 /usr/local/Library/LinkedKegs | while read line; do
    brew link --force $line
done
##

echo "Installing Trellis dependencies"
brew install ansible # IT automation

brew cask install --appdir="/Applications" vagrant # virtual environments
brew cask install --appdir="/Applications" vagrant-manager
brew cask install --appdir="/Applications" virtualbox # virtual machines

vagrant plugin install vagrant-bindfs
vagrant plugin install vagrant-hostmanager

cd ~/Projects/web_development/personal_webpage
echo "Installing Trellis"
mkdir example.com && cd example.com
echo "Clone Trellis"
git clone --depth=1 git@github.com:roots/trellis.git && rm -rf trellis/.git
echo "Clone Bedrock"
git clone --depth=1 git@github.com:roots/bedrock.git site && rm -rf site/.git
echo "Install Ansible Galaxy Roles"
cd trellis && ansible-galaxy install -r requirements.yml
