CC=clang

CFLAGS+=-std=c99 -I/usr/pkg/include \
        -DNCOMPTON -DTWOBWM_PATH=\"${TWOBWM_PATH}\" 

LDFLAGS+=-L/usr/local/lib -lxcb -lxcb-randr -lxcb-keysyms \
	 -lxcb-icccm -lxcb-util -lxcb-ewmh

PREFIX=/usr/local
MANPREFIX=$(PREFIX)/man
TWOBWM_PATH=${PREFIX}/bin/twobwm


all: 
	./prepare_conf.sh
	$(CC) $(CFLAGS) $(LDFLAGS) -o twobwm twobwm.c
#	$(CC) -o twobwm $(CFLAGS) twobwm.c $(LDFLAGS)

install:
	test -d $(DESTDIR)$(PREFIX)/bin || mkdir -p $(DESTDIR)$(PREFIX)/bin
	install -m 755 twobwm $(DESTDIR)$(PREFIX)/bin
	test -d $(DESTDIR)$(MANPREFIX)/man1 || mkdir -p $(DESTDIR)$(MANPREFIX)/man1
	install -m 644 twobwm.man $(DESTDIR)$(MANPREFIX)/man1/twobwm.1

uninstall: deinstall
deinstall:
	$(RM) $(DESTDIR)$(PREFIX)/bin/twobwm
	$(RM) $(DESTDIR)$(MANPREFIX)/man1/twobwm.1

clean:
	rm ./twobwm

