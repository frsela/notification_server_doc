<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  xmlns:d="http://docbook.org/ns/docbook"
  exclude-result-prefixes="d">

  <xsl:import href="/usr/local/Cellar/docbook-xsl/1.78.1/docbook-xsl-ns/fo/docbook.xsl"/>

  <xsl:param name="paper.type">A4</xsl:param>
  <xsl:param name="body.font.size">12.5</xsl:param>
  <xsl:param name="normal.para.spacing">1.5</xsl:param>
  <xsl:param name="body.font.family">Helvetica</xsl:param>
  <xsl:param name="admon.graphics">1</xsl:param>
  <xsl:param name="admon.graphics.path">resources/</xsl:param>
  <xsl:param name="admon.graphics.extension">.svg</xsl:param>
  <xsl:param name="double.sided">1</xsl:param>
  <xsl:param name="fop1.extensions">1</xsl:param>


  <xsl:attribute-set name="monospace.verbatim.properties">
    <xsl:attribute name="font-size">9pt</xsl:attribute>
    <xsl:attribute name="keep-together.within-column">always</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="monospace.properties">
    <xsl:attribute name="font-size">11pt</xsl:attribute>
    <xsl:attribute name="keep-together.within-column">always</xsl:attribute>
  </xsl:attribute-set>

  <xsl:param name="shade.verbatim" select="1"/>

  <xsl:attribute-set name="shade.verbatim.style">
    <xsl:attribute name="background-color">#E0E0E0</xsl:attribute>
    <xsl:attribute name="border-width">0.5pt</xsl:attribute>
    <xsl:attribute name="border-style">solid</xsl:attribute>
    <xsl:attribute name="border-color">#575757</xsl:attribute>
    <xsl:attribute name="padding">3pt</xsl:attribute>
  </xsl:attribute-set>

  <xsl:template name="nongraphical.admonition">
    <xsl:variable name="id">
      <xsl:call-template name="object.id"/>
    </xsl:variable>

    <fo:block space-before.minimum="0.8em"
              space-before.optimum="1em"
              space-before.maximum="1.2em"
              start-indent="0.25in"
              end-indent="0.25in"
              border-left="2pt solid black"
              padding-top="6pt"
              padding-bottom="6pt"
              id="{$id}">
      <xsl:if test="$admon.textlabel != 0 or title">
        <fo:block keep-with-next='always'
                  xsl:use-attribute-sets="admonition.title.properties">
           <xsl:apply-templates select="." mode="object.title.markup"/>
        </fo:block>
      </xsl:if>

      <fo:block xsl:use-attribute-sets="admonition.properties">
        <xsl:apply-templates/>
      </fo:block>
    </fo:block>
  </xsl:template>
</xsl:stylesheet>
