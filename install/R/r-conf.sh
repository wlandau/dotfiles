./configure --enable-R-shlib --with-cairo --enable-memory-profiling --without-recommended-packages
sed -i -e 's/^[[1;35;40m^[[//g' src/include/Rconfig.h; rm src/include/Rconfig.h-e
sed -i -e 's/^[[m^[[K//g' src/include/Rconfig.h; rm src/include/Rconfig.h-e
