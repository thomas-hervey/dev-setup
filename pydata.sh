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
pip install virtualenv
pip install virtualenvwrapper

echo "------------------------------"
echo "Source virtualenvwrapper from ~/.extra"

EXTRA_PATH=~/.extra
echo $EXTRA_PATH
echo "" >> $EXTRA_PATH
echo "" >> $EXTRA_PATH
echo "# Source virtualenvwrapper, added by pydata.sh" >> $EXTRA_PATH
echo "export WORKON_HOME=~/.virtualenvs" >> $EXTRA_PATH
echo "source /usr/local/bin/virtualenvwrapper.sh" >> $EXTRA_PATH
echo "" >> $BASH_PROFILE_PATH
source $EXTRA_PATH

###############################################################################
# Python 2 Virtual Enviroments                                                #
###############################################################################

echo "------------------------------"
echo "Setting up py2-total virtual environment."

# Create a Python2 (all packages) environment
mkvirtualenv py2-total
workon py2-total

### COMMON ###
pip install matplotlib        # plotting package
pip install numpy             # data array processing
pip install pandas            # data structures
pip install scipy             # scientific library
pip install scikit-learn      # machine learning and data mining
pip install sympy             # computer algebra system (CAS)
pip install "ipython[all]"    # interactive python shell

### package utils ###
pip install distribute        # easily download, build, etc. Python packages
pip install pbr               # managing setuptools packaging
pip install pip               # PyPA recommended package installer
pip install wheel             # a built-package format for Python
pip install setuptools        # easily download, build, etc. Python packages
pip install stevedore         # manage dynamic plugins for Python applications
pip install six               # Python 2 & 3 compatibility util
pip install virtualenv        # virtual Python Environment builder
pip install virtualenv-clone  # script to clone virtualenvs
pip install virtualenvwrapper # enhancements to virtualenv

### testing ###
pip install coverage          # code coverage measurement
pip install nose              # extends unittest to make testing easier
pip install unittest2         # unit testing

### plotting ###
pip install bokeh             # statistical interactive HTML plots for Python
pip install seaborn           # statistical data visualization

### web development ###
pip install django            # web development framework
pip install Flask             # microframework
pip install werkzeug          # web development swiss army knife
pip install zope.interface    # interfaces for Python

### database ###
pip install boto              # AWS SDK
pip install mysql-python      # interface for MySQL
pip install psycopg2          # PostgreSQL database adapter
pip install PyMySQL           # MySQL driver
pip install sqlalchemy        # database abstraction

### scraping & gathering ###
pip install beautifulsoup4    # screen-scraping library
pip install feedfinder2       # finds feed URLs for webpage
pip install feedparser        # universal feed parser
pip install jellyfish         # approximate and phonetic string matching
pip install jieba             # Chinese word segmentation util
pip install newspaper         # article discovery & extraction
pip install nltk              # natural language toolkit
pip install Pillow            # Python imaging
pip install pytesseract       # Tesseract (OCR)

### spatial ###
pip install geograpy          # extract countries, cities, etc from a URL/text
pip install geopy             # geocoding library for Python
pip install Shapely           # geometric objects, predicates, and operations
pip install pycountry         # ISO country, language, etc. script definitions
pip install python-dateutil   # date-time extension util
pip install pytz              # timezone definitions

### data formatting ###
pip install pyasn1            # ASN.1 util
pip install cssselect         # translates CSS selectors to XPATH
pip install docutils          # plaintext documentation to useful formats
pip install jmespath          # JSON matching expressions
pip install lxml              # XML: combine libxml2/libxslt w/ ElementTree API
pip install python-magic      # file type identification using libmagic
pip install PyYAML            # YAML (human friendly data serialization)
pip install simplejson        # JSON de/encoder

### networking ###
pip install certifi           # root certificates validating SSL trustworthiness
pip install requests          # HTTP for humans
pip install selenium          # automating web browsers
pip install tldextract        # separate TDL from registered subdomain of URL
pip install tornado           # asynchronous networking
pip install twisted           # asynchronous networking framework


###############################################################################
# Install IPython Profile
###############################################################################

echo "------------------------------"
echo "Installing IPython Notebook Default Profile"

# Add the IPython profile
cp -r init/profile_default/ ~/.ipython/profile_default

echo "------------------------------"
echo "Script completed."
echo "Usage: workon py2-data for Python2"
echo "Usage: workon py3-data for Python3"

echo "figure out what to do with: brew install libmagic : pip install python-magic"
