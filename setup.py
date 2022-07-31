#!/bin/env python
# -*- coding: utf-8 -*-


import os
import sys
import shutil
import urllib.request


IGNORE = [
    __file__,
    ".git",
    "README.md",
    "colors.sh"
]


class Color:
    Header = '\033[95m'
    Blue = '\033[94m'
    Green = '\033[92m'
    Yellow = '\033[93m'
    Red = '\033[91m'
    Normal = '\033[0m'
    Bold = '\033[1m'
    Underline = '\033[4m'


def log(*args, color=None):
    text = " ".join(args)
    if color:
        print(color, text, Color.Normal)
    else:
        print(text)


def main():
    log()
    title = lambda x: log(x, color=Color.Header)
    title("➡ 1 - Validdating")
    validate()
    home = os.environ["HOME"]
    log("Home:", home)
    log()
    title("➡ 2 - Creating symlinks")
    create_links(home)
    log()
    title("➡ 3 - Installing nvim plug")
    install_vim_plug(home)
    log()
    title("➡ 4 - Installing tmux TPM")
    install_tmux_tpm(home)
    log()
    log("------------ done ")


def validate():
    def check(command):
        out = shutil.which(command)
        if not out:
            log(f"{command} not installed.", color=Color.Red)
            sys.exit(1)

    check("nvim")
    check("tmux")


def install_vim_plug(home):
    plugpath = os.path.join(home, ".local/share/nvim/site/autoload/")
    if not os.path.exists(plugpath):
        os.makedirs(plugpath)

    plugfile = os.path.join(plugpath, "plug.vim")
    if os.path.exists(plugfile):
        log("skipping, plug already installed", color=Color.Red)
        return

    url = "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"

    log("downloading plug")
    urllib.request.urlretrieve(url, plugfile)

    log("installing pluguins")
    os.system("nvim +PlugInstall +qall")


def install_tmux_tpm(home):
    tpmpath = os.path.join(home, ".tmux/plugins/tpm")
    if os.path.exists(tpmpath):
        log("skipping, tpm already installed", color=Color.Red)
        return

    os.system("git clone https://github.com/tmux-plugins/tpm {}".format(tpmpath))
    os.system("TMUX_PLUGIN_MANAGER_PATH={} {}"
              .format(tpmpath, os.path.join(tpmpath, "bin/install_plugins")))


def create_links(home):
    dotfilesdir = os.path.abspath(".")
    configs = [(f, f.replace("_", "/")) for f in os.listdir(".") if not f in IGNORE]
    width = max([len(c[0]) for c in configs])

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
            else:
                os.remove(destination)

        log(f"{Color.Blue}{orig.ljust(width)}{Color.Yellow} ➡"\
            f" {Color.Green}{destination}{Color.Normal}")
        os.symlink(source, destination)


if __name__ == "__main__":
    main()
