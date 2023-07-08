#!/bin/bash

username=$(whoami)
sudo mkdir /etc/.securepass; sudo chown -R $username:$username /etc/.securepass
clear 

# MENU SECTION
echo " "
echo "=========================="
echo "|        PassKey🔒       |"
echo "|1.  Create Database     |"
echo "|2.  Add Entry           |"
echo "|3.  Show All Database   |"
echo "|4.  Show All Entry      |"
echo "|5.  Delete Database     |"
echo "|6.  Delete Entry        |"
echo "|7.  Open Entry          |"
echo "|8.  Edit Entry          |" 
echo "|9.  Backup              |"
echo "|10. Restore             |"
echo "|  . Quit[Press (.)key]  |"
echo "=========================="
echo " "

read -p "Enter:" choice

clear
while :
do

  case $choice in

   1)clear
     echo -e "<<<< Create Database >>>>\n"
     read -p "Enter_Database_Name: " database
     sudo mkdir /etc/.securepass/$database; sudo chown -R  $username:$username /etc/.securepass/$database
     echo " ";;

   2)clear
     databaselist=$(ls /etc/.securepass)
     echo -e "<<<< Add Entry >>>>\n"

     echo "All Databases"
     echo " |"
     echo -e " |_ _ " $databaselist"\n"

     read -p "Set Database: " database
     read -p "Create Entry: " entryname
     sudo touch /etc/.securepass/$database/$entryname; sudo chmod 600 /etc/.securepass/$database/$entryname; sudo chown -R $username:$username /etc/.securepass/$database/$entryname

     # ENTRY DETAILS SECTION
     read -p "Title:" title
     read -p "Username:" username
     read -p "Url:" url


     # PASSWORD GENERATING SECTION

     read -p "Do you Want to Generate password (y/n):" selection
     if [ $selection == "y" ]
     then
      array=()
      for i in {a..z} {A..Z} {0..9} {"!" "@" "#" "$" "_" ")" "(" "/ " "[" "]"};
        do
        array[$RANDOM]=$i
      done
     printf %s ${array[@]::32} $'\n'
     store="${array[@]::32}"
     echo " "
     read -p "Do you Want to Save (y/n):" save
     if [ $save == "y" ]
     then
     storepass=$(echo "$store" | tr -d ' ')
     echo  " "
     else
        echo ""
     fi
     else
      read -p "Enter Password Manually:" password
      printf "Password: $password" >> /etc/.securepass/$database/$entryname
      echo " "
     fi

    # INPUT ALL DETAILS IN THE ENTRY

     echo -e "\nTITLE:    "$title >> /etc/.securepass/$database/$entryname
     echo "USERNAME: "$username >> /etc/.securepass/$database/$entryname
     echo "URL:      "$url >> /etc/.securepass/$database/$entryname
     echo "Password: "$storepass >> /etc/.securepass/$database/$entryname
     echo " ";;

   3)clear
     showdatabase=$(ls /etc/.securepass)
     clear
     echo -e "<<<< Show All Databases >>>>\n"
     echo "Databases"
     echo "   |"
     echo "   |_ _ "$showdatabase
     echo " ";;

   4)clear
     echo -e "<<<< Show All Entries >>>>\n"
     read -p "Set database: " showentry
     echo " "
     checkshowentry="/etc/.securepass/$showentry"
     if [ -d "$checkshowentry" ]
     then
     showentries=$(ls /etc/.securepass/$showentry)
     clear
     echo -e "<<<< Show All Entries >>>>\n"
     echo "Database: "$showentry
     echo "|"
     echo "|_ _ ""Entries: "$showentries
     else
        echo "Database Not Found !! ⛔"
     fi
     echo " ";;

   5)clear
     echo -e "<<<< Delete Database >>>> \n"
     read -p "Enter Database Name: " deldata
     checkdatabase="/etc/.securepass/$deldata"
     if [ -d "$checkdatabase" ]
     then
         echo " "
         echo "Database Found 👌  "    
         rm -r /etc/.securepass/$deldata
         echo "Database delete Successfull .."
     else
         echo " "  
         echo "Database Not found !! ⛔"  
     fi         
     echo " ";;

   6)clear
     echo -e "<<<< Delete Entry >>>> \n"
     read -p "Set Database: " setdatabase
     read -p "Enter Entry Name: " delentry
     checkdentry="/etc/.securepass/$setdatabase/$delentry"
     if [ -e "$checkdentry" ]
     then
         echo " "
         echo "Entry Found 👌  "    
         rm /etc/.securepass/$setdatabase/$delentry
         echo "Entry delete Successfull .."
     else
         echo " "  
         echo "Entry Not found !! ⛔"  
     fi         
     echo " ";;    

   7)clear
     echo -e "<<<< Open Entry >>>>\n"
     read -p "Set database: " opendatabase
     checkdir="/etc/.securepass/$opendatabase"
     if [ -d "$checkdir" ]
     then
       read -p "Entry Name: " openentry
       checkentryfile="/etc/.securepass/$opendatabase/$openentry"
       if [ -e "$checkentryfile" ]
       then
          cat /etc/.securepass/$opendatabase/$openentry
       else
          echo "Entry Not found !! ⛔"
       fi 
     else
        echo "Database Not found !! ⛔" 
     fi
     echo " ";;

   8)clear
     echo -e "<<<< Edit entry >>>>\n"
     read -p "Set Database: " data
     selectdata=$(ls /etc/.securepass/$data)
     echo "|"
     echo "|_ _ "$selectdata
     echo " "
     read -p "Edit Entry: " entry
     nano /etc/.securepass/$data/$entry
     echo " ";;

   9)clear
     echo -e "<<<< Create backups >>>>\n"
     storelocation=$(pwd)
     mkdir $storelocation/passkeyBackup
     clear
     echo -e "<<<< Create backups >>>>\n"
     cp -r /etc/.securepass/*  $storelocation/passkeyBackup
     echo -e "Backup Complete\n"
     echo " ";;

   10)clear
      echo -e "<<<< Restore >>>>\n"
      read -p "Enter Backups File Path:" restorelocation
      checkstore="$restorelocation\passkeyBackup"  
      if [ -d "checkrestore" ]
      then
         cp -r $restorelocation/passkeyBackup/* /etc/.securepass
          echo -e "Restore Complete\n" 
      else
         echo "Wrong Location ⛔"
      fi   
      echo " ";;

   .)clear
     echo "Quit-module"
     echo " "
     exit;;

   *)clear
     echo "Invalid Option..💀"
     echo " ";;

esac

     # MENU SECTION
     echo " "
     echo "=========================="
     echo "|        PassKey🔒       |"
     echo "|1.  Create Database     |"
     echo "|2.  Add Entry           |"
     echo "|3.  Show All Database   |"
     echo "|4.  Show All Entry      |"
     echo "|5.  Delete Database     |"
     echo "|6.  Delete Entry        |"
     echo "|7.  Open Entry          |"
     echo "|8.  Edit Entry          |" 
     echo "|9.  Backup              |"
     echo "|10. Restore             |"
     echo "|  . Quit[Press (.)key]  |"
     echo "========================="
     echo " "
     
     read -p "Enter:" choice

done
