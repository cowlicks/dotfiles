#! /usr/bin/env bash
# Script for deploying dot files.

# TODO

# Set home dir and old_dotfiles dir.
dir=~/.dotfiles
olddir=~/dotfiles_old
files="bashrc condarc irssi tmux.conf vim vimrc global_gitignore gitconfig"

# mv existing dotfiles to old_dotfiles
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo "done"

# link my dotfiles to the home dir.
echo "Changing to the $dir directory"
cd $dir
echo "done"

#Move dotfiles into the homedir and existing dotfiles to dotfiles_old dir.
for file in $files; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/.$file ~/dotfiles_old/
    echo "Creating symlink to $file in home dir."
    ln -s $dir/$file ~/.$file
done
