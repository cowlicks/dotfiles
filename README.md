dotfiles
========

My dotfiles, vim, bashrc, tmux, global_gitignore, etc.

Nothing special.

# Things to manually

Run `deploy.sh` to install dotfiles.

Install tmux, vim, git.
`sudo apt-get install trash-cli tmux vim git`

## Install virtualenvs and virtualenv wrapper

On debian `sudo install python-pip` then `sudo pip install virtualenv
virtualenvwrapper` usually does it.

## For thinkpads

Put the 20-thinkpad.conf file in `/etc/share/X11/xorg.conf.d/.`


## Install dropbox

Edit the `dropbox.list` file as needed then put it in
`/etc/apt/sources.list.d/`. Add dropbox's gpg key with:

```
$ sudo apt-key adv --keyserver pgp.mit.edu --recv-keys 5044912E
```

(if you want to trust me)

Then apt update & install dropbox.
