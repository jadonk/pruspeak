obj-m += pru_speak.o
KDIR := /lib/modules/$(shell uname -r)/build

all:
	if [ ! -d "$(KDIR)" ]; then apt-get install linux-headers-$(shell uname -r); fi
	make -C $(KDIR) M=$(PWD) modules

botspeak: botspeak_parse.c botspeak.h botspeak_parse.h botspeak_tok.c botspeak_tok.h
	gcc -o botspeak -I. botspeak_parse.c botspeak_tok.c -ll -ly

botspeak_parse.c: botspeak_parse.y
	bison -d botspeak_parse.y

botspeak_tok.c: botspeak_tok.l
	flex botspeak_tok.l

load: pru_speak.ko unload
	insmod ./pru_speak.ko

unload:
	rmmod ./pru_speak.ko || true

install:
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) modules_install

clean:
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) clean
	rm -f botspeak_parse.c botspeak_tok.c botspeak_parse.h botspeak_tok.h botspeak
