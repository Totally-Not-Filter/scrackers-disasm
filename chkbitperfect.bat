@echo off
call tool/md5 scbuilt.bin md5
if "%md5%" equ "f9d87064d48d99ebbd425e8334de4beb" (
	echo MD5 identical!
) else (
	echo MD5 does not match.
)
pause