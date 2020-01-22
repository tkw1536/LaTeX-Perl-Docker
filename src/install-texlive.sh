#!/usr/bin/env bash
set -e

VERSION="$1"
LATEST_VERSION="2019"

echo "Installing latest TeXLive $1 ..."
if [ "$VERSION" != "$LATEST_VERSION" ]; then
    INSTALLER_URL="https://ftp.tu-chemnitz.de/pub/tug/historic/systems/texlive/$VERSION/install-tl-unx.tar.gz"
    REPO_URL="https://ftp.tu-chemnitz.de/pub/tug/historic/systems/texlive/$VERSION/tlnet-final/tlpkg/texlive.tlpdb"
else
    INSTALLER_URL="http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz"
    REPO_URL="ctan"
fi;

# echo out all the variables
echo "TexLive automated installation script"
echo "=> VERSION=$VERSION"
echo "=> INSTALLER_URL=$INSTALLER_URL"
echo "=> REPO_URL=$REPO_URL"

# curl and unpack
echo " => curl -#L $INSTALLER_URL | tar zxf -"
curl -#L $INSTALLER_URL | tar zxf -

# Move into appropriate directory
mv install-tl-* install-tl

# Setup profile
echo "selected_scheme scheme-full" > install-tl/profile
echo "TEXDIR /opt/texlive/" >> install-tl/profile

# ./install-tl
echo " => ./install-tl/install-tl -profile install-tl/profile --repository=$REPO_URL"
./install-tl/install-tl -profile install-tl/profile --repository=$REPO_URL

# Setup path
echo " => echo \"PATH=/opt/texlive/bin/x86_64-linux/\$PATH\" >> \$HOME/.bashrc"
echo "PATH=/opt/texlive/bin/x86_64-linux/\$PATH" >> $HOME/.bashrc

# and cleanup
echo " => rm -rf install-tl"
rm -rf install-tl