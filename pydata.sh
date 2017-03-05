#!/usr/bin/env bash

# ~/pydata.sh

# Removed user's cached credentials
# This script might be run with .dots, which uses elevated privileges
sudo -K

echo "------------------------------"
echo "Setting up pip."

# Install pip
easy_install pip

###############################################################################
# Virtual Enviroments                                                         #
###############################################################################

echo "------------------------------"
echo "Setting up virtual environments."

# Install virtual environments globally
# It fails to install virtualenv if PIP_REQUIRE_VIRTUALENV
pip install virtualenv
pip install virtualenvwrapper

echo "------------------------------"
echo "Source virtualenvwrapper from ~/.extra"

#EXTRA_PATH=~/.extra ##commented since this should save in .zshrc instead
ZSHRC_PATH=~/.zshrc
echo $ZSHRC_PATH
echo "" >> $ZSHRC_PATH
echo "" >> $ZSHRC_PATH
echo "# Source virtualenvwrapper, added by pydata.sh" >> $ZSHRC_PATH
echo "export WORKON_HOME=~/.virtualenvs" >> $ZSHRC_PATH
echo "source /usr/local/bin/virtualenvwrapper.sh" >> $ZSHRC_PATH
echo "" >> $BASH_PROFILE_PATH
source $ZSHRC_PATH

EXTRA_PATH=~/.extra
echo "PIP_REQUIRE_VIRTUALENV=true" >>$EXTRA_PATH

###############################################################################
# Python 2 Virtual Enviroments                                                #
###############################################################################

echo "------------------------------"
echo "Setting up py2 virtual environment with virtualenv and virtualenvwrapper."

# Create a Python2 (all packages) environment
mkvirtualenv py2
workon py2

# **************** #
# install packages
pip install -r personal_preferences/py2_requirements.txt


###############################################################################
# Install IPython Profile
###############################################################################

echo "------------------------------"
echo "Installing IPython Notebook Default Profile"

# Add the IPython profile
mkdir -p ~/.ipython
cp -r init/profile_default/ ~/.ipython/profile_default

echo "------------------------------"
echo "Script completed."
echo "Usage: workon py2 for Python2"
