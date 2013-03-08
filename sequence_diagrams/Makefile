DIAGRAMS = change_ip.png full_interaction_wakeup.png full_interaction_ws.png delegatedmode_simplified.png

P2P := pic2plot

OUTPUT = ../output/seqdiags

.PHONY: all install clean allsvg allpng

all: $(DIAGRAMS)

%.svg : %.pic
	mkdir -p $(OUTPUT)
	@$(P2P) -T "svg" $*.pic > $(OUTPUT)/$*.svg

%.png : %.pic
	mkdir -p $(OUTPUT)
	@$(P2P) -T "svg" $*.pic | convert -trim - $(OUTPUT)/$*.png

allpng:
	@for p in `find *.pic -maxdepth 0` ;\
	do \
		echo "Generating PNG from $$p" ;\
		if [ $$p = sequence.pic ]; \
		then \
			echo "sequence.pic excluded ..." ;\
		else \
			$(P2P) -T "svg" $$p | convert -trim - $$p.png ;\
		fi \
	done

allsvg:
	@for p in `find *.pic -maxdepth 0` ;\
	do \
	echo "Generating SVG from $$p" ;\
	if [ $$p = sequence.pic ]; \
		then \
			echo "sequence.pic excluded ..." ;\
		else \
			$(P2P) -T "svg" $$p > $$p.svg ;\
		fi \
	done

clean:
	rm -rf $(OUTPUT)
