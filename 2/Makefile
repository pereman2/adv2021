
CFLAGS=-g -Wall
CXX=gcc


all:
	$(CXX) $(CFLAGS) xd.c

run-asm-1:
	nasm -felf64 -F dwarf -g test.asm && ld test.o && ./a.out
run-asm-2:
# because of printf
	nasm -felf64 -F dwarf -g test.asm && gcc -m64 test.o && ./a.out

run:
	./a.out

debug:
	gdb ./a.out
