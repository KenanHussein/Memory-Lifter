<?xml version='1.0' encoding='utf-16'?>
<!--  (c) 2006 LearnLift   -->
<!--  MemoryLifter Stylesheet   -->
<!--  Version 2.0 Date: 2007-10-08   -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:CardObject="urn:cardobject">

  <xsl:template name="displayWordmode">
    <div id="{$side}">
		<div id="{$side}Header" class="{side}">
			<xsl:if test="CardObject:ContainsAudio($side)">
				<xsl:attribute name="onClick">
					<xsl:text>playAudio('audio');</xsl:text>
				</xsl:attribute>
				<xsl:attribute name="onMouseOver">
					<xsl:text>document.getElementById('playAudioButton').src = '</xsl:text>
					<xsl:value-of select="$stylePath"/>
					<xsl:text>playHover.gif';</xsl:text>
				</xsl:attribute>
				<xsl:attribute name="onMouseOut">
					<xsl:text>document.getElementById('playAudioButton').src = '</xsl:text>
					<xsl:value-of select="$stylePath"/>
					<xsl:text>play.gif';</xsl:text>
				</xsl:attribute>
				<xsl:attribute name="style">
					<xsl:text>cursor: pointer</xsl:text>
				</xsl:attribute>
			</xsl:if>
			
			<xsl:call-template name="displayAudio" />
			<xsl:call-template name="displayText" />
		</div>

      <xsl:if test="$displayImages = 'true'">
        <xsl:call-template name="displayImage"/>
      </xsl:if>
      <xsl:call-template name="displayVideo" />

      <xsl:if test="CardObject:GetExample($side) != ''">
        <div id="{$side}Example" class="{$side}Example">
          <xsl:if test="CardObject:ContainsExampleAudio($side)">
            <xsl:attribute name="onClick">
              <xsl:text>playAudio('example');</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="onMouseOver">
              <xsl:text>document.getElementById('playExampleAudioButton').src = '</xsl:text>
              <xsl:value-of select="$stylePath"/>
              <xsl:text>playHover.gif';</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="onMouseOut">
              <xsl:text>document.getElementById('playExampleAudioButton').src = '</xsl:text>
              <xsl:value-of select="$stylePath"/>
              <xsl:text>play.gif';</xsl:text>
            </xsl:attribute>
			<xsl:attribute name="style">
			  <xsl:text>cursor: pointer</xsl:text>
			</xsl:attribute>
          </xsl:if>
			
          <xsl:call-template name="displayExampleAudio" />
          <xsl:call-template name="displayExample" />
        </div>
      </xsl:if>
    </div>
  </xsl:template>
</xsl:stylesheet>