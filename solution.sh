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

# loop through list of scripts and apply sql scripts with version greater than current db version upon db.
for file in $(find $directory -name '*.sql')
	do
		file_name="${file##*/}"
		if [ "${file_name:0:3}" -gt "$current_db_version" ]
		then
			echo "Running $file for update ${file_name:0:3}"
			# proceed to modify version in versioning table if the sql statements in a given sql file has been executed successfully
			if mysql -u root < $file
			then 
				echo "Successfully executed $file"
				mysql -u root -e "use tracker_db; update versioning set version=${file_name:0:3}"
			else
				echo "An error occured while executing $file"
				exit 1
			fi
		fi
	done
exit 0
