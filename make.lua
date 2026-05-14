#!/usr/bin/env lua

local common = require "tools.lua.common"

-- Build the ROM.
common.build_rom_and_handle_failure("main", "scbuilt", "", "-p=FF -z=0," .. "uncompressed" .. ",Size_of_Snd_driver_guess,after", false, "https://github.com/sonicretro/s1disasm")

-- A successful build; we can quit now.
common.exit()
