# Devops Scenario
Please go through the described scenario and write a script, possibly in Unix BASH, implementing a fix to the issue below. 

## Use Case:
- A database upgrade requires the execution of numbered scripts stored in a folder. E.g. 045.createtable.sql
- There may be holes in the numbering and there isn&#39;t always a. after the number.
- The database upgrade works by looking up the current version in the database. It then compares this number to the scripts.
- If the version number from the db matches the highest number from the script then nothing is executed.
- If the number from the db is lower than the highest number from the scripts, then all scripts that contain a higher number than the db will be executed against the database.
- In addition the database version table is updated after the install with the latest number.

## Tools:
- CentOS Linux release 7.2.1511 (Core)
- mysql Ver 14.14 Distrib 5.6.34

## Setup:
Prior to executing solution.sh, a database containing the versioning needs to be set up. The script for setup can be found at [setup.sh](https://github.com/ziyenl/devops-scenario/blob/master/setup.sh)
```bash
./setup.sh
```

## Proposed Solution:
The solution for the devops scenario can be found at [solution.sh](https://github.com/ziyenl/devops-scenario/blob/master/solution.sh)
```bash
./solution.sh sql_scripts
```
Output of successful scripts execution:
![alt text](https://github.com/ziyenl/devops-scenario/blob/master/images/successful_output.png "Successful output")

## Error Handling:
Error handling is in place to prevent further execution of other sql files if there are errors encountered in one of the sql file.
```bash
if mysql -u root < $file
then 
  echo "Successfully executed $file"
	mysql -u root -e "use tracker_db; update versioning set version=${file_name:0:3}"
else
	echo "An error occured while executing $file"
	exit 1
fi
```
Output of failed scripts execution:

![alt text](https://github.com/ziyenl/devops-scenario/blob/master/images/fail_output.png "Failed output")

## Future  Improvement:
There could be future scenario where the incremental name of the .sql might exceed the 3-digit threshold. Improvement to the script is needed to cater for the future occurence of that scenario.
