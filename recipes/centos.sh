#!/bin/bash
#
# Author: Josh Frye <joshfng@gmail.com>
# Licence: MIT
#
# Contributions from: Wayne E. Seguin <wayneeseguin@gmail.com>
# Contributions from: Ryan McGeary <ryan@mcgeary.org>
#

ruby_version=$1
ruby_version_string=$2
ruby_source_url=$3
ruby_source_tar_name=$4
ruby_source_dir_name=$5
whichRuby=$6
script_runner=$(whoami)
railsready_path=$7
log_file=$8

git_source_url="http://kernel.org/pub/software/scm/git/git-1.7.3.5.tar.bz2"
git_source_tar_name="git-1.7.3.5.tar.bz2"
git_source_dir_name="git-1.7.3.5"

#echo "vars set: $ruby_version $ruby_version_string $ruby_source_url $ruby_source_tar_name $ruby_source_dir_name $whichRuby $railsready_path $log_file"

# Update the system before going any further
echo -e "\n=> Updating system (this may take awhile)..."
sudo yum update -y >> $log_file 2>&1
echo "==> done..."

# Install build tools
echo -e "\n=> Installing build tools..."
sudo yum install -y gcc-c++ patch \
 readline readline-devel zlib zlib-devel \
 libyaml-devel libffi-devel openssl-devel \
 bash curl sqlite3-devel mysql-devel >> $log_file 2>&1
echo "==> done..."

# Install imagemagick
echo -e "\n=> Installing imagemagick (this may take awhile)..."
sudo yum install -y ImageMagick >> $log_file 2>&1
echo "==> done..."

# Install Git
echo -e "\n=> Downloading Git... \n"
cd src && wget $git_source_url
echo -e "\n==> done..."
echo -e "\n=> Extracting Git..."
tar -xf $git_source_tar_name >> $log_file 2>&1
echo "==> done..."
echo -e "\n=> Building Git (this will take awhile)..."
cd  $git_source_dir_name && ./configure >> $log_file 2>&1 \
 && make >> $log_file 2>&1 \
  && sudo make install >> $log_file 2>&1
echo "==> done..."

source ~/bash_profile && source ~/.bashrc
