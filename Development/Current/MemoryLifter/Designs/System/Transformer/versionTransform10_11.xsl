<?xml version='1.0' encoding='utf-16'?>
<!--  (c) 2008 LearnLift   -->
<!--  MemoryLifter Skin Transformer   -->
<!--  Version 1.0 Date: 2008-05-09   -->
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:translate="Items to translate"
                xmlns:delete="Items to delete"
                exclude-result-prefixes="translate delete">
  <xsl:output method="xml" version="1.0" indent="yes" omit-xml-declaration="no" />
  <xsl:strip-space elements="*"/>

  <!-- items to translate -->
  <translate:item key="labelChapter" new="statusBar" />
  <translate:item key="panelBackgroundAnswer" new="answerPanel" />
  <translate:item key="panelBackgroundQuestion" new="questionPanel" />
  <translate:item key="panelTopRow" new="statisticsPanel" />
  <translate:item key="panelViewer" new="splitContainerVertical" />
  <translate:item key="richTextBoxStack" new="stackFlow" />
  <translate:item key="richTextBoxStack_1" new="stackFlow_Correct" />
  <translate:item key="richTextBoxStack_2" new="stackFlow_Wrong" />
  <translate:item key="richTextBoxStack_3" new="stackFlow_Almost" />
  <translate:item key="vocEditAnswer" new="mLifterTextBox" />
  <!-- items to delete -->
  <delete:item key="HorizontalSplitter" />
  <delete:item key="verticalSplitter" />
  <delete:item key="labelRight" />
  <delete:item key="labelRightDescription" />
  <delete:item key="labelScore" />
  <delete:item key="labelScoreDescription" />
  <delete:item key="labelSizeDescription" />
  <delete:item key="labelTimer" />
  <delete:item key="labelTimerDescription" />
  <delete:item key="labelWrong" />
  <delete:item key="labelWrongDescription" />
  <delete:item key="labelBoxNumber" />
  <delete:item key="labelBoxNumberDescription" />
  <delete:item key="labelCards" />

  <xsl:template match="/">
    <xsl:apply-templates />
  </xsl:template>

  <xsl:template match="* | @* | node()">
    <xsl:copy>
      <xsl:apply-templates select="* | @* | node()" />
    </xsl:copy>
  </xsl:template>

  <xsl:template match="item">
    <xsl:variable name="translate" select="document('')/*/translate:item" />
    <xsl:variable name="delete" select="document('')/*/delete:item" />
    <xsl:variable name="key" select="string(key)" />
    <xsl:choose>
      <xsl:when test="$translate/@key = $key">
        <item>
          <key>
            <xsl:value-of select="$translate[@key = $key]/@new"/>
          </key>
          <value>
            <ControlSettings>
              <xsl:apply-templates select="value/ControlSettings/*" />

              <xsl:if test="$translate[@key = $key]/@new = 'statisticsPanel'">
                <ForeColorTitle Type="Color">
                  <xsl:value-of select="/Style/StyledControls/item[key = 'labelRight']/value/ControlSettings/ForeColor"/>
                </ForeColorTitle>
                <ForeColorValue Type="Color">
                  <xsl:value-of select="/Style/StyledControls/item[key = 'labelRightDescription']/value/ControlSettings/ForeColor"/>
                </ForeColorValue>
                <FontTitle Type="Font">
                  <xsl:value-of select="/Style/StyledControls/item[key = 'labelRight']/value/ControlSettings/Font"/>
                </FontTitle>
                <FontValue Type="Font">
                  <xsl:value-of select="/Style/StyledControls/item[key = 'labelRightDescription']/value/ControlSettings/Font"/>
                </FontValue>
              </xsl:if>

            </ControlSettings>
          </value>
        </item>
      </xsl:when>
      <xsl:when test="$delete/@key = ./key/text()" />
      <xsl:otherwise>
        <item>
          <xsl:apply-templates />
        </item>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>