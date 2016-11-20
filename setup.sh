#!/bin/sh
# This script executes an initial database creation and setup script
# to create a table to contain the versioning metadata

echo "Setting up intial versioning metadata"
mysql -u root < create.sql
