<?xml version='1.0' encoding='utf-16'?>
<!--  (c) 2006 LearnLift   -->
<!--  MemoryLifter Stylesheet   -->
<!--  Version 2.0 Date: 2007-10-08   -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:CardObject="urn:cardobject" exclude-result-prefixes="CardObject">

  <xsl:template name="displayListeningmode">
    <xsl:choose>
      <xsl:when test="$side = 'question'">
        <div>
          <xsl:if test="CardObject:ContainsAudio($side)">
            <xsl:value-of select="$clickForQuestion"/>
            <xsl:call-template name="displayAudio" />
          </xsl:if>
          <xsl:call-template name="displayVideo" />
        </div>
        <div>
          <xsl:if test="CardObject:ContainsExampleAudio($side)">
            <xsl:value-of select="$clickForExample"/>
            <xsl:call-template name="displayExampleAudio" />
          </xsl:if>
        </div>
	  <xsl:if test="$displayImages = 'true'">
	  <div id="listeningModeImage">
		  <xsl:call-template name="displayImage">
			  <xsl:with-param name="mode" select="'listening'" />
		  </xsl:call-template>
	  </div>
	  </xsl:if>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="displayWordmode" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>