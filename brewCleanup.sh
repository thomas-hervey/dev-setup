brew update # Make sure we’re using the latest Homebrew.
brew upgrade --all # Upgrade any already-installed formulae.
##
# Link kegs after any installs
ls -1 /usr/local/Library/LinkedKegs | while read line; do
    echo $line
    brew unlink $line
    brew link --force $line
    # TODO: create exception handler
done
##
# Clean up & remove outdated versions from the cellar.
brew cleanup
brew prune
brew doctor