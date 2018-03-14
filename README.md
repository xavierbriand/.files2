Install
=======

    $ cd ~
    $ git clone [repo]
    $ cd .files2
    $ curl -fLo vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    In ~/.bash_profile
    source .files2/_bash_profile

    In ~/.bashrc
    source .files2/_bashrc

    $ ln -s .files2/vim .vim

    In ~/.vimrc
    source .files2/_vimrc

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
