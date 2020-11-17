#!/bin/bash

set -e
# assumes called in the SMA_PATH dir
source venv/bin/activate

exec ./manual.py "$@"