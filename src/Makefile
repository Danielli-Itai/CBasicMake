#******************************************************************************
# Copyright (C) 2017 by Alex Fosdick - University of Colorado
#
# Redistribution, modification or use of this software in source or binary
# forms is permitted as long as the files maintain this copyright. Users are 
# permitted to modify this and use it to learn about the field of embedded
# software. Alex Fosdick and the University of Colorado are not liable for any
# misuse of this material. 
#
#*****************************************************************************

#------------------------------------------------------------------------------
# <Put a Description Here>
#
# Use: make [TARGET] [PLATFORM-OVERRIDES]
#
# Build Targets:
#      <Put a description of the supported targets here>
#
# Platform Overrides:
#      <Put a description of the supported Overrides here
#
#------------------------------------------------------------------------------
include sources.mk





#Target name executable.
TARGET = ./c1m2.out
MAP_FILE = map.map




#Macros to compile with. 
MACROS = $(PLATFORM)
INC_MACROS = $(foreach d, $(MACROS), -D$d)

#include directories.
INC_PARAMS = $(foreach d, $(INCLUDES), -I$d)

# Output files.
OBJ_FILES = $(SOURCES:%.c=%.o)
CPP_FILES = $(SOURCES:%.c=%.i)
ASM_FILES = $(CPP_FILES:%.i=%.asm)





# Compilation.
ifeq ($(PLATFORM), MSP432)
	CC = arm-none-eabi-gcc
	PLATFORM_FLAGS = -mcpu=cortex-m4 -mthumb -march=armv7e-m -mfloat-abi=hard -mfpu=fpv4-sp-d16 --specs=nosys.specs
else
	CC = gcc
endif
CFLAGS = -c -g -std=c99 -Wall -Werror -O0





#linker
ifeq ($(PLATFORM), MSP432)
	LINKER_FILE = ../msp432p401r.lds
	LNK_PARAMS = -T$(LINKER_FILE) -Map=$(MAP_FILE)
else
	LNK_PARAMS = -Map=$(MAP_FILE)
endif
LDFLAGS = $(foreach d, $(LNK_PARAMS), -Wl,$d)










#-----------------------------------------------#
#	 		Makefile Make Executable			#
#-----------------------------------------------#
# use phoney to set my own target file name.
.PHONY: build
.SUFFIXES: .c


# Build rules begin.
compile-all: $(CPP_FILES) $(ASM_FILES)

build: $(SOURCES) $(TARGET)




	
#Main target executable: requires object files for generating output.
$(TARGET): $(CPP_FILES) $(ASM_FILES) $(OBJ_FILES)
	$(CC) $(LDFLAGS) $(LINK_LIBS)  $(PLATFORM_FLAGS) $(OBJ_FILES) -o $@ 


#Compilation rule for generating preprocessor files.
%.i: %.c
	$(CC) $(CFLAGS) $(INC_MACROS) $(INC_PARAMS) $(PLATFORM_FLAGS) -E $< -o $@

##Compilation rule for generating assembly files.
%.asm: %.i
	$(CC) $(CFLAGS) $(INC_MACROS) $(INC_PARAMS) $(PLATFORM_FLAGS) -S $< -o $@


#Compilation rule for each source to object.
%.o: %.c
	$(CC) $(CFLAGS) $(INC_MACROS) $(INC_PARAMS) $(PLATFORM_FLAGS) $< -o $@

 
#Cleanup object files target and Make file backup.
clean:
	@echo 'Cleanning'
	rm -f $(CPP_FILES) $(ASM_FILES) $(OBJ_FILES) $(TARGET) $(MAP_FILE) Makefile.bak



