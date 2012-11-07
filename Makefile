########
# Detect OS: Mac or Linux (Debian)
#######
SYS=$(shell uname -s)
ifeq ($(SYS),Darwin)
XSL_BASE=/usr/local/Cellar/docbook/5.0/docbook/xsl-ns/1.77.1/
else
XSL_BASE=/usr/share/xml/docbook/stylesheet/docbook-xsl-ns/
endif

.PHONY: all

all: clean xhtml html_chunked pdf

clean:
	rm -rf output

xhtml5:
	mkdir -p output/xhtml5
	xsltproc --xinclude -o output/xhtml5/notification_server.xhtml $(XSL_BASE)xhtml5/docbook.xsl notification_server.xml
	cp -r resources output/xhtml5/.

xhtml5_chunked:
	mkdir -p output/xhtml5_chunked
	xsltproc --xinclude -o output/xhtml5_chunked/ $(XSL_BASE)xhtml5/chunk.xsl notification_server.xml
	cp -r resources output/xhtml5_chunked/.

xhtml:
	mkdir -p output/xhtml
	xsltproc --xinclude -o output/xhtml/notification_server.xhtml $(XSL_BASE)xhtml-1_1/docbook.xsl notification_server.xml
	cp -r resources output/xhtml/.

html_chunked:
	mkdir -p output/html_chunked
	xsltproc --xinclude -o output/html_chunked/ $(XSL_BASE)html/chunk.xsl notification_server.xml
	cp -r resources output/html_chunked/.

pdf:
	mkdir -p output/pdf
	xsltproc --xinclude -o output/db.fo $(XSL_BASE)fo/docbook.xsl notification_server.xml
	fop output/db.fo -pdf output/pdf/notification_server.pdf
	rm -f output/db.fo

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
