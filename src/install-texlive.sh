#!/usr/bin/env bash
set -e

VERSION="$1"

echo "Installing latest TeXLive $1 ..."

URL="ftp://tug.org/historic/systems/texlive/$VERSION/install-tl-unx.tar.gz"

# curl and unpack
echo " => curl -#L $URL | tar zxf -"
curl -#L $URL | tar zxf -

# Move into appropriate directory
mv install-tl-* install-tl

# Setup profile
echo "selected_scheme scheme-full" > install-tl/profile
echo "TEXDIR /opt/texlive/" >> install-tl/profile

# Run the command with arguments
echo " => ./install-tl/install-tl -profile install-tl/profile"
./install-tl/install-tl -profile install-tl/profile

# Setup path
echo " => echo \"PATH=/opt/texlive/bin/x86_64-linux/\$PATH\" >> \$HOME/.bashrc"
echo "PATH=/opt/texlive/bin/x86_64-linux/\$PATH" >> $HOME/.bashrc

# and cleanup
echo " => rm -rf install-tl"
rm -rf install-tl