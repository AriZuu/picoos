#
# Copyright (c) 2019, Ari Suutari <ari@stonepile.fi>.
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
#
#  1. Redistributions of source code must retain the above copyright
#     notice, this list of conditions and the following disclaimer.
#  2. Redistributions in binary form must reproduce the above copyright
#     notice, this list of conditions and the following disclaimer in the
#     documentation and/or other materials provided with the distribution.
#  3. The name of the author may not be used to endorse or promote
#     products derived from this software without specific prior written
#     permission.
#
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS
# OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT,
# INDIRECT,  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
# HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
# STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
# OF THE POSSIBILITY OF SUCH DAMAGE.

set(CMAKE_SYSTEM_PROCESSOR MSP430)

# which compilers to use for C and C++

set(CMAKE_C_COMPILER msp430-elf-gcc)
set(CMAKE_CXX_COMPILER msp430-elf-g++)
set(CMAKE_ASM_COMPILER msp430-elf-gcc)
set(CMAKE_OBJCOPY msp430-elf-objcopy)
set(CMAKE_OBJDUMP msp430-elf-objdump)

set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

# search settings

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE NEVER)

# find additional toolchain executables

find_program(MSP430_SIZE_EXECUTABLE msp430-elf-size)
find_program(MSP430_OBJCOPY_EXECUTABLE msp430-elf-objcopy)
find_program(MSP430_OBJDUMP_EXECUTABLE msp430-elf-objdump)

# MCU setting

set(CMAKE_C_FLAGS_INIT "-mmcu=${MCU}")
set(CMAKE_ASM_FLAGS_INIT "-mmcu=${MCU}")

# Common GNU settings for all ports

include(ToolchainGNU-Common)

# Linker settings to create image.

string(APPEND CMAKE_EXE_LINKER_FLAGS_INIT " -Wl,-Map,${PROJECT_NAME}.map,")
string(APPEND CMAKE_EXE_LINKER_FLAGS_INIT "--cref")

# TI gcc doesn't know where it's own includes are located :-)

get_filename_component(TI_TOOLCHAIN_BIN ${MSP430_OBJDUMP_EXECUTABLE} DIRECTORY)
get_filename_component(TI_TOOLCHAIN ${TI_TOOLCHAIN_BIN} DIRECTORY)
string(APPEND CMAKE_C_FLAGS_INIT " -I${TI_TOOLCHAIN}/include")
string(APPEND CMAKE_EXE_LINKER_FLAGS_INIT " -L${TI_TOOLCHAIN}/include")
