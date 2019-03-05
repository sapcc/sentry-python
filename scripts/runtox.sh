#!/bin/bash
set -e

if [ -z "$TOXPATH" ]; then
    TOXPATH=tox
fi

# Usage: sh scripts/runtox.sh py3.7 <pytest-args>
# Runs all environments with substring py3.7 and the given arguments for pytest

if [ -z "$1" ] && [ -n "$TRAVIS_PYTHON_VERSION" ]; then
    searchstring="$(echo py$TRAVIS_PYTHON_VERSION | sed -e 's/pypypy/pypy/g' -e 's/-dev//g')"
else
    searchstring="$1"
fi

exec $TOXPATH -p auto -e $(tox -l | grep "$searchstring" | tr '\n' ',') -- "${@:2}"
