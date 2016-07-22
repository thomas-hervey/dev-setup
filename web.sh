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
# Make sure we’re using the latest Homebrew.
brew update
# Upgrade any already-installed formulae.
brew upgrade --all

brew install node


# setup for trellis (Roots.io)
brew install ansible
brew cask install --appdir="/Applications" virtualbox # virtual machines
brew cask install --appdir="/Applications" vagrant # virtual environments
vagrant plugin install vagrant-hostmanager
vagrant plugin install vagrant-bindfs




# Clean up & remove outdated versions from the cellar.
brew cleanup
brew prune
brew doctor

npm install -g coffee-script # non-vanilla JS
npm install -g grunt-cli	 # task manager
npm install -g jshint		 # JS code quality
npm install -g sass			 # css preprocessor
npm install -g bower		 # web package manager
npm install -g gulp  		 # task manager

#gem install jekyll
