#!/bin/bash

###################################################
# ram 23mar2015                                   #
#                                                 #
# Script to run as a cronjob several times daily. #
# Collect mood info for doctor.                   #
###################################################

# 03apr2015 - added if statement to create .txt & .log files
# 02apr2015 - fixed what goes into mood.txt
#	    - added code for xterm
# 25mar2015 - fixed nested case
#           - added some echoes
# 23mar2015 - crude skeleton of a mood script

# To run as cronjob make it look like this:
# DISPLAY=:0 xterm -e /home/peabody/scripts/mood/mood.sh

# Set variables N stuff

#if [ "$RUNNING_IN_NEW_XTERM" != t ] ; then
#        RUNNING_IN_NEW_XTERM=t exec xterm -e "$0 $*"
#fi

if [ -f != mood.log ]; then
	touch mood.log| $tee $LOG
fi

if [ -f mood.txt ]; then
	touch mood.txt
fi

#export DISPLAY=:0
LOG=mood.log
#RAM='3523969626'

tee='tee -a'

# Main
set again=yes

echo
echo
echo
echo -e "Hello my Charge. $(date)\n\n" | $tee $LOG
echo >> mood.txt
echo -e " ----------------------------------------------------- " >> mood.txt
date >> mood.txt
echo
echo -e "This is the Main Menu"

while true; do
echo
echo -e "#############"
echo -e "# Main Menu #"
echo -e "#############"
echo 
echo -e "m. Mood"
echo -e "w. Write"
echo -e "q. Quit"
echo
echo -n "Please make a choice: "
read choice
echo

case $choice in
	"M" | "m")
	getMood() {
# Check your mood, only 3 options so far, with a nested case
		echo
		echo -e "####################"
		echo -e "# Whats your mood? #"  | $tee $LOG
		echo -e "####################"
		echo 
			echo -e "1. Elevated, but can work thru it."
			echo -e "2. Elevated and would like to speak with someone." 
			echo 
			echo -e "3. Normal" 
			echo -e "4. Normal, but would like to speak with someone."
			echo -e 
			echo -e "5. Depressed, but I can work thru it."
			echo -e "6. Depressed and would to speak to someone."
			echo -e "7. Depressed and may hurt myself or others."
				read numChoice
				echo
				case $numChoice in
				1)
				#Elevated
					echo "You chose:"
					echo " Elevated, but I can work thru it." >> mood.txt
					echo
					;;
				2)
				# Elevated severe
					echo "You chose:"
					echo " Elevated and would like to speak with someone." >> mood.txt
					curl http://textbelt.com/text -d number=3523969626 -d "message=Dr. Patient Jones, would like some time on the couch." |$tee $LOG
					echo
					;;
				3)
				# Normal
					echo "You chose:"
					echo " Normal" >> mood.txt
					echo
					;;
                                4)
                                # Normal+
					echo "You chose:"
                                        echo " Normal, but would like to speak with someone." >> mood.txt
					curl http://textbelt.com/text -d number=3523969626 -d "message=Dr. Patient Jones, would like some time on the couch." |$tee $LOG
                                        echo
                                        ;;
                                5)
                                # Depressed
					echo "You chose:"
                                        echo " Depressed, but I can work thru it." >> mood.txt
                                        echo
                                        ;;
                                6)
                                # Depressed+
                                        echo "You chose:"
                                        echo " Depressed and would to speak to someone." >> mood.txt
					curl http://textbelt.com/text -d number=3523969626 -d "message=Dr. Patient Jones, would like some time on the couch." |$tee $LOG
                                        echo
                                        ;;
                                7)
                                # Depressed++
                                        echo "You chose:"
                                        echo " Depressed and may hurt myself or others." >> mood.txt
					curl http://textbelt.com/text -d number=3523969626 -d "message=Dr. Patient Jones needs some help, urgently." |$tee $LOG
                                        echo
                                        ;;


				*) 
					echo " Please Try again." | $tee $LOG
					getMood
					;;
			esac
			}
			getMood
			;;
# Write something down
	"W" | "w")
		echo
		echo
		echo -e "Whats on your mind, " 
		echo -e "anything you would like to share:" | $tee $LOG
		echo -e "(ctrl + d, to exit)"
		echo
# take user input and send to mood.log
		echo >> mood.txt
		cat >> mood.txt | $tee $LOG
		echo -e "Thank you for sharing today my Charge" | $tee $LOG
		;;
	"Q" | "q")
		echo
		echo
#		echo -e "Ok, we can learn about this later." #| $tee $LOG
		echo -e "Goodby my Charge." | $tee $LOG
		echo
		echo
		break
		;;
	*)
# Invalid option
		echo Invalid Option
		;;
	esac
done
