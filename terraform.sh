#!/usr/bin/env bash
set -x
cd ./environments/dev

terraform "$@"
