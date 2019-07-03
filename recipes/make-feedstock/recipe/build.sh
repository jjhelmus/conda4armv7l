./configure --prefix=$PREFIX
# bootstrap building make without make
sh build.sh
# make
./make check
./make install
