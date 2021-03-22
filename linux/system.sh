 ---
#!/bin/bash


#2020/12/24 MHills Start of Monash Cyber HW5 Scripting
# INSTRUCTIONS: Edit the following placeholder command and output filepaths
# For example: cpu_usage_tool > ~/backups/cpuuse/cpu_usage.txt
# The cpu_usage_tool is the command and ~/backups/cpuuse/cpu_usage.txt is the filepath
# In the above example, the `cpu_usage_tool` command will output CPU usage information into a `cpu_usage.txt` file.
# Do not forget to use the -h option for free memory, disk usage, and free disk space

# 2020/12/24 MHills
# This command below in this script will execute various Linux tools to parse information about the system.
# Each tools will output results to a text file, inside its respective system information directory.
# Please Note: Each file is overwritten, every time this script is run.


# 2020/12/24 MHills
# Prints the amount of free memory on the system and saves it to `~/backups/freemem/free_mem.txt`

free -h | awk 'NR==1{print $3}NR==2{print $1,$4}' > ~/backups/freemem/free_mem.txt

# Note:
# command
# 	free -h > ~/backups/freemem/free_mem.txt
# writes the following output to free_mem.txt file
# 
#              total        used        free      shared  buff/cache   available
# Mem:           3.9G        1.1G        1.5G         31M        1.2G        2.5G
# Swap:          1.9G          0B        1.9G
#
# We are only interested in the amount of free memory on the system.
# by piping | awk 'NR==1{print $3}NR==2{print $1,$4}' > ~/backups/freemem/free_mem.txt
#
# the following output will be written to free_mem.txt file.
#  
#      free
#      Mem: 1.5GM
# 
# Command options used
# NR==1{print $3}  first line, 3rd word
# NR==2{print $1,$4} second line, first word & 4th word 
#


# 2020/12/24 MHills
# Prints disk usage and saves it to `~/backups/diskuse/disk_usage.txt`.
du / -ha --total | sort -hr | awk {print} > ~/backups/diskuse/disk_usage.txt

# Command options used
# -h  -print sizes in powers of 1024 (e.g., 1023M)
# -a  -include pseudo, duplicate, inaccessible file systems
# --total  -elide all entries insignificant to available space, and produce a grand total#
# sort
#    -h -compare human readable numbers (e.g., 2K 1G)
#    -r -reverse the result of comparisons
#
# Note: there is a lot of data in this file.  please use | less when viewing
# the output is also sorted by file size highest to lowest



# 2020/12/24 MHills
# Lists all open files and saves it to `~/backups/openlist/open_list.txt

lsof > ~/backups/openlist/open_list.txt

# Note: there is a lot of data in this file.  please use | less when viewing 
# the output is also sorted by PID/TID/USER  lowest to highest
#


# 2020/12/24 MHills
# Prints file system disk space statistics and saves it to `~/backups/freedisk/free_disk.txt

df -ha --output --total > ~/backups/freedisk/free_disk.txt

# Command options used
# -h  -print sizes in powers of 1024 (e.g., 1023M)
# -a  -include pseudo, duplicate, inaccessible file systems
# --output -use the output format defined by FIELD_LIST, or print all fields if FIELD_LIST is omitted.
# --total  -elide all entries insignificant to available space, and produce a grand total
#
#2020/12/24 MHills End of Monash Cyber HW5 scripting
#
 ---