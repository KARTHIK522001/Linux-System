# LS Project COMMAND Line TEST 

echo -e "**********************************************{ Welcome To Ls Model Test }***********************************************\n"
echo -e ">>TO Start the Test First sign up to to enter the credential \n>>If Alread a user then go for sign in option\n"
echo -e "PRESS:-  1.--> Sign up \n\t 2.--> Sign in \n\t 3.--> Exit\n"
m=1 

function sign_up()
{  m=1
   userarr=(`cat user_name.csv`)
   while [ $m -eq 1 ]
   do      
           read -p "Please Enter The User Name:" usename
           flag=0
	   for i in ${userarr[@]}
	   do 
	       if [ $usename = $i ]
	       then 
	            flag=1
	            break
	       else
                     continue

	       fi

	   done

	   if [ $flag -eq 1 ]
	   then 

	        echo  "Entered Name all ready exist.."

	   else
	         echo $usename >> user_name.csv
                 while [ $m -eq 1 ]
                 do
          	     read -p "Please Enter The Password:" password
                     read -p "Please Enter The conformation password:" confirmpass
                     if [ $password = $confirmpass ]
       	             then 
           	             echo $password >> password.csv  
           	             echo "---------------------------------Sign-up successful----------------------------------"
                             m=0
                     else
                             echo "Password does not match "
                     fi 
                  done
                 

	    fi
           
    done

}


function sign_in()
{   
   userarr=(`cat user_name.csv`)
   passarr=(`cat password.csv`)
   m=1
   while [ $m -eq 1 ]
   do
        read -p "Enter the username:" usename
        flag2=0
        for i in  `seq 0 ${#userarr[@]}`
        do
              if [ $usename = "${userarr[$i]}" ]
              then 
                      flag2=1
                      index=$i
                      break
               else
  
                      continue   
            
                fi
         done
        
         if [ $flag2 -eq  1 ]
         then
                while [ $m -eq 1 ]
                do
                     read -p "Enter the password:" password
                     if [ $password = ${passarr[$index]} ]
                     then 
                           echo "--------------------------------------Sign in successfull--------------------------"
                           while [ $m -eq 1 ]
                           do
                                   echo -e "-->Press 1.-->Take test\n\t 2.-->Exit"
                                   read -p "Enter option:" o
                                   case $o in
                                
                                           "1") Take_test;
                                                 ;;
                                           "2") m=0;
                                                 ;;
                                             *) echo "Enter valid Option.." ;
                                                 ;;
                                   esac
                           done
                     else 
                            echo "Password does not match.."
                     
                     fi
                done
                          

         else

              echo "User name does not exist.."
          
         fi
        
     done
 
}

function Take_test()
{   
    
    for i in `seq 5 5 21`
    do
	head -n $i que.csv | tail -5
        for j in `seq 10 -1 0`
	do
	    echo -en "\r Enter your ans in : $j "
            read  -t 1  option1
	    if [ -n  "$option1" ]
	    then
		 break
	    else
		 option1="t"
            fi
	done
        echo $option1 >> userans.csv  
	echo
    done
    echo "-----------------------------------your score is-------------------------------"
    useransarr=(`cat userans.csv`)
    corransarr=(`cat correctans.csv`)
    count=0
    l=0
    for k in `seq 5 5 21`
    do 
        head -n $k que.csv | tail -5	
        
        if [ ${useransarr[$l]} = ${corransarr[$l]} ]
	then
	     echo 
	     echo "CORRECT ANS ${useransarr[$l]}"
	     echo
	     count=$(($count+1))
	else
	    echo
	    echo "WRONG ANS"
	    echo "CORRECT ANS is ${corransarr[$l]}"
	    echo
        fi
        l=$(($l+1))
 
    done
    echo "Total marks obtained: $count/4"
    echo 
    echo "------------------------------Thank you for attending----------------------------"
    sed -i 'd' userans.csv

}



while [ $m -eq 1 ]
do
	read -p "Enter the option:" option
	case $option in
     
	   "1") sign_up;
	        ;;
	   "2") sign_in;
	        ;;
	   "3") echo "********************************************{ Thank You }**************************************"
	        m=0
	        ;;
	     *) echo "Entered Wrong option Please Enter the right Option"
	        ;;

	esac
done
