SUBDIRS = books sequence_diagrams
 
.PHONY: all subdirs $(SUBDIRS) clean

all: clean subdirs
 
subdirs: $(SUBDIRS)
 
$(SUBDIRS):
	$(MAKE) -C $@

clean:
	rm -rf output
