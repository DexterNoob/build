dtc="$(pwd)/DragonTC"
gcc64="$(pwd)/gcc64"
gcc="$(pwd)/gcc"

if [ ! -d $dtc ]; then
    git clone --depth=1 https://github.com/TeraaBytee/DragonTC $dtc
fi
if [ ! -d $gcc64 ]; then
    git clone --depth=1https://github.com/noobbeast/aarch64-linux-android-4.9.git -b main $gcc64
fi
if [ ! -d $gcc ]; then
    git clone --depth=1 https://github.com/noobbeast/arm-linux-androideabi-4.9.git -b main $gcc
fi

