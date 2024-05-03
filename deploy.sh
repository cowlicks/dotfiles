#! /usr/bin/env bash
# Script for deploying dot files.

set -e

dot_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
olddir=~/.dotfiles_old
files="bashrc tmux.conf vim vimrc global_gitignore gitconfig zshrc emacs.d"

# mv existing dotfiles to old_dotfiles
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo "done"

#Move dotfiles into the homedir and existing dotfiles to dotfiles_old dir.
for file in $files; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/.$file $olddir/ || true
    echo "Creating symlink to $file in home dir."
    ln -s $dot_dir/$file ~/.$file
done
