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

brew install caskroom/cask/brew-cask # Install Cask
