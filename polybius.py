#! /usr/bin/env python

import sys

# check number of arguments
if len(sys.argv) != 2:
    print "Usage: poly <data>"
    exit(0)

# letters 'a' to 'z' without 'j'
alphabet = filter(lambda x: x != 'j', [chr(ord('a') + x) for x in range(0, 26)])

# filter bad symbols from parameter
word = filter(lambda x: x in alphabet, sys.argv[1]);

# append numbers to letters, [('a', 0), ('b', 1)...]
alphabet = zip(alphabet, range(0, 25))

# two empty dictionaries for searching letter and table coordinates by each other
forward = {}
backward = {}

# function that adds letter and its coordinates to both dictionaries
def add_code(x):
    forward[x[0]] = (x[1] % 5, x[1] / 5)
    backward[(x[1] % 5, x[1] / 5)] = x[0]

# run through alphabet adding letters
map(add_code, alphabet)

print word

# make list of encoded coordinates:
#                 take x coordinates                   take y coordinates    
coords = map(lambda c: forward[c][0], word) + map(lambda c: forward[c][1], word)

print coords

# group coordinates to pairs:
coord_pairs = zip([coords[x*2] for x in range (0, len(word))],
                  [coords[x*2 + 1] for x in range (0, len(word))])

print coord_pairs

# convert coordinate pairs back to letters:
encoded = map(lambda c: backward[c], coord_pairs)

# print the result
print encoded
