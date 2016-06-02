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

# Install more recent versions of some OS X tools.
brew install vim --override-system-vi
brew install homebrew/dupes/grep
brew install homebrew/dupes/openssh
brew install homebrew/dupes/screen
brew install homebrew/php/php55 --with-gmp

# Install font tools.
brew tap bramstein/webfonttools
brew install sfnt2woff
brew install sfnt2woff-zopfli
brew install woff2

# Install some CTF tools; see https://github.com/ctfs/write-ups.
brew install aircrack-ng
brew install bfg
brew install binutils
##brew install binwalk  'got stuck on install last time it was run'
brew install cifer
brew install dex2jar
brew install dns2tcp
brew install fcrackzip
brew install foremost
brew install hashpump
brew install hydra
brew install john
brew install knock
brew install netpbm
brew install nmap
brew install pngcheck
brew install socat
brew install sqlmap
brew install tcpflow
brew install tcpreplay
brew install tcptrace
brew install ucspi-tcp # `tcpserver` etc.
brew install homebrew/x11/xpdf
brew install xz

# Install other useful binaries.
brew install ack # like grep
brew install dark-mode # toggle OSX dark mode
brew install unar # unarchiver
brew install pkg-config # compiling helper
#brew install exiv2
brew install git # source control
brew install git-lfs # versioning larger files
brew install git-flow # Vincent Driessen's branching model
brew install git-extras # git utilities
brew install imagemagick --with-webp # bitmap images
brew install lua # scripting language
brew install lynx # text web browser
brew install p7zip # port of 7za.exe for POSIX
brew install pigz # parallel gzip
brew install pv # monitor pipe data
brew install rename # rename commands
brew install rhino # JS written in Java
brew install speedtest_cli # test bandwidth / speed
brew install ssh-copy-id # remote SSH
brew install tree # directory listing
brew install webkit2png # webpage screenshot
brew install zopfli # zlib compression
brew install pkg-config libffi # compression

brew install jena # Apache Jena (SW & LD)
brew install pandoc # Universal document converter
brew tap homebrew/science
brew install gcc
brew install Caskroom/cask/xquartz
brew install r # Stats programming language
brew install tesseract # OCR library
brew install tor # tor browser

# Lxml and Libxslt
brew install libxml2 # XML C parser by Gnome project
brew install libxslt # XSLT C parser by Gnome project
brew link libxml2 --force
brew link libxslt --force

# Install Heroku (cloud app platform)
brew install heroku-toolbelt
heroku update

brew install caskroom/cask/brew-cask # Install Cask

# Core casks
brew cask install --appdir="~/Applications" iterm2 # terminal alternative
brew cask install --appdir="~/Applications" java # language
brew cask install --appdir="~/Applications" xquartz # Apple's X server

# Development tool casks
brew cask install --appdir="/Applications" atom # hackable code text editor
brew cask install --appdir="/Applications" dash # api documentation
brew cask install --appdir="/Applications" github-desktop # code repository
#brew cask install --appdir="/Applications" intellij-idea # Java IDE (~issues)
brew cask install --appdir="/Applications" macdown # mac markup editor
# brew cask install --appdir="/Applications" mactex # mac TeX distribution
brew cask install --appdir="/Applications" phantomjs # full stack (without browser)
brew cask install --appdir="/Applications" processing # visual coding sandbox
brew cask install --appdir="/Applications" pycharm # python IDE
brew cask install --appdir="/Applications" rstudio # R IDE
brew cask install --appdir="/Applications" sublime-text # code text editor
brew cask install --appdir="/Applications" textwrangler # basic text editor
brew cask install --appdir="/Applications" vagrant # virtual environments
brew cask install --appdir="/Applications" vagrant-manager
brew cask install --appdir="/Applications" virtualbox # virtual machines

# Google casks
brew cask install --appdir="/Applications" google-chrome # browser
brew cask install --appdir="/Applications" google-drive # cloud storage
brew cask install --appdir="/Applications" google-earth # earth
brew cask install --appdir="/Applications" google-photos-backup # photos
brew cask install --appdir="/Applications" google-hangouts # hangouts chat
brew cask install --appdir="/Applications" google-refine # messy data helper


# Storage casks
brew cask install --appdir="/Applications" box-sync # cloud storage
brew cask install --appdir="/Applications" dropbox # cloud storage

# Productivity casks
##brew cask install --appdir="/Applications" evernote
brew cask install --appdir="/Applications" mendeley-desktop # reference manager
brew cask install --appdir="/Applications" microsoft-office # office suite
##brew cask install --appdir="/Applications" slack

# Security, organization, utility casks
brew cask install --appdir="/Applications" appcleaner # application cleaner
brew cask install --appdir="/Applications" avira-antivirus # mac antivirus
brew cask install --appdir="/Applications" caffeine # keep system awake
brew cask install --appdir="/Applications" cyberduck # SSH / FTP client
brew cask install --appdir="/Applications" flash # adobe flash
brew cask install --appdir="/Applications" flash-player # adobe plash player
brew cask install --appdir="/Applications" flux # screen ergonomics
brew cask install --appdir="/Applications" lastpass # password manager
brew cask install --appdir="/Applications" malwarebytes-anti-malware # anti-malware
brew cask install --appdir="/Applications" onyx # cleaning utility
brew cask install --appdir="/Applications" silverlight # microsoft's flash
brew cask install --appdir="/Applications" the-unarchiver # archive utility
brew cask install --appdir="/Applications" tunnelbear # free VPN client

# Misc. casks
brew cask install --appdir="/Applications" vivaldi # fun new web browser
brew cask install --appdir="/Applications" firefox # when chrome sucks
brew cask install --appdir="/Applications" gdal-framework # open GIS framework
brew cask install --appdir="/Applications" lastfm # music / video
brew cask install --appdir="/Applications" qgis # open source GIS
# brew cask install --appdir="/Applications" skype # where the chatting happens
brew cask install --appdir="/Applications" spotify # where the magic happens
brew cask install --appdir="/Applications" steam # where the fun happens

# Install Docker, which requires virtualbox
brew install docker # application packaging
brew install boot2docker # mac docker assistant

# Install developer friendly quick look plugins; see https://github.com/sindresorhus/quick-look-plugins
brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv betterzipql qlimagesize webpquicklook suspicious-package
