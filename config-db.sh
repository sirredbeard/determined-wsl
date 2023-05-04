#!/bin/bash
set -x
postgrespw=$(cat .postgrespw)
service postgresql start
psql -c "ALTER USER postgres WITH PASSWORD '$postgrespw';"
createdb determined