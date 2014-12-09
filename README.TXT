CLArcomage 1.alpha
Revision 2014.12.07, GreatEmerald

The command line frontend to libarcomage, the tower-based card game. The 
frontend is extremely simple: it does not require any graphical server to be 
installed, and it's merely around 150 lines of code. It can be used as a basis 
for new frontends or as a debugging tool to see if the bug is in the frontend or 
the backend.


========
BUILDING
========

On Linux, there is a Makefile provided. Make sure to have DMD, LuaD and 
libarcomage installed, then do:

cd src
make prefix=/usr
make install

If your distribution doesn't have LuaD and libarcomage packaged, or if you're on 
Windows, there are compilation scripts in the util directory. However, you need 
to make sure you have the libarcomage repository snaphot in the same directory 
as the CLArcomage repository snapshot, and that its submodules are initialised:

cd ../libarcomage
git submodule update --init

Then from the CLArcomage directory again, on Linux:

cd util
compile-static.sh

Or on Windows (put OMF lua51.lib and lua5.1.lib in the src folder first):

cd util
compile.cmd
