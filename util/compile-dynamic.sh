#!/bin/sh
cd ../src
dmd -defaultlib=libphobos2.so -I../../libarcomage/include/LuaD -I../../libarcomage/src -L-L../../libarcomage/lib -L-larcomage -L-llua -ofclarcomage clarcomage.d
mv clarcomage ../bin/linux-x86_64
