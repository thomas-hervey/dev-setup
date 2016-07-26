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

echo "******************************"
echo "******************************"
read -p "Hello! Let's set up roots.io webpage. All commands that start with *, you should do. Ready? (y)" -n 1;
if [[ $REPLY =~ ^[Yy]$ ]]; then
  echo "Good, we will begin by checking the current local hostname configurations."
fi;

# remove any beginning hosts
cd ~/
sudo atom etc/hosts
echo "*Go into your hosts file and delete overlaps / unnecessary hosts ('hosts' should have been opened; if not, redo command with another editor other than atom)."
read -p  "This will create a new ssh key. Continue? (y)" -n 1;
if [[ $REPLY =~ ^[Yy]$ ]]; then

    cd ~/.ssh
    ls

    read -p "*Check and see if the key 'id_rsa1' exists. If so, the following command will overwrite it. Continue? (y)"
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      echo "Creating an ssh key for Digital Ocean"
      echo "*Don't give a passphrase for now"
      ssh-keygen -t rsa
      /Users/Thomas/.ssh/id_rsa1

      echo "Concatinating the new ssh key with original id_rsa"
      cat / Users/Thomas.ssh/id_rsa.pub

      read -p "Copy the above key and add it to Digital Ocean ssh keys by creating a new droplet. Make sure it is running Ubuntu 14.04!! Then copy the droplet's IP address. Continue? (y)"
    	if [[ $REPLY =~ ^[Yy]$ ]]; then
    		echo "*enter new host into .ssh/config file"
    		echo " The host format is:"
    		echo "Host [same name as droplet]"
    		echo "	HostName [paste droplet's IP]"
    		echo "	Port 22"
    		echo "	User root"
    		echo "IdentityFile ~/.ssh/id_rsa"
    		sudo atom ~/.ssh/config

    		read -p "Save your new host into the .ssh/config file. To continue, type the new Host name (ie. Roots1)"
    		echo "Testing the ssh key by ssh-ing into the newly created droplet. If successful, you'll be ssh-ed in. [cmd-D to exit]"
    		echo "Troubleshooting at: http://jackalope.io/installing-roots/ [look at #8]"
    		ssh root@$REPLY

    		fi;

     	fi;

    fi;
fi;


read -p "Have you already set up requirements for trellis? If this is your first time, it's not likely (y/N)"
if [[ $REPLY =~ ^[Nn]$ ]]; then
  # setup for trellis (Roots.io)
  brew install ansible20 # version 2.1 causes vagrant issues
  brew install composer
  brew cask install --appdir="/Applications" virtualbox # virtual machines
  brew cask install --appdir="/Applications" vagrant # virtual environments
  vagrant plugin install vagrant-hostmanager
  vagrant plugin install vagrant-bindfs
fi;

mkdir ~/Projects/Sites/roots1
cd ~/Projects/Sites/roots1

git clone --depth=1 git@github.com:roots/trellis.git && rm -rf trellis/.git
#git clone git@github.com:roots/trellis.git
#cd trellis
#git checkout ed6c63587adb3ffbdd60f64644470d9f7d81d13d
#rm -rf .git

git clone --depth=1 git@github.com:roots/bedrock.git site && rm -rf site/.git
#git clone git@github.com:roots/bedrock.git
#cd bedrock
#git checkout 43ff1ed14706a5af0c486d5ab6356f40df8b1589
#rm -rf .git

cd trellis && ansible-galaxy install -r requirements.yml

cd ..
git clone https://github.com/roots/sage.git site/web/app/themes/sage
#git clone git@github.com:roots/sage.git site/web/app/themes/sage
#cd site/web/app/themes/sage
#git checkout 8d7bcee4c46173d11dd8ea9a06021d8c27891b64
#rm -rf .git

cd site/config
atom application.php

read -p "add ' define('WP_DEFAULT_THEME', 'sage'); ' right below \$webroot_dir . Continue? (y)" -n 1;
if [[ $REPLY =~ ^[Yy]$ ]]; then
  php -v
  echo "Installing php v 5.6 (since OSX ships with 5.5)"
  curl -s http://php-osx.liip.ch/install.sh | bash -s 5.6
  export PATH=/usr/local/php5/bin:$PATH
  node -v
  gulp -v
  bower -v
  echo "If above commands fail, you don't have packages installed. Visit https://github.com/roots/sage#requirements for requirements. "
fi;

echo "Configuring sage: installing soil plugin, running npm install, running bower install, running gulp"
cd ~/Projects/Sites/roots1/site && composer require roots/soil
cd web/app/themes/sage && npm install
bower install
gulp

read -p "These should have all run successfully. If not, revisit before continuing. Continue? (y)" -n 1;
if [[ $REPLY =~ ^[Yy]$ ]]; then
  read -p   echo "Great work! Now just go into the GitHub app and push the repo to your github. Continue? (y)"  -n 1;
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    read -p   echo "Read the following & exicute commands to vagrant up. Continue? (y)"  -n 1;
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      echo "*edit trellis/group_vars/development/wordpress_sites.yaml [rename all example -> roots1 / roots1.com]"
      echo "*edit trellis/group_vars/development/vault.yaml [rename all example -> roots1]"
      echo "*edit manifest.json [rename all example.dev -> roots1.dev]"
      echo "*commit changes now! [commit summary should be 'local config']"
      vagrant status
      read -p   echo "Ready to run vagrant up? (y)"  -n 1;
      if [[ $REPLY =~ ^[Yy]$ ]]; then
        cd ~/Projects/Sites/roots1/trellis
        vagrant up

        read -p   echo "Hopefully there weren't any vagrant issues. Next up, gulp watch. Continue? (y)"  -n 1;
        if [[ $REPLY =~ ^[Yy]$ ]]; then
          cd ~/Projects/Sites/roots1/site/web/app/themes/sage
          gulp watch
        fi;
      fi;
    fi;
  fi;
fi;

read -p "If that worked, your browser should open at localhost:3000. Next, let's update staging. Continue? (y)" -n 1;
if [[ $REPLY =~ ^[Yy]$ ]]; then
  echo "*repeat similar group_vars/development steps for staging vault and wordpress_sites. replace staging.example.com with droplet's IP"
  echo "*In group_vars/staging/vaults follow comment instruction to generate salts and paste"
  echo "*update repo: [by grabbing clone with ssh on github's (click arrow on green button)]"
  echo "*go to hosts/staing & replace both [staging] and [web] your_server_host_name with droplet's IP"
  echo "*go back to ~/etc/hosts and paste in droplet's IP"
  echo "*uncomment all within deploy-hooks/build-before.yaml"
  echo "*commit changes 'ready to provision and deploy'"
  # TODO: Figure out why I get an error running the following line
  echo "*In Trellis, provision the server by running: ansible-playbook server.yml -e env=staging"
  echo "If this has run successfully, go to the project's root folder and run git init, then git push. Using the github gui gives issues."
  echo "*Run ./deploy.sh staging roots1.com"

fi;


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
