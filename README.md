# To Install

(Re)move ~/.vim and ~/.vimrc if you have them already, and run:

    git clone git@github.com:pivotal/vim-config.git ~/.vim
    cd ~/.vim
    git submodule update --init
    ln -s ~/.vim/vimrc ~/.vimrc

# Updating

As long as your checkout is kept clean, you can easily update, rebase your local changes and update submodules with:

    cd ~/.vim && git pull --rebase ; git submodule update ; cd -

# Getting the newest versions of all submodules

Run this from the main directory:

    cd ~/.vim && git submodule foreach git pull origin master

