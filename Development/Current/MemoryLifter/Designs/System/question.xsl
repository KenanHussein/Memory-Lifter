<?xml version='1.0' encoding='utf-16'?>
<!--  (c) 2006 LearnLift   -->
<!--  MemoryLifter Stylesheet   -->
<!--  Version 2.0 Date: 2007-10-08   -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:CardObject="urn:cardobject" exclude-result-prefixes="CardObject">
  <xsl:output method="xml" version="1.0"
              doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
              doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" indent="no" omit-xml-declaration="no" />

  <xsl:param name="clickForQuestion" select="'Click button for question:'" />
  <xsl:param name="clickForExample" select="'Click button for example:'" />
  <xsl:param name="resizePicture" select="'Click image to show original size.'" />
  <xsl:param name="restorePicture" select="'Click image to show smaller size.'" />
  <xsl:param name="listeningModeText" select="'Click here to show the image.'" />

  <xsl:param name="mode" select="'wordmode'" />
  <xsl:param name="side" select="'question'" />

  <xsl:param name="nothing" select="'&lt;Nothing&gt;'" />

  <xsl:param name="displayImages" select="'true'" />
  <xsl:param name="question2answer" select="'true'" />
  <xsl:param name="autoPlaySound" select="'true'" />
  <xsl:param name="userAnswer" select="'&lt;Nothing&gt;'"/>
  <xsl:param name="correct" select="'true'" />

  <xsl:param name="baseURL" />
  <xsl:param name="stylePath" />

  <xsl:include href="../System/questionLogic.xsl"/>
  <xsl:include href="../System/style.xsl"/>
  <xsl:include href="../System/scripts.xsl"/>

  <xsl:template match="/">
    <html xmlns="http://www.w3.org/1999/xhtml">
      <head>
        <title>MemoryLifter - XSL stylesheet for ML program question side</title>
        <base href="{$baseURL}" />
        <style type="text/css">
          <xsl:call-template name="defaultstyle"/>
          <xsl:call-template name="style"/>
          <xsl:value-of select="CardObject:GetStyle()"/>
        </style>
        <script type="text/javascript">
          <xsl:call-template name="jscript"/>
        </script>
      </head>
      <xsl:call-template name="card">
        <xsl:with-param name="class" select="'question'"/>
      </xsl:call-template>
    </html>
  </xsl:template>
</xsl:stylesheet>