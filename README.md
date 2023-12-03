# CompNameChange
Renames a computer to serial name, disables fast boot, and displays reboot required message
THis script was created at a client request to rename computers from their default name (usually DESKTOP-XXXXXXX) to the serial number for the machine. Due to the size of the environment and number of machines affected, a script automating this process was written.
There were multiple issues encountered in this process, namely that of Fast Boot being enabled by default, which caused the name change to not occur.
This iteration of the script (12/3/23) addressed that issue by also disabling fast boot and then requesting a reboot of the PC.
