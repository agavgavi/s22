#!/usr/bin/bash
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color
SRCDIR=https://raw.githubusercontent.com/agavgavi/w22/master/pa3

if [ ! -e backup ]; then
  mkdir backup
fi

cp *.c *.h Makefile backup   # copy all files of importance into backup


echo ""
echo ""

rm -f *.o FindComponents

make

if [ ! -e FindComponents ] || [ ! -x FindComponents ]; then # exist and executable
  echo ""
  echo -e "${RED}Makefile probably doesn't correctly create Executable!!!${NC}"
  echo ""
else
  echo ""
  echo -e "${GREEN}Makefile probably correctly creates Executable!${NC}"
  echo ""
fi

echo ""
echo ""

make clean

if [ -e FindComponents ] || [ -e *.o ]; then
  echo -e "${RED}WARNING: Makefile didn't successfully clean all files${NC}"
fi

rm -f *.o ModelListTest* ModelGraphTest* FindComponents garbage pa3-make-check.sh

