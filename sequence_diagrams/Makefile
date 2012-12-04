DIAGRAMS = change_ip.png full_interaction_wakeup.png full_interaction_ws.png
P2P := pic2plot

OUTPUT = ../output/seqdiags

.PHONY: all

all: $(DIAGRAMS)

%.svg : %.pic
	mkdir -p $(OUTPUT)
	@$(P2P) -T "svg" $*.pic > $(OUTPUT)/$*.svg

%.png : %.pic
	mkdir -p $(OUTPUT)
	@$(P2P) -T "svg" $*.pic | convert -trim - $(OUTPUT)/$*.png

clean:
	rm -rf $(OUTPUT)
