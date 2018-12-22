mkdir ~/R
cd ~/R
wget https://cran.r-project.org/src/base/R-3/R-3.5.2.tar.gz
tar -xf R-3.5.2.tar.gz
rm R-3.5.2.tar.gz
cd R-3.5.2
./configure --enable-R-shlib
make -j8
