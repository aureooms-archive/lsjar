JFLAGS = -g $(FLAGS)
JC = javac
JDOC = javadoc
LINK = jar cvfm

DISTDIR = dist
OUTPUT_NAME = dist/lsjar.jar
DOCDIR = doc
SRC = java/src
CLASS = class
MANIFEST = MANIFEST.MF
WHICH = /usr/bin/lsjar



DOCSOURCES = $(shell find $(SRC) | grep \\.java$$)
SOURCES = $(shell find $(SRC) | grep \\.java$$ | grep -v package-info\\.java$$)
CLASSES = $(patsubst $(SRC)/%,$(CLASS)/%,$(patsubst %.java,%.class,$(SOURCES)))

REQUIRED_DIRS = $(CLASS) $(DISTDIR) $(DOCDIR) $(CLASS)
_MKDIRS := $(shell for d in $(REQUIRED_DIRS); \
             do                               \
               [ -d $$d ] || mkdir -p $$d;  \
             done)

default: all

all: $(OUTPUT_NAME)
	chmod a+x $(OUTPUT_NAME)

doc: $(DOCSOURCES)
	javadoc $(DOCSOURCES) -d $(DOCDIR)

$(OUTPUT_NAME): $(CLASSES)
	$(LINK) $(OUTPUT_NAME) $(MANIFEST) -C $(CLASS) .

$(CLASS)/%.class: $(SRC)/%.java
	$(JC) $(JFLAGS) $(SOURCES) -d $(CLASS)

clean:
	$(RM) -r $(REQUIRED_DIRS) $(DISTDIR) $(DOCDIR) $(CLASS)




install: all
	ln -s $(CURDIR)/$(OUTPUT_NAME) $(WHICH)

uninstall: clean
	rm $(WHICH)