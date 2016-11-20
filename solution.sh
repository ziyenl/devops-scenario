#!/bin/bash
# This script takes an optional argument input:
# the directory of the folder containing the .sql files
# else it will just default to the pwd

directory=${1- `pwd`}
latest=$(find $directory -name '*.sql' -printf '%f\n' | cut -c1-3 | tail -n1)
current_db_version=`mysql -u root -Ne "use tracker_db; select version from versioning"`

# if current db version is greater or equal to latest in folder, just exit script.
if [ "$current_db_version" -ge "$latest" ]
then 
	echo "The database already has the most up-to-date version at $current_db_version."
	exit 1
fi

# loop through list of scripts and apply sql scripts upon db for version greater than current db version.
for file in $(find $directory -name '*.sql')
	do
		file_name="${file##*/}"
		if [ "${file_name:0:3}" -gt "$current_db_version" ]
		then
			echo "Running $file for update ${file_name:0:3}"
			mysql -u root < $file
			mysql -u root -e "use tracker_db; update versioning set version=${file_name:0:3}"
		fi
	done
exit 0
