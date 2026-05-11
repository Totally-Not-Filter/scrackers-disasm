@echo off
IF EXIST scbuilt.bin move /Y scbuilt.bin scbuilt.prev.bin >NUL
tool\windows\asw -xx -q -A -L -U -E -i . main.asm
tool\windows\p2bin -p=FF -z=0,uncompressed,Size_of_Snd_driver_guess,after main.p scbuilt.bin
del main.p