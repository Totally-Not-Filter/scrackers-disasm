#!/usr/bin/env lua

local clownmd5 = require "tools.lua.clownmd5"

-- Prevent make.lua's calls to os.exit from terminating the program.
local os_exit = os.exit
os.exit = coroutine.yield

-- Make the ROM.
local co = coroutine.create(function() dofile("make.lua") end)
local _, _, abort = assert(coroutine.resume(co))

-- Restore os.exit back to normal.
os.exit = os_exit

if not abort then
	-- Hash the ROM.
	local hash = clownmd5.HashFile("scbuilt.bin")

	-- Verify the hash against known builds.
	print "-------------------------------------------------------------"

	if hash == "\xF9\xD8\x70\x64\xD4\x8D\x99\xEB\xBD\x42\x5E\x83\x34\xDE\x4B\xEB" then
		print "ROM is bit-perfect with Prototype."
	else
		print "ROM is NOT bit-perfect with Prototype!"
	end
end
