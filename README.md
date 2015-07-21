Install
=======

    $ cd ~
    $ git clone [repo]
    $ git submodule update --init
    $ ln -s .files2/_vimrc .vimrc
    $ ln -s .files2/_tmux.conf .tmux.conf

tmux
====

Create a new session

    tmux -u new -s [name]

Attach to the session

    tmux -u attach
