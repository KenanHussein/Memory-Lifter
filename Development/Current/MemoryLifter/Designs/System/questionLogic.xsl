<?xml version='1.0' encoding='utf-16'?>
<!--  (c) 2006 LearnLift   -->
<!--  MemoryLifter Stylesheet   -->
<!--  Version 2.0 Date: 2007-10-08   -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:include href="../System/blockLogic.xsl"/>
  <xsl:include href="../System/wordmodeLogic.xsl"/>
  <xsl:include href="../System/sentencemodeLogic.xsl"/>
  <xsl:include href="../System/listeningmodeLogic.xsl"/>
  <xsl:include href="../System/imagemodeLogic.xsl"/>

  <xsl:template name="card">
    <xsl:param name="class" select="'question'"/>

    <body class="{$class}" onResize="onWindowResize(document.getElementById('mainImage'),document.getElementById('video'))">
      <div id="main">
        <div id="correctQuestionBox">
          <xsl:choose>
            <xsl:when test="$mode = 'wordmode'">
              <xsl:call-template name="displayWordmode" />
            </xsl:when>
            <xsl:when test="$mode = 'sentencemode'">
              <xsl:call-template name="displaySentencemode" />
            </xsl:when>
            <xsl:when test="$mode = 'listeningmode'">
              <xsl:call-template name="displayListeningmode" />
            </xsl:when>
            <xsl:when test="$mode = 'imagemode'">
              <xsl:call-template name="displayImagemode" />
            </xsl:when>
          </xsl:choose>
        </div>
      </div>
    </body>
  </xsl:template>
</xsl:stylesheet>