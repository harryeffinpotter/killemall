Simple partial-match kill-script for linux. Only have to type part of path/process name to end it, be careful with this absolute power, however.

From discord message where I shared it with some friends, will update description more in future, possibly:

for you linux dudes, made a universal kill script, called killemall, it works great, i literally use it constantly. annoyed at how long a systemd service is taking to stop? well set an alias named K to this script and simply K whatever.py or whatever extension the main script might be, or say its uvicorn workers, K uvicorn, done. Systemd service immediately stopped.

You can use it in scripts and opt for silent output, which its not actually silent, it just doesnt wait for user input, making it ideal for scripts, with the -s flag, when using this flag the script will return an exit code of 0 for success and 1 for error. Very handy script and I've made it stylish as well, probably my most utilized script, hands down, never fails.
```
cd ~
git clone https://github.com/harryeffinpotter/killemall
chmod +x ~/killemall/kill.sh
```
Then add this function to your zshrc or bashrc:

 ```
K(){
 ~/killemall/kill.sh \"$*\"
 }
```
