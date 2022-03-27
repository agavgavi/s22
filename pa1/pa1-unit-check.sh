#!/usr/bin/bash

SRCDIR=https://raw.githubusercontent.com/agavgavi/w22/master/pa1
NUMTESTS=3
PNTSPERTEST=5
let MAXPTS=$NUMTESTS*$PNTSPERTEST

if [ ! -e backup ]; then
   echo "WARNING: a backup has been created for you in the \"backup\" folder"
   mkdir backup
fi


cp *.c *.h Makefile backup   # copy all files of importance into backup

curl $SRCDIR/ModelListTest.c > ModelListTest.c

echo ""
echo ""

echo "Press Enter To Continue with ListTest Results"
read verbose

echo ""
echo ""

gcc -c -std=c17 -Wall -g ModelListTest.c List.c
gcc -o ModelListTest ModelListTest.o List.o

timeout 5 valgrind --leak-check=full -v ./ModelListTest -v > ListTest-out.txt 2> MemoryCheck.txt

cat ListTest-out.txt
cat MemoryCheck.txt | grep --after-context=8 -E 'SUMMARY|freed'

rm -f *.o ModelListTest* Lex

