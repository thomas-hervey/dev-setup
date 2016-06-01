function installIterm() {
  brew cask install --appdir="~/Applications" iterm2 # terminal alternative

  read -p "Now, open iterm2 and install custom settings [/iterm/.plist], and solarized [/iterm/iterm2-colors-solarized]. Did it work?" -n 1;
  echo "";
  if [[ $REPLY =~ ^[Yy]$ ]]; then
      echo "Good! Now close this session, make sure iterm2 is set up. RUN THIS SCRIPT AGAIN and say 'no' to install iterm. Continue to 'installOMZ'."
  fi;
}


function installOMZ() {
  echo "installing oh-my-zsh"
  sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

  read -p "Stop and check to make sure 'oh-my-zsh' installed properly. If so, this next step will install custom settings. Do this? (y/n) " -n 1;
  echo "";
  if [[ $REPLY =~ ^[Yy]$ ]]; then
      mv custom.zshrc.zsh ~/.oh-my-zsh/custom/custom.zshrc.zsh
      echo "Installed custom settings. Now, if OMZ is not running, close this session and switch to OMZ in iterm settings. Then, rerun this script for github options."
  fi;
}


function setupGithubSSH() {
    echo ""
    echo "------------------------------"
    echo "Setting up git to install everything else"
    echo "------------------------------"
    echo ""
    echo "installing git"

    brew install git # source control
    read -p "Did that last line work? If not, we will run 'git clone https://github.com/git/git' (y/n) " -n 1;
    if [[ $REPLY =~ ^[Nn]$ ]]; then
        git clone https://github.com/git/git
    fi;

		echo ""
    echo "Please enter your github email: "
    read github_email
    echo "Please enter your github name: "
    read github_name
    echo "You entered email: $github_email"
    echo "You entered name: $github_name"
    read -p "Are these correct? (y/n) " -n 1;
    if [[ $REPLY =~ ^[Nn]$ ]]; then
      git config --global user.name github_name
      git config --global user.email github_email
    fi;

    echo "--> Lists the files in your .ssh directory, if they exist"
    ls -al ~/.ssh
    echo "--> Creates a new ssh key, using the provided email as a label"
    ssh-keygen -t rsa -b 4096 -C github_email_name
    echo "--> start the ssh-agent in the background"
    eval "$(ssh-agent -s)"
    echo "--> Adding your SSH key to the ssh-agent"
    ssh-add ~/.ssh/id_rsa
    echo "Copying the contents of the id_rsa.pub file to your clipboard"
    pbcopy < ~/.ssh/id_rsa.pub
    echo "Go ahead and add the copied key to Github. To do this... "
    echo "
    In the top right corner of any page, click your profile photo, then click SETTINGS.
    In the user settings sidebar, click SSH keys. Click Add SSH key.
    In the Title field, add a descriptive label for the new key. ie.'Thomas' MacBook Pro'.
    Paste your key into the 'Key' field. Click Add key."
    read -p "Next, we will do an initial pull. When you're ready type: 'Y' " -n 1;
    echo "";
    initialPull $@
}

function initialPull() {
    echo "Attempting to ssh to GitHub"
    ssh -T git@github.com
    read -p "Hopefully there weren't any warnings. Does everything above look okay? When you're finished type: 'Y' " -n 1;
    if [[ $REPLY =~ ^[Yy]$ ]]; then

        # intialize git repository
        echo "--> git init & git remote add origin git@github.com:tomtom92/dev-setup.git"
        git init && git remote add origin git@github.com:tomtom92/dev-setup.git

        # github pull
        echo "-->git fetch origin | it pull origin master"
        git fetch origin;
        git pull origin master;
    else
        echo "--> You selected that there was an error. We have skipped making Projects/dotfiles/dev-setup folder & git init, remote add, pull.
        I'd suggest clarifying these details then rerunning."
    fi;
}


read -p "Would you like to install 'iterm2'? [must install homebrew first] (y/n) " -n 1;
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then
  installIterm $@
fi;

read -p "Would you like to install 'oh-my-zsh'? (y/n) " -n 1;
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then
    installOMZ $@
fi;

read -p "Would you like to install git and github? (y/n) " -n 1;
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then
    setupGithubSSH $@
fi;
