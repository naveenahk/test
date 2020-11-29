#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

apt update \
   && apt-get install -y --no-install-recommends curl ca-certificates gnupg patch

apt update \
   && apt-get install -y --no-install-recommends curl ca-certificates gnupg patch

curl -sL https://deb.nodesource.com/setup_12.x | bash - \
   && apt-get install -y nodejs
   
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
   && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
   && apt-get update \
   && apt-get install -y yarn
   
wget https://github.com/fcwu/docker-ubuntu-vnc-desktop/archive/focal-lxqt.zip
unzip docker-ubuntu-vnc-desktop-focal-lxqt.zip

mkdir -p /src/web
cp -R docker-ubuntu-vnc-desktop-focal-lxqt/web/* /src/web
cd /src/web \
   && yarn config set network-timeout 600000 -g \
   && yarn install --verbose
   && yarn run build
   
sed -i 's#app/locale/#novnc/app/locale/#' /src/web/dist/static/novnc/app/ui.js
