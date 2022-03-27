#!/usr/bin/bash

SRCDIR=https://raw.githubusercontent.com/agavgavi/w22/master/pa3

if [ ! -e backup ]; then
  mkdir backup
fi

cp *.c *.h Makefile backup   # copy all files of importance into backup

curl $SRCDIR/ModelGraphTest.c > ModelGraphTest.c

echo ""
echo ""

rm -f *.o FindComponents

echo "Press Enter To Continue with Graph Unit Results"
read verbose

echo ""
echo ""

gcc -c -std=c17 -Wall -g ModelGraphTest.c Graph.c List.c
gcc -o ModelGraphTest ModelGraphTest.o Graph.o List.o

timeout 6 valgrind --leak-check=full -v ./ModelGraphTest -v > GraphTest-out.txt 2> GraphTest-mem.txt

cat GraphTest-out.txt
cat GraphTest-mem.txt | grep --after-context=8 -E 'SUMMARY|freed'

rm -f *.o ModelListTest* ModelGraphTest* FindComponents garbage GraphTest-mem.txt GraphTest-out.txt pa3-gunit-check.sh

