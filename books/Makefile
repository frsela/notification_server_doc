########
# Detect OS: Mac or Linux (Debian)
#######
SYS=$(shell uname -s)
ifeq ($(SYS),Darwin)
XSL_BASE=/usr/local/Cellar/docbook/5.0/docbook/xsl-ns/1.77.1/
else
XSL_BASE=/usr/share/xml/docbook/stylesheet/docbook-xsl-ns/
endif

OUTPUT = ../output
RES = resources/seqdiags

.PHONY: all installseqdiag xhtml html_chunked pdf

all: clean installseqdiag xhtml html_chunked pdf

$(SUBDIRS):
	make -C $@

clean:
	rm -rf $(OUTPUT)/xhtml5
	rm -rf $(OUTPUT)/xhtml5_chunked
	rm -rf $(OUTPUT)/xhtml
	rm -rf $(OUTPUT)/html_chunked
	rm -rf $(RES)/seqdiags

installseqdiag:
	cp -r $(OUTPUT)/seqdiags $(RES)

xhtml5:
	mkdir -p $(OUTPUT)/xhtml5
	xsltproc --xinclude -o $(OUTPUT)/xhtml5/notification_server.xhtml $(XSL_BASE)xhtml5/docbook.xsl notification_server.xml
	cp -r resources $(OUTPUT)/xhtml5/.

xhtml5_chunked:
	mkdir -p $(OUTPUT)/xhtml5_chunked
	xsltproc --xinclude -o $(OUTPUT)/xhtml5_chunked/ $(XSL_BASE)xhtml5/chunk.xsl notification_server.xml
	cp -r resources $(OUTPUT)/xhtml5_chunked/.

xhtml:
	mkdir -p $(OUTPUT)/xhtml
	xsltproc --xinclude -o $(OUTPUT)/xhtml/notification_server.xhtml $(XSL_BASE)xhtml-1_1/docbook.xsl notification_server.xml
	cp -r resources $(OUTPUT)/xhtml/.

html_chunked:
	mkdir -p $(OUTPUT)/html_chunked
	xsltproc --xinclude -o $(OUTPUT)/html_chunked/ $(XSL_BASE)html/chunk.xsl notification_server.xml
	cp -r resources $(OUTPUT)/html_chunked/.

pdf:
	mkdir -p $(OUTPUT)/pdf
	xsltproc --xinclude -o $(OUTPUT)/db.fo $(XSL_BASE)fo/docbook.xsl notification_server.xml
	fop $(OUTPUT)/db.fo -pdf $(OUTPUT)/pdf/notification_server.pdf
	rm -f $(OUTPUT)/db.fo

define FOP_LOG4J_FILE
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE log4j:configuration SYSTEM "log4j.dtd">

<log4j:configuration xmlns:log4j="http://jakarta.apache.org/log4j/">
  <appender name="console" class="org.apache.log4j.ConsoleAppender">
    <param name="Target" value="System.out"/>
    <layout class="org.apache.log4j.PatternLayout">
      <param name="ConversionPattern" value="%-5p %c{1} - %m%n"/>
    </layout>
  </appender>

  <root>
    <priority value ="debug" />
    <appender-ref ref="console" />
  </root>

</log4j:configuration>
endef
export FOP_LOG4J_FILE
debug:
	@echo "$$FOP_LOG4J_FILE" > log4j.xml

undebug:
	@rm -f log4j.xml
