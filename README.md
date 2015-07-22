Install
=======

    $ cd ~
    $ git clone [repo]
    $ git submodule update --init
    $ ln -s .files2/_bash_profile .bash_profile
    $ ln -s .files2/_bashrc .bashrc
    $ touch ~/.bashrc.local
    $ ln -s .files2/_tmux.conf .tmux.conf
    $ ln -s .files2/_vimrc .vimrc
    $ touch ~/.vim.local
    $ cp .files2/_gitconfig.dist .gitconfig
    $ git config --global user.name [your name]
    $ git config --global user.email [your email]
    $ git config --global github.user [your github username]

tmux
====

Create a new session

    tmux -u new -s [name]

Attach to the session

    tmux -u attach

vim
===

You can create a `~/.vimrc.local` file to add private settings.

git
===

The copy of `_gitconfig.dist` contains your private settings.
