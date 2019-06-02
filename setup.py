#!/bin/env python
# -*- coding: utf-8 -*-


import os
import shutil
import urllib.request


def log(*args):
    print(*args)

def main():
    log()
    log("➡ 1 - Validdating")
    validate()
    home = os.environ["HOME"]
    log("Home:", home)
    log()
    log("➡ 2 - Creating symlinks")
    create_links(home)
    log()
    log("➡ 3 - Installing nvim plug")
    install_vim_plug(home)
    log()
    log("➡ 4 - Installing tmux TPM")
    install_tmux_tpm(home)
    log()
    log("------------ done ")


def validate():
    out = shutil.which("nvim")
    if not out:
        raise Exception("nvim not installed.")


def install_vim_plug(home):
    plugpath = os.path.join(home, ".local/share/nvim/site/autoload/")
    if not os.path.exists:
        os.makedirs(plugpath)

    plugfile = os.path.join(plugpath, "plug.vim")
    if os.path.exists(plugfile):
        log("skipping, plug already installed")
        return

    url = "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"

    log("downloading plug")
    urllib.request.urlretrieve(url, plugfile)

    log("installing pluguins")
    os.system("nvim +PlugInstall +qall")


def install_tmux_tpm(home):
    tpmpath = os.path.join(home, ".tmux/plugins/tpm")
    if os.path.exists(tpmpath):
        log("skipping, tpm already installed")
        return

    os.system("git clone https://github.com/tmux-plugins/tpm {}".format(tpmpath))
    os.system("TMUX_PLUGIN_MANAGER_PATH={} {}".format(tpmpath, os.path.join(tpmpath, "bin/install_plugins")))


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
