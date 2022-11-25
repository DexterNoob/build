#!/bin/sh

# Defined path
MainPath="$(pwd)"
dexter="$(pwd)/../dexter"
Any="$(pwd)/../AnyKernel3"

# Make flashable zip
MakeZip() {
    if [ ! -d $Any ]; then
        git clone https://github.com/noobbeast/AnyKernel3.git -b master $Any
        cd $Any
    else
        cd $Any
        git reset --hard
        git checkout master
        git fetch origin master
        git reset --hard origin/master
    fi
    cp -af $MainPath/out/arch/arm64/boot/Image.gz-dtb $Any
    sed -i "s/kernel.string=.*/kernel.string=$KERNEL_NAME-$HeadCommit test by $KBUILD_BUILD_USER/g" anykernel.sh
    zip -r9 $MainPath/"$ZIP_KERNEL_VERSION-$KERNEL_NAME-$Compiler-$TIME.zip" * -x .git README.md *placeholder
    cd $MainPath
}

# Defined config
HeadCommit="$(git log --pretty=format:'%h' -1)"
export ARCH="arm64"
export SUBARCH="arm64"
export KBUILD_BUILD_USER="Noobbeast"
export KBUILD_BUILD_HOST="Github-Action"
Defconfig="begonia_user_defconfig"
KERNEL_NAME=$(cat "$MainPath/arch/arm64/configs/$Defconfig" | grep "CONFIG_LOCALVERSION=" | sed 's/CONFIG_LOCALVERSION="-*//g' | sed 's/"*//g' )
ZIP_KERNEL_VERSION="4.14.$(cat "$MainPath/Makefile" | grep "SUBLEVEL =" | sed 's/SUBLEVEL = *//g')$(cat "$(pwd)/Makefile" | grep "EXTRAVERSION =" | sed 's/EXTRAVERSION = *//g')"
TIME=$(date +"%m%d%H%M")

# Start building
Compiler=Clang-R16
MAKE="./makeparallel"
rm -rf out
BUILD_START=$(date +"%s")

make  -j$(nproc --all)  O=out ARCH=arm64 SUBARCH=arm64 $Defconfig
make  -j$(nproc --all)  O=out \
                        PATH="$dexter/bin:/usr/bin:$PATH" \
                        CC=clang \
                        AS=llvm-as \
                        NM=llvm-nm \
                        OBJCOPY=llvm-objcopy \
                        OBJDUMP=llvm-objdump \
                        STRIP=llvm-strip \
                        LD=ld.lld \
                        CROSS_COMPILE=aarch64-linux-gnu- \
                        CROSS_COMPILE_ARM32=arm-linux-gnueabi- \
                        2>&1 | tee out/error.log

if [ -e $MainPath/out/arch/arm64/boot/Image.gz-dtb ]; then
    BUILD_END=$(date +"%s")
    DIFF=$((BUILD_END - BUILD_START))
    MakeZip
    echo "Build success in : $((DIFF / 60)) minute(s) and $((DIFF % 60)) second(s)" > TIME
else
    BUILD_END=$(date +"%s")
    DIFF=$((BUILD_END - BUILD_START))
    echo "Build fail in : $((DIFF / 60)) minute(s) and $((DIFF % 60)) second(s)" > TIME
fi
