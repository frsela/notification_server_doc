SUBDIRS = sequence_diagrams books
 
.PHONY: all gendoc subdirs $(SUBDIRS) clean gh-pages

all: clean gendoc subdirs

gendoc:
	node generate_logtracesdoc.js > books/logtraces.xml

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
