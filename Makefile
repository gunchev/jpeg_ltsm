# jpeg_ltsm Makefile

NAME    := jpeg_ltsm
VER     := 0.9.1
SOURCES := LICENSE ChangeLog INSTALL jpeg_ltsm.desktop jpeg_ltsm.sh jpeg_ltsm.spec Makefile README \
jpeg_ltsm_action.gif jpeg_ltsm_menu.png jpeg_ltsm_submenu.png

LOCAL_PREFIX    := $(shell kde4-config --localprefix)
LOCAL_PREFIX    := $(abspath $(LOCAL_PREFIX))
SYSTEM_PREFIX   := $(shell kde4-config --prefix)
SYSTEM_PREFIX   := $(abspath $(SYSTEM_PREFIX))

LOCAL_LIBEXEC   := $(shell kde4-config --path exe | sed 's/:/\n/g' | grep "^$(LOCAL_PREFIX)" | grep libexec | head -n 1)
LOCAL_LIBEXEC   := $(abspath $(LOCAL_LIBEXEC))
SYSTEM_LIBEXEC  := $(shell kde4-config --path exe | sed 's/:/\n/g' | grep "^$(SYSTEM_PREFIX)" | grep libexec | head -n 1)
SYSTEM_LIBEXEC  := $(abspath $(SYSTEM_LIBEXEC))

LOCAL_SERVICES  := $(shell kde4-config --path services | sed 's/:/\n/g' | grep "^$(LOCAL_PREFIX)" | head -n 1)
LOCAL_SERVICES  := $(abspath $(LOCAL_SERVICES))
SYSTEM_SERVICES := $(shell kde4-config --path services | sed 's/:/\n/g' | grep "^$(SYSTEM_PREFIX)" | head -n 1)
SYSTEM_SERVICES := $(abspath $(SYSTEM_SERVICES))

LOCAL_DOC       := $(LOCAL_PREFIX)/share/doc
SYSTEM_DOC      := $(SYSTEM_PREFIX)/share/doc


all: README.html INSTALL.html
# pngcrush -brute_force *.png
# gifsicle -O2 < raw.gif > opt.gif


.PHONY: print-paths
print-paths:
	@echo "Destination directory  : $(DESTDIR)"
	@echo "Local prefix is        : $(LOCAL_PREFIX)"
	@echo "System prefix          : $(SYSTEM_PREFIX)"
	@echo "Local libexec prefix   : $(LOCAL_LIBEXEC)"
	@echo "System libexec prefix  : $(SYSTEM_LIBEXEC)"
	@echo "Local services prefix  : $(LOCAL_SERVICES)"
	@echo "System services prefix : $(SYSTEM_SERVICES)"
	@echo "Local documents prefix : $(LOCAL_DOC)"
	@echo "System documents prefix: $(SYSTEM_DOC)"


README.html: README
	@rst2html $< > $@


INSTALL.html: INSTALL
	@rst2html $< > $@


dist: $(SOURCES)
	-rm -rf $(NAME)-$(VER)
	-rm -f $(NAME)-$(VER).tar.bz2
	mkdir $(NAME)-$(VER)
	cp -a $(SOURCES) $(NAME)-$(VER)/
	tar -cjf $(NAME)-$(VER).tar.bz2 $(NAME)-$(VER)
	-rm -rf $(NAME)-$(VER)


rpm: dist
	rpmbuild -tb $(NAME)-$(VER).tar.bz2


.PHONY: localinstall
localinstall: all
	@echo "Local libexec prefix: $(LOCAL_LIBEXEC)"
	@echo "Local services prefix: $(LOCAL_SERVICES)"
	mkdir -p -- "$(LOCAL_LIBEXEC)"
	mkdir -p -- "$(LOCAL_SERVICES)"
	cp -a -- jpeg_ltsm.sh "$(LOCAL_LIBEXEC)/"
	# cp -a -- jpeg_ltsm.desktop "$(LOCAL_SERVICES)/"
	cat jpeg_ltsm.desktop | sed 's#^Exec=jpeg_ltsm.sh#Exec=$(LOCAL_LIBEXEC)/jpeg_ltsm.sh#g' > "$(LOCAL_SERVICES)/jpeg_ltsm.desktop"
	touch --reference=jpeg_ltsm.desktop "$(LOCAL_SERVICES)/jpeg_ltsm.desktop"


.PHONY: localuninstall
localuninstall:
	-rm -f -- "$(LOCAL_LIBEXEC)/jpeg_ltsm.sh"
	-rm -f -- "$(LOCAL_SERVICES)/jpeg_ltsm.desktop"


.PHONY: install
install: all
	@echo "Destination directory : $(DESTDIR)"
	@echo "System libexec prefix : $(SYSTEM_LIBEXEC)"
	@echo "System services prefix: $(SYSTEM_SERVICES)"
	mkdir -p -- "$(DESTDIR)$(SYSTEM_LIBEXEC)"
	mkdir -p -- "$(DESTDIR)$(SYSTEM_SERVICES)"
	cp -a -- jpeg_ltsm.sh "$(DESTDIR)$(SYSTEM_LIBEXEC)/"
	# cp -a -- jpeg_ltsm.desktop "$(DESTDIR)$(SYSTEM_SERVICES)/"
	cat jpeg_ltsm.desktop | sed 's#^Exec=jpeg_ltsm.sh#Exec=$(SYSTEM_LIBEXEC)/jpeg_ltsm.sh#g' > "$(DESTDIR)$(SYSTEM_SERVICES)/jpeg_ltsm.desktop"
	touch --reference=jpeg_ltsm.desktop "$(DESTDIR)$(SYSTEM_SERVICES)/jpeg_ltsm.desktop"


.PHONY: uninstall
uninstall:
	@echo "Destination directory : $(DESTDIR)"
	@echo "System libexec prefix : $(SYSTEM_LIBEXEC)"
	@echo "System services prefix: $(SYSTEM_SERVICES)"
	-rm -f -- "$(DESTDIR)$(SYSTEM_LIBEXEC)/jpeg_ltsm.sh"
	-rm -f -- "$(DESTDIR)$(SYSTEM_SERVICES)/jpeg_ltsm.desktop"


.PHONY: clean
clean:
	-rm -f README.html INSTALL.html jpeg_ltsm-*.tar.bz2
