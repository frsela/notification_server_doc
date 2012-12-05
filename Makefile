SUBDIRS = sequence_diagrams books
 
.PHONY: all subdirs $(SUBDIRS) clean gh_pages

all: clean subdirs
 
subdirs: $(SUBDIRS)
 
$(SUBDIRS):
	$(MAKE) -C $@

clean:
	rm -rf output

gh-pages:
	git checkout gh-pages
	mv output doc
	rm -rf books
	git add doc
	git commit -m "Automatic documentation generation"
	git push origin gh-pages
	git checkout master
