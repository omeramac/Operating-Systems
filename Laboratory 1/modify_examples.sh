#!/bin/bash

echo "press key to start test process of modify.sh program"

echo "let's start with trying to rename our modify.sh file"
read
echo "./modify.sh -u modify.sh "
./modify.sh -u modify.sh


echo "---------------------------------------"
echo "Now we can start to main testing process"
echo "press key to start creating folders"
read

mkdir -p fol/fol2
touch fol/cat.txt
touch fol/dog.sh
touch fol/DRAGON.sh
touch fol/snake
touch fol/fol2/TIGER.docx
touch fol/fol2/ZEBRA.txt
touch fol/fol2/crocodile.gif
touch fol/fol2/bird.sh

echo "Current files in folders :"
cd fol
echo "fol file"
ls -l
cd fol2
echo "fol2 file"
ls -l
cd

echo "*******************************************************"

echo "upper option will be executed"
read
./modify.sh -u fol/cat.txt fol/fol2/bird.sh fol/dog.sh fol/snake
echo "./modify.sh -u fol/cat.txt fol/fol2/bird.sh fol/dog.sh fol/snake"
echo "*******************************************************"
echo "lower option will be executed"
read
echo "./modify.sh -l fol/DRAGON.sh fol/fol2/ZEBRA.TXT fol/fol2/TIGER.docx"
./modify.sh -l fol/DRAGON.sh fol/fol2/ZEBRA.txt fol/fol2/TIGER.docx
echo "*******************************************************"
echo "Please press a button to see the results"
read

cd fol
echo "fol file"
ls -l
cd fol2
echo "fol2 file"
ls -l
cd

echo "this part is done."
echo "*******************************************************"
echo "-------------------------------------------------------"
echo "*******************************************************"

echo "recursion will be applied now"
echo "press key to start creating folders again"
read

rm -r fol

mkdir -p fol/fol2/fol3
touch fol/cat.txt
touch fol/dog.sh
touch fol/WOLF.xlsx
touch fol/GIRAFFE.txt
touch fol/fol2/TIGER
touch fol/fol2/ZEBRA.txt
touch fol/fol2/crocodile.gif
touch fol/fol2/bird.sh
touch fol/fol2/fol3/cheetah
touch fol/fol2/fol3/goat.txt
touch fol/fol2/fol3/COW.png
touch fol/fol2/fol3/SHEEP.txt

echo "Current files in folders :"
cd fol
echo "fol file"
ls -l
cd fol2
echo "fol2 file"
ls -l
cd fol3
echo "fol3 files"
ls -l
cd

echo "*******************************************************"

echo "upper option with recursion will be executed"
read
./modify.sh -r -u fol/cat.txt fol/fol2 fol/dog.sh
echo "./modify.sh -r -u fol/cat.txt fol/fol2 fol/dog.sh"
echo "*******************************************************"
echo "Please press a button to see the results"
read
cd fol
echo "fol file"
ls -l
cd fol2
echo "fol2 file"
ls -l
cd fol3
echo "fol3 files"
ls -l
cd

echo "*******************************************************"
echo "lower option with recursion will be executed"
read
echo "./modify.sh -r -l fol/WOLF.xlsx fol/GIRAFFE.txt fol/fol2"
./modify.sh -r -l fol/WOLF.xlsx fol/GIRAFFE.txt fol/fol2
echo "*******************************************************"
echo "Please press a button to see the results"
read

cd fol
echo "fol file"
ls -l
cd fol2
echo "fol2 file"
ls -l
cd fol3
echo "fol3 files"
ls -l
cd


echo "this part is done."

echo "*******************************************************"
echo "-------------------------------------------------------"
echo "*******************************************************"

echo "press key to start creating folders again for sed command test"
read

rm -r fol

mkdir -p fol/fol2/fol3
touch fol/good.txt
touch fol/fol2/good.sh
touch fol/fol2/good.png
touch fol/fol2/fol3/good.jpeg

echo "Current files in folders"

cd fol
echo "fol files"
ls -l
cd fol2
echo "fol2 files"
ls -l
cd fol3
echo "fol3 files"
ls -l
cd

echo "*******************************************************"



echo "sed option will be executed. Please press a key"
read
./modify.sh -r 's/good/VeryGood/' fol/good.txt fol/fol2
echo "./modify.sh -r 's/good/VeryGood/' fol/good.txt fol/fol2"

cd fol
echo "fol files"
ls -l
cd fol2
echo "fol2 files"
ls -l
cd fol3
echo "fol3 files"
ls -l
cd

echo "this part is done."

echo "*******************************************************"
echo "-------------------------------------------------------"
echo "*******************************************************"

echo "This part will show help option and wrong syntaxes"
echo "Press a key to create files"
read

rm -r fol

mkdir -p fol/fol2/fol3
touch fol/noon.txt
touch fol/fol2/good.sh
touch fol/fol2/hello.png
touch fol/fol2/fol3/night.jpeg
echo "Current files in folders"

cd fol
echo "fol files"
ls -l
cd fol2
echo "fol2 files"
ls -l
cd fol3
echo "fol3 files"
ls -l
cd

echo "*******************************************************"

echo "*******************************************************"
echo "-------------------------------------------------------"
echo "*******************************************************"

echo "Asking for help"
read

echo "./modify.sh -h"
./modify.sh -h

echo "*******************************************************"
echo "-------------------------------------------------------"
echo "*******************************************************"
echo "Wrong option for command test"
read

echo "./modify.sh -t fol/noon.txt"
./modify.sh -t fol/noon.txt

echo "*******************************************************"
echo "-------------------------------------------------------"
echo "*******************************************************"
echo "Wrong option for recursion test"
read

echo "./modify.sh -y 's/hello/goodbye/' fol/fol2/hello.png"
./modify.sh -y 's/hello/goodbye/' fol/fol2/hello.png

echo "*******************************************************"
echo "-------------------------------------------------------"
echo "*******************************************************"
echo "Non-exist file test"
read

echo "./modify.sh -r -u fol/fol2/fol/3/paris.txt"
./modify.sh -r -u fol/fol2/fol/3/paris.txt


echo "--------------------END OF THE TEST----------------"










