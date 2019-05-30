#!/bin/env python
# -*- coding: utf-8 -*-


import os
import shutil
import urllib.request


def main():
    validate()
    home = os.environ["HOME"]
    create_links(home)
    install_plug(home)


def validate():
    out = shutil.which("nvim")
    if not out:
        raise Exception("nvim not installed.")


def install_plug(home):
    plugpath = os.path.join(home, ".local/share/nvim/site/autoload/")
    if not os.path.exists:
        os.makedirs(plugpath)

    plugfile = os.path.join(plugpath, "plug.vim")
    url = "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
    urllib.request.urlretrieve(url, plugfile)

    os.system("nvim +PlugInstall +qall")


def create_links(home):
    dotfilesdir = os.path.abspath(".")
    configs = [(f, f.replace("_", "/")) for f in os.listdir(".") if f != __file__]

    for orig, dest in configs:
        source = os.path.join(dotfilesdir, orig)
        destination = os.path.join(home, dest)

        destpath = os.path.dirname(destination)
        os.makedirs(destpath, exist_ok=True)

        if os.path.exists(destination):
            if not os.path.islink(destination):
                bkp = "{}.bkp".format(destination)
                if not os.path.exists(bkp):
                    os.rename(destination, bkp)

            os.remove(destination)

        print("{} ➡ {}".format(source, destination))
        os.symlink(source, destination)


if __name__ == "__main__":
    main()
