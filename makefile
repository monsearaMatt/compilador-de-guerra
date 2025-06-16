# Makefile para compilar WARCODE

# Compilador
CC = gcc

# Flags para compilación
CFLAGS = -Wall -g

# Archivos fuente generados por Bison y Flex
BISON_SRC = warcode.y
FLEX_SRC = warcode.l

BISON_OUT_C = warcode.tab.c
BISON_OUT_H = warcode.tab.h
FLEX_OUT_C = lex.yy.c

TARGET = warcode.exe

.PHONY: all clean

all: $(TARGET)

$(BISON_OUT_C) $(BISON_OUT_H): $(BISON_SRC)
	bison -d $(BISON_SRC)

$(FLEX_OUT_C): $(FLEX_SRC) $(BISON_OUT_H)
	flex $(FLEX_SRC)

$(TARGET): $(BISON_OUT_C) $(FLEX_OUT_C)
	$(CC) $(CFLAGS) $(BISON_OUT_C) $(FLEX_OUT_C) -o $(TARGET) -lm

clean:
	rm -f $(BISON_OUT_C) $(BISON_OUT_H) $(FLEX_OUT_C) $(TARGET)
