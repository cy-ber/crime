#!/bin/bash

#vps="zvur";
vps="cy-ber";

source="https://raw.githubusercontent.com/cy-ber/crime"


# go to root
cd

wget $source/debian7/bench.sh -O - -o /dev/null|bash
