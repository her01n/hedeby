SITE ?= $(shell ruby site.rb)
PREFIX ?= /usr/local
APPLICATIONS ?= $(PREFIX)/share/applications
BIN ?= $(PREFIX)/bin

test:
	ruby test.rb

install:
	install -D --target-directory=$(SITE) hedeby.rb
	install -D --target-directory=$(BIN) hedeby
	install -D --target-directory=$(APPLICATIONS) hedeby.desktop

uninstall:
	rm -rf $(SITE)/hedeby.rb
	rm -rf $(BIN)/hedeby
	rm -rf $(APPLICATIONS)/hedeby.desktop
