#!/usr/bin/env bash

codemod --extensions gradle "'" '"'
codemod --extensions gradle \
        'group: *"(.*)", *name: *"(.*)", *version: *"(.*)"' \
        '"\1:\2:\3"'
codemod --extensions gradle \
        'group: *"(.*)", *name: *"(.*)", *version: *(.*)' \
        '"\1:\2:$\3"'
