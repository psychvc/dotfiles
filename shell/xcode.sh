#!/usr/bin/env bash

set -x 

if [ -f ~/Applications/Xcode-beta.app ]; then 
  xcode-select --switch ~/Applications/Xcode-beta.app/Contents/Developer
fi
