echo "***** Copy dot files to Git repo ***"

#!/bin/bash

# Set the value of REPO based on the operating system
if [[ "$(uname)" == "Darwin" ]]; then
  # MacOS
  export REPO="/Users/johanweitner/Code/dotfiles/"
elif [[ "$(expr substr $(uname -s) 1 5)" == "Linux" ]]; then
  # Linux
  export REPO="~/Code/dotfiles/"
else
  # Other operating systems
  echo "Unknown system"
  exit 1
fi

# Print the value of MY_VAR
cp ~/.zshrc $REPO
cp ~/.zprofile $REPO
cp ~/.p10k.zsh $REPO
cp ~/.nbrc $REPO
cp ~/.profile $REPO
cp ~/.opencommit $REPO/.opencommit
cp ~/.config/op/config $REPO/.config/op
cp -r ~/.warp/ $REPO/.warp
cp -r ~/.todo/ $REPO/.todo
cp -r ~/.oh-my-zsh/custom/ $REPO/.oh-my-zsh/custom
cp -r ~/.nb/ $REPO/.nb
cp -r ~/.config/ $REPO/.config
cp -r ~/Script/ $REPO/Script