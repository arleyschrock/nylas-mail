#!/bin/bash

sudo -E apt-get -yq --no-install-suggests --no-install-recommends --force-yes install build-essential clang fakeroot g++-4.8 git libgnome-keyring-dev xvfb rpm libxext-dev libxtst-dev libxkbfile-dev

export NODE_VERSION=6.9
export CC=gcc-4.8
export CXX=g++-4.8
export DEBUG="electron-packager:*"
export INSTALL_TARGET=client
export CC=gcc-4.8
export CXX=g++-4.8
export DEBUG="electron-packager:*"
export INSTALL_TARGET=client

if [ ! -d nvm ]; then
    git clone http://github.com/creationix/nvm

    cd nvm 
    source ./nvm.sh 
    cd ../
fi


nvm install $NODE_VERSION
nvm use --delete-prefix $NODE_VERSION

npm install 
cd $(dirname $0)/packages/client-app

npm install grunt grunt-cli --save-dev && npm install
cd ../..
npm install

lerna bootstrap
npm install

npm run build-client 
# npm run upload-client