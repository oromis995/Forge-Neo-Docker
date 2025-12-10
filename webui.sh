#!/usr/bin/env bash

set -e
set -o pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Load optional settings file
if [[ -f "${SCRIPT_DIR}/webui.settings.sh" ]]; then
    source "${SCRIPT_DIR}/webui.settings.sh"
fi

# Defaults
PYTHON="${PYTHON:-python}"
VENV_DIR="${VENV_DIR:-${SCRIPT_DIR}/venv}"

if [[ -n "$GIT" ]]; then
    export GIT_PYTHON_GIT_EXECUTABLE="$GIT"
fi

SD_WEBUI_RESTART="tmp/restart"
ERROR_REPORTING="FALSE"

mkdir -p tmp

# ---- Python availability check ----
if uv help python >tmp/stdout.txt 2>tmp/stderr.txt; then
    :
elif $PYTHON -c "" >tmp/stdout.txt 2>tmp/stderr.txt; then
    :
else
    echo "Couldn't launch python"
    echo
    echo "exit code: $?"
    echo "stdout:"
    cat tmp/stdout.txt
    echo
    echo "stderr:"
    cat tmp/stderr.txt
    exit 1
fi

# ---- Pip availability check ----
if uv help pip >tmp/stdout.txt 2>tmp/stderr.txt; then
    :
elif $PYTHON -m pip --help >tmp/stdout.txt 2>tmp/stderr.txt; then
    :
else
    echo "Couldn't launch pip"
    echo
    echo "exit code: $?"
    echo "stdout:"
    cat tmp/stdout.txt
    echo
    echo "stderr:"
    cat tmp/stderr.txt
    exit 1
fi

# ---- Venv setup ----
if [[ "$VENV_DIR" != "-" ]] && [[ "$SKIP_VENV" != "1" ]]; then

    if [[ -f "$VENV_DIR/bin/python" ]]; then
        # Already exists
        :
    else
        PYTHON_FULLNAME="$($PYTHON -c 'import sys; print(sys.executable)')"
        echo "Creating venv in directory $VENV_DIR using python $PYTHON_FULLNAME"

        if "$PYTHON_FULLNAME" -m venv "$VENV_DIR" >tmp/stdout.txt 2>tmp/stderr.txt; then
            :
        else
            echo "Unable to create venv in directory $VENV_DIR"
            echo
            echo "exit code: $?"
            echo "stdout:"
            cat tmp/stdout.txt
            echo
            echo "stderr:"
            cat tmp/stderr.txt
            exit 1
        fi

        # Upgrade pip
        if "$VENV_DIR/bin/python" -m pip install --upgrade pip; then
            :
        else
            echo "Warning: Failed to upgrade PIP version"
        fi
    fi

    # Activate venv
    export PYTHON="$VENV_DIR/bin/python"
    source "$VENV_DIR/bin/activate"
    echo "venv $PYTHON"

fi

# ---- Launch application ----
"$PYTHON" launch.py "$@"

if [[ -e tmp/restart ]]; then
    exit 0
fi

read -rp "Press Enter to exit..."
exit 0
