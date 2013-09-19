########
# Detect OS: Mac or Linux (Debian)
#######
SYS=$(shell uname -s)
ifeq ($(SYS),Darwin)
XSL_BASE=/usr/local/Cellar/docbook-xsl/1.78.1/docbook-xsl-ns/
else
XSL_BASE=/usr/share/xml/docbook/stylesheet/docbook-xsl-ns/
endif

SUBDIRS = sequence_diagrams books

.PHONY: all gendoc subdirs $(SUBDIRS) clean gh-pages

all: clean xhtml xhtml5 html_chunked pdf gendoc subdirs

xhtml5:
	mkdir -p output/xhtml5
	xsltproc --xinclude -o output/xhtml5/main.xhtml $(XSL_BASE)xhtml5/docbook.xsl books/notification_server.xml

xhtml5_chunked:
	mkdir -p output/xhtml5_chunked
	xsltproc --xinclude -o output/xhtml5_chunked/ $(XSL_BASE)xhtml5/chunk.xsl books/notification_server.xml

xhtml:
	mkdir -p output/xhtml
	xsltproc --xinclude -o output/xhtml/main.xhtml $(XSL_BASE)xhtml-1_1/docbook.xsl books/notification_server.xml

html_chunked:
	mkdir -p output/html_chunked
	xsltproc --xinclude -o output/html_chunked/ $(XSL_BASE)html/chunk.xsl books/notification_server.xml

pdf:
	mkdir -p output/pdf
	xsltproc --xinclude -o output/db.fo own.xsl books/notification_server.xml
	fop output/db.fo -pdf output/pdf/main.pdf
	rm -f output/db.fo

gendoc:
	node generate_logtracesdoc.js 1 > books/logtraces_NOTIFY_generated.xml
	node generate_logtracesdoc.js 2 > books/logtraces_ERROR_generated.xml
	node generate_logtracesdoc.js 3 > books/logtraces_CRITICAL_generated.xml

subdirs: $(SUBDIRS)

$(SUBDIRS):
	$(MAKE) -C $@

clean:
	rm -rf output
	rm -rf books/resources/seqdiags

gh-pages:
	git checkout gh-pages
	rm -rf doc
	mv output doc
	rm -rf books
	git add doc
	git commit -m "Automatic documentation generation"
	git push origin gh-pages
	git checkout master
