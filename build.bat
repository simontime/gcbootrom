@echo off
msdos asm8521 bootrom.asm
msdos link8521 bootrom.obj -o bootrom.pro
msdos hex8521 -p -f bootrom
msdos hex2bin bootrom.hex bootrom.bin
msdos stuff bootrom.bin 4096 255
mkdir out
move /y bootrom.bin out\bootrom.bin