#!/bin/sh

WORD1="^^^"
WORD2="^^"
WORD3="^"

#Filters: 
#Remove punctuations  
#Convert all words to lowercase
#Only single character words are a, i, o
#Words 2+ characters long contain a vowel
tr -c "a-zA-Z" '\n' | tr '[:upper:]' '[:lower:]' |
	grep '[aeiou]*.\{2,\}\|[aio]\{1\}' | while read WORD4
	
do #progressive sets of 4 words
	echo "$WORD1 $WORD2 $WORD3 $WORD4"
	
	WORD1="$WORD2"
	WORD2="$WORD3"
	WORD3="$WORD4"
	
done





