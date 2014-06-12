tf2-install-script
==================

Install script for TF2/CS:GO




1. Run the script, it will prompt you to enter the name of the server (this is used for screen name and directory name)

2. Enter the game type, either CS:GO or TF2

3. Enter the name

4. Enter the server port

5. Enter the server rcon password

6. It will go through a lengthy process (usually 15-20 minutes depending on how steamcmd acts) to install the server

7. Navigate into the directory it created

8. As it said, there will be 3 shell scripts:
  1. ./run.sh - starts the server
  2. ./end.sh - stops the server
  3. ./update.sh - updates the server (make sure you stop it first)


KNOWN ISSUES:
Game types need to be in all caps
CS:GO Doesn't work due to some bug or another.
