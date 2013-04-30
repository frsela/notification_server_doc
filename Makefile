SUBDIRS = sequence_diagrams books
 
.PHONY: all gendoc subdirs $(SUBDIRS) clean gh-pages

all: clean gendoc subdirs

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
