#!/bin/bash
# For quickest usability I suggest adding this function to your "~/.zshrc" or "~/.bashrc" file:

# K(){
# ~/killemall/killemall.sh \"$*\"
# }
# This way during time sensitive scenarios you can simply just do K "rogueapplication.py".

# You can also use kill.sh in your scripts, utilze the "-s" argument to have it kill silently.
# Error codes:
# 0 = Success
# 1 = No processes found.
# 2 = Othe


DIR="$( dirname -- "${BASH_SOURCE[0]}"; )";   # Get the directory name
DIR="$( realpath -e -- "$DIR"; )";  # Resolve its full path
source $DIR/colors
NEWLINE='
'
commands=''
IFS="$NEWLINE"

appkill(){
        result=1
        clear
        procs="$(pgrep -f "$process_to_kill")" 2>/dev/null
        commands=''
        for proc in $procs; do
                commandname="$proc: $(ps -p "$proc" -o command | sed -n '2 p')"

                if [[ "$commandname" != *"kill.sh"* ]]; then
                        sudo kill -9 "$proc" 2>/dev/null
                        result="$?"
                        commands="$commandname$NEWLINE$commands"
                fi
        done
        if [[ $result == 0 ]]; then
                echo -e "\n===================\nProcess(es) killed:\n==================="
                printf "%s\n" "$commands"
                commands=''
        else
                echo -e "** ! ${Red}ERROR${Color_Off} ! **\nNo processes containing ${Cyan}'$process_to_kill'${Color_Off} found.\n"
        fi
}
clear
if [[ $# -eq 0 ]]; then
echo -e "${Red}====${Yellow}====${Green}====${Cyan}====${Blue}====${Purple}====\n= ${On_Red}${Red}KILL 'EM ALL${Color_Off}${Green} by ${Cyan}H${Red}F${Green}P${Color_Off} ${BIPurple} =\n${BIPurple}====${BIBlue}====${BICyan}====${BIGreen}====${BIYellow}====${BIRed}====\n${Color_Off}"
sleep 1.5
clear
if test -f _dontwarn; then
  clear
else
echo -e "${Cyan}***** ${Yellow}${Red}WARNING${Yellow}! ${Cyan}*****${Color_Off}"
sleep 1
echo -e "This script uses ${Green}sudo${Color_Off} & fuzzy matching."
sleep 1.8
echo -e "That means entering something like ${Green}.sh${Color_Off} will ${Red}kill${Color_Off} every script on your system."
sleep 3.3
echo -e "${Cyan}* ${Red}USE WITH CAUTION${Cyan} *${Color_Off}\n\n"
sleep 1
echo -e "${Green}Do you accept these risks?${Yellow}[Y/N]${Color_Off}"
echo "Entering Y will stop this warning from showing."
read -r acceptrisks
if [[ "$acceptrisks" == "y" || "$acceptrisks" == "Y" ]]; then
    touch _dontwarn
fi
clear
fi
fi
moar=1
if [ -n "$2" ]; then
        sneaky_assassin_mode=0
        if [[ "$1" == "-s" ]]; then
                process_to_kill="$2"
                sneaky_assassin_mode=1
        elif [[ "$2" == "-s" ]]; then
                process_to_kill="$1"
                sneaky_assassin_mode=1
	fi
        appkill
        if [[ "$sneaky_assassin_mode" == 1 ]]; then
                exit 0
        fi
elif [[ $# -gt 0 ]]; then
    process_to_kill=$*
    appkill
fi

while [ $moar != 0 ]; do
        echo -e "Enter part of app name you want to ${Red}kill ${Color_Off}(${Green}q${Color_Off}/${Green}ctrl+c${Color_Off}: ${Cyan}exit${Color_Off}):"
        read -r process_to_kill
        if [ -n "$process_to_kill" ]; then

                if [[ "$process_to_kill" == "Q" || "$process_to_kill" == "q" ]]; then
                        echo -e "\nExiting script...\n"
                        sleep 1
                        exit 0
                fi
                appkill
        else
                echo -e  "Please enter a valid app name..\n"
                continue
        fi
done
