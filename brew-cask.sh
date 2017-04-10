#!/bin/bash


# to maintain cask ....
brew update && brew cleanup && brew cask cleanup


# Install native apps

# brew tap caskroom/versions

brew cask install spectacle

# dev
brew cask install iterm2
brew cask install sublime-text
brew cask install imagealpha
brew cask install imageoptim

# fun
brew cask install limechat
brew cask install miro-video-converter

# browsers
# brew cask install google-chrome-canary
# brew cask install firefoxnightly
# brew cask install webkit-nightly
brew cask install chromium
# brew cask install torbrowser

# less often
brew cask install disk-inventory-x
brew cask install screenflow
brew cask install gpgtools
brew cask install licecap
brew cask install obs
