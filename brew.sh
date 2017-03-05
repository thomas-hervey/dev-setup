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

# Install GNU core utilities (those that come with OS X are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
sudo ln -s /usr/local/bin/gsha256sum /usr/local/bin/sha256sum

brew install moreutils # useful utilities like `sponge`
brew install findutils # GNU `find`,`locate`,`updatedb`,and `xargs`,`g`-prefixed
brew install gettext # GNU gettext
brew install gnu-sed --with-default-names # GNU `sed`, overwrite built-in `sed`
brew install bash # Bash 4
brew tap homebrew/versions
brew install bash-completion2
# We installed the new shell, now we have to activate it
echo "Adding the newly installed shell to the list of allowed shells"
# Prompts for password
sudo bash -c 'echo /usr/local/bin/bash >> /etc/shells'
# Change to the new shell, prompts for password
chsh -s /usr/local/bin/bash

# Install `wget` with IRI support.
brew install wget --with-iri # GNU package retrieval

# Install RingoJS and Narwhal (order important)
brew install ringojs # multi-threaded JS on JVM
brew install narwhal # JS platform

# Install Python
brew install python # language
brew install python3 # language

# Install ruby-build and rbenv
brew install ruby-build # compile/install ruby language
brew install rbenv #ruby version management
LINE='eval "$(rbenv init -)"'
grep -q "$LINE" ~/.extra || echo "$LINE" >> ~/.extra

# --> Author deleted original list of brews & casks from here
# --> Current brews and casks are now in external files below



# ****************************** #
# Install brews from brew.txt file
<personal_preferences/brew.txt xargs brew install
# Install brew casks from brew_cask.txt file
<personal_preferences/brew_cask.txt xargs brew cask install --appdir="~/Applications"
