#!/bin/bash

inpt=$1  #inputs from terminal stored here

#option of recursive mode is stored in optr 
optr= 

#while improving the code check the input
#echo $inpt
# '##' signed comments cretaed while improving the code, for further improvements can be used as control flags

cv=modify
bv=sh

#It is the function for changing to lower case
#takes one input and checks if that file exist or not
#if it exists, seperates extension, path and the name of the file and convert name to lower case
low(){
 ##echo "file name in lower :$1"
 if [ -f "$1" ]; then
 	##echo "file when going in lower $1"
	##echo "filename exists."
	##echo "NAME $(basename "${1%.*}")"
	base=$(basename "${1%.*}")
	##echo "PATH $(dirname "$1")"
	path=$(dirname "$1")
	##echo "Extension is ${1##*.}"
	exten=${1##*.}
	##echo "Compare item $(basename $exten)"
	compare=$(basename $exten)
	
	qw=$(echo "$base.$exten")
	we=$(echo "$cv.$bv")
	
	if [ "$compare" == "$base" ]; then #checking if file has extension or not
		##echo "File has no extension."
		mv "$1" "$path/${base,,}" > /dev/null 2>&1
	else
		if [ "$qw" == "$we" ]; then
			##echo "File has extension."
			echo "same file"
		else
			mv "$1" "$path/${base,,}.$exten" > /dev/null 2>&1
		fi
	fi

 else
        echo "File doesn't exist."	
  


 fi
 }
 
 
#It is the function for changing to upper case
#takes one input and checks if that file exist or not
#if it exists, seperates extension, path and the name of the file and convert name to upper case
up(){
 ##echo "file name in upper : $1"
 if [ -f "$1" ]; then
 	##echo "file when giong in upper $1"
	##echo "filename exists."
	##echo "NAME $(basename "${1%.*}")"
	base=$(basename "${1%.*}")  #seperates the file name
	##echo "PATH $(dirname "$1")"
	path=$(dirname "$1") #seperates the file path
	##echo "Extension is ${1##*.}"
	exten=${1##*.}   #seperates the file extension
	##echo "Compare item $(basename $exten)"
	compare=$(basename $exten) #we store the basename of exten in case of file without extension
	qw=$(echo "$base.$exten")
	we=$(echo "$cv.$bv")
	
	if [ "$compare" == "$base" ]; then #if file has no extension 
		##echo "File has no extension."
		##echo "file full path : $dir/${base^^}.$exten"
		mv "$1" "$path/${base^^}" > /dev/null 2>&1
	else #if file has extension
		if [ "$qw" == "$we" ]; then
			##echo "File has extension."
			echo "same file"
		else
			##echo "File has extension."
			##echo "file full path : $dir/${base^^}.$exten"
			mv "$1" "$path/${base^^}.$exten" > /dev/null 2>&1
		fi
	fi

 else #printed when file doesn't exist
        echo "File doesn't exist."	
  


 fi
}


#help information to display when wrong syntax detected
hlp(){

echo "!!!WRONG SYNTAX!!!"
echo "!!!!SHOULD BE IN BELOW DESCRIBED FORM!!!!"
echo "modify [-r] [-l|-u] <dir/file names...>"
echo "modify [-r] <sed pattern> <dir/file names...>"
echo "modify [-h]"
}

#regular help file with information about the command
hlp1(){

echo "!!!!HELP INFORMATION!!!!"
echo "this program is created for changing file names. It is possible to change file names to upper or lower case."
echo "modify [-r] [-l|-u] <dir/file names...> --> for changing file names with -l, -u options. 
-r can be used for recursive changing. With -r option names of the files in sub folders will change automatically as well"
echo "modify [-r] <sed pattern> <dir/file names...>  --> for changing file name with  sed command"
echo "modify [-h] --> for help"
}




recursion(){
	##echo "optr in recursion $optr"
	##echo "input in recursion $1"
	case "$optr" in
		-u)	
	
			
			if [ -d "$1" ]; then  #checking if input is file or not
			
				for a in "$1"/*;
				do
				##echo "a in for loop $a"
				
					recursion "$a"	
					##up "$a"
				done	
			else    #if input is not file up function called directly
				up "$1"
			fi
			
			;;
		-l)	
			if [ -d "$1" ]; then   #checking if input is file or not
			
				for a in "$1"/*;
				do
				##echo "a in for loop $a"
				
					recursion "$a"	
					##low "$a"
				done	
			else    #if input is not file low function called directly
				low "$1"  
			fi
		
			;;
		*)
			if [ -d "$1" ]; then    #checking if input is file or not
				for a in "$1"/*;
				do
					recursion "$a" #recursion function called in itself because input is file
					##mv "$a" $(echo "$a" | sed "$optr") > /dev/null 2>&1  
				done
			else
				mv "$1" $(echo "$1" | sed "$optr") > /dev/null 2>&1 #sed command is applied to file
			fi
				
	esac			
			




}

case $1 in
	#command with -r option
	-r)
		
		##echo "$1"
		shift
		optr="$1"
		shift
		##echo "$optr"
		##echo "$1"
		for nex in "$@"
		do 
			recursion "$1"		
		
			shift
		done
		;;
	#command without -r option directly applies lowerizing	
	-l)	
		shift
		for nex in "$@"
		do
			low "$1"	
			shift	
		done
		;;
	#command without -r option directly applies upperizing	
	-u)
		shift
		for nex in "$@"
		do
			##echo "$1 is this"
			up "$1"	
			shift	
		done
		;;
	#help function called here
	-h)
		hlp1
		;;
	#In case of wrong syntax other help function called here	
	 *)
		hlp
		
esac
