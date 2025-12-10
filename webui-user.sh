#!/usr/bin/env bash
set -e

# PYTHON=
# GIT=
# VENV_DIR=

COMMANDLINE_ARGS=""

# --xformers --sage --uv
# --pin-shared-memory --cuda-malloc --cuda-stream
# --skip-python-version-check --skip-torch-cuda-test --skip-version-check --skip-prepare-environment --skip-install

# Call main launcher
bash "$(dirname "$0")/webui.sh"
