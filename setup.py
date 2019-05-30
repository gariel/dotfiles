#!/bin/env python

import os


def main():
    home = os.environ["HOME"]
    dotfilesdir = os.path.abspath(".")
    configs = [(f, f.replace("_", "/")) for f in os.listdir(".") if f != __file__]

    for orig, dest in configs:
        source = os.path.join(dotfilesdir, orig)
        destination = os.path.join(home, dest)
        print("{} ➡ {}".format(source, destination))
        #os.symlink(source, destination)


if __name__ == "__main__":
    main()
