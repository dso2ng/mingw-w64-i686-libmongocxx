#!/bin/bash

# gitver.sh - a script to retrive the current release version
# This is derived from https://goo.gl/VCVN8k but modified according
# to individual github repo arrangement
# Usage: get_latest_release mongodb/mongo-cxx-driver

get_latest_release() {
  curl --silent "https://api.github.com/repos/$1/releases" | # Get recent releases from GitHub api
    grep '"tag_name":' |                                            # Get tag line
    grep -v 'legacy' | grep -v rc |                                 # filter out the legacy branch and rc? ones
    head -1 |                                                       # get the newest one from top
    sed -E 's/.*"([^"]+)".*/\1/'                                    # Pluck JSON value
}