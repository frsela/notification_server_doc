.PHONY: all

all: clean html html_chunked pdf

clean:
	rm -rf output

html:
	mkdir -p output/html
	xsltproc --xinclude -o output/html/notification_server.html /usr/share/xml/docbook/stylesheet/docbook-xsl-ns/xhtml-1_1/docbook.xsl notification_server.xml
	cp -r resources output/html/.

html_chunked:
	mkdir -p output/html_chunked
	xsltproc --xinclude -o output/html_chunked/ /usr/share/xml/docbook/stylesheet/docbook-xsl-ns/xhtml-1_1/chunk.xsl notification_server.xml
	cp -r resources output/html_chunked/.

pdf:
	mkdir -p output/pdf
	xsltproc --xinclude -o output/db.fo /usr/share/xml/docbook/stylesheet/docbook-xsl-ns/fo/docbook.xsl notification_server.xml
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
