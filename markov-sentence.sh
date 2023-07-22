#!/bin/sh

#Call shuffle
SHUF=$(command -v shuf)
if [ ! -x "$SHUF" ]; then
	if [ -x "./shuffle" ]; then
		SHUF="./shuffle"
	else
		echo "No shuffle program!" 1>& 2
		exit -1
	fi
fi

INPUT_FILE="$1" 
CHAIN_LENGTH="$2"

#check if input file exists
if [ -f "$INPUT_FILE" ]; then
	true
else
	echo "$INPUT_FILE doesn't exist!" 
	exit
fi


#check if input file is readable
if [ -r "$INPUT_FILE" ]; then
	true
else
	echo "$INPUT_FILE isn't readable!" 
	exit
fi


#check if target length is > 0
if [ $CHAIN_LENGTH -gt 0 ]; then
	true
else
	echo "Target length isn't greater than 0!"
	exit
fi

LINE=$($SHUF < $INPUT_FILE | head -n 1) #Get random line from input file

for i in $(seq $CHAIN_LENGTH)
do
	SEED=$(echo $LINE | sed "s/^[^ ]* //") #Remove first word 
	
	#Pick a random line with the same first three words 
	FRAGMENTS=$(grep "^$SEED" $INPUT_FILE | $SHUF | head -n 1) 
	echo $FRAGMENTS

	#Get last word of the chosen fragment
	LAST_WORD=$(echo $FRAGMENTS | awk '{print $NF}')
	echo $LAST_WORD
	TOTAL="$TOTAL ""$LAST_WORD"
	
	LINE="$FRAGMENTS"
done

echo $TOTAL



