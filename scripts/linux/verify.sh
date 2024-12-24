#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: $0 <process_name>"
  exit 1
fi

export PID="$1"
if [ -z "$PID" ]; then
  echo "Process '$1' not found."
  exit 1
fi

if [ -z "$LD_PRELOAD" ]; then
  echo "LD_PRELOAD is not set, required on Linux platform to preload tcmalloc"
  kill -9 "$PID"
  exit 1
fi

echo "LD_PRELOAD is set to $LD_PRELOAD"

# Get the process name
PROCESS_NAME=$(ps -p "$PID" -o comm=)

# Check for tcmalloc references in the open files of the process
echo "Running lsof -p"
echo "$(lsof -p "$PID")"
echo ""

echo "Looking in /proc/$PID/maps"
find "/proc/$PID/maps"
echo ""

TCMALLOC_REF=$(lsof -p "$PID" | grep "libtcmalloc.so")

if [ -z "$TCMALLOC_REF" ]; then
  echo "No tcmalloc references found for process '$PROCESS_NAME' (PID: $PID)."
  kill -9 "$PID"
  exit 1
else
  echo "Process '$PROCESS_NAME' (PID: $PID) is using tcmalloc."
  echo "tcmalloc reference found at:"
  echo "$TCMALLOC_REF"
fi
