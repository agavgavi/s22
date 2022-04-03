#!/usr/bin/bash
TIME=8

SRCDIR=https://raw.githubusercontent.com/agavgavi/s22/master/pa4

if [ ! -e backup ]; then
  mkdir backup
fi

cp *.c *.h Makefile backup   # copy all files of importance into backup

curl $SRCDIR/ModelMatrixTest.c > ModelMatrixTest.c

echo ""
echo ""

rm -f *.o Sparse ModelMatrixTest

echo "Press Enter To Continue with MatrixTest Results"
read verbose

echo ""
echo ""

gcc -c -std=c17 -Wall -g ModelMatrixTest.c Matrix.c List.c
gcc -o ModelMatrixTest ModelMatrixTest.o Matrix.o List.o

timeout $TIME valgrind --leak-check=full ./ModelMatrixTest -v > MatrixTest-out.txt 2> MatrixTest-mem.txt

cat MatrixTest-mem.txt
cat MatrixTest-out.txt

rm -f *.o ModelMatrixTest* garbage MatrixTest-mem.txt MatrixTest-out.txt

