CC = gcc
CFLAGS = -mconsole
LIBS = -lm

# Archivos fuente
FLEX_SRC = calc.l
BISON_SRC = calc.y
HEADER = calc.h

# Archivos generados
FLEX_OUT = lex.yy.c
BISON_OUT = calc.tab.c calc.tab.h

# Ejecutable final
TARGET = calc

all: $(TARGET)

$(TARGET): $(FLEX_OUT) $(BISON_OUT) $(HEADER)
	$(CC) $(CFLAGS) $(FLEX_OUT) $(BISON_OUT) -o $(TARGET) $(LIBS)

$(FLEX_OUT): $(FLEX_SRC) $(BISON_OUT)
	flex $(FLEX_SRC)

$(BISON_OUT): $(BISON_SRC)
	bison -d $(BISON_SRC)

clean:
	rm -f $(FLEX_OUT) $(BISON_OUT) $(TARGET)

.PHONY: all clean