#/bin/env python

from datetime import datetime
from subprocess import Popen, PIPE


def run(l):
    proc = Popen(l, stdout=PIPE, stderr=PIPE)
    out, _ = proc.communicate()
    return out.decode("utf-8").replace('\n', '')


def outs(sepn, *items):
    return (' ' * sepn).join([i for i in items if i])


def main():
    music = run([
        'playerctl',
        '--player=spotify',
        'metadata',
        '--format',
        #'▶️ {{ artist }} ~ {{ title }}'
        '{{ artist }} ~ {{ title }}'
    ])
    #now = datetime.now().strftime("%H : %M  -  [ %d / %m / %Y ]")
    #return outs(2, now, music)
    return outs(2, music)


if __name__ == '__main__':
    print(main())
