#!/bin/bash
for BOARDDIR in *u-boot*; do 
BOARD=${BOARDDIR##*u-boot_}
echo "Preparo il database dei sorgenti della board $BOARD"
cd *u-boot_$BOARD
#""> ./$BOARD.files
find . -iname "*.c"    > ./$BOARD.files
find . -iname "*.h"   >> ./$BOARD.files
find . -iname "*.lds"   >> ./$BOARD.files
find . -iname "*.mk"   >> ./$BOARD.files
find . -iname "*Makefile*.*"   >> ./$BOARD.files
find . -iname "*.sh"   >> ./$BOARD.files
find . -iname "*.S"   >> ./$BOARD.files
cscope $BOARD.files -cb
mv cscope.out $BOARD.out
ctags --fields=+i -n -L ./$BOARD.files
mv "tags" $BOARD.tags
cqmakedb -s ./$BOARD.db -c ./$BOARD.out -t ./$BOARD.tags -p
cp $BOARD.db ../
cd ..
done
