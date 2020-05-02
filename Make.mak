#-----------------------------------------------#
#	 Makefile for Slam2Common library			#
#-----------------------------------------------#
CC = CC=arm-linux-gnueabihf-gcc make -g -Werror -std=c99

GCC_ROOT = /c/ti/msp432_gcc/arm

#include directories.
INC = $(GCC_ROOT)/include
INC_PARAMS=$(foreach d, $(INC), -I$d)

#Create objets list from all .cpp files in current directory.
SC1 = $(shell find "./src"	-name "*.c")
SOURCES = $(SC1)

# obj files.
OBJECTS=$(SOURCES:%.c=%.o)

LINK_LIBS = libheymath.a

#Compilation only ignore warnings (ignore/-w, show all/-Wall).
CFLAGS = -c -o -w

#Target name executable.
TARGET = MathDemo





#-----------------------------------------------#
#	 		Print Make Parameters				#
#-----------------------------------------------#
print:
	@echo $* = $($*)
	@echo "SOURCES=$(SOURCES)\n"
	@echo "OBJECTS=$(OBJECTS)\n"
	@echo "INC_PARAMS=$(INC_PARAMS)\n"





#-----------------------------------------------#
#	 		Makefile Make Executable			#
#-----------------------------------------------#
.SUFFIXES: .c


#Build rules begin.
all: $(SOURCES) $(TARGET)

	
#Compilation rule for each target.
$(TARGET): $(OBJECTS)
	$(CC) $(LDFLAGS) $(OBJECTS) $(LINK_LIBS) -o $@

#Compilation rule for each object.
.cpp.o:
	$(CC) $(CFLAGS) $(INC_PARAMS) $< -o $@
 
#Cleanup object files target and Make file backup.
clean:
	rm -f $(OBJECTS) $(TARGET) Makefile.bak
