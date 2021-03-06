<?xml version='1.0' encoding='utf-16'?>
<!--  MemoryLifter Printing Stylesheet   -->
<!--  Version 1.00   -->
<!--  (c) 2006 LearnLift   -->
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:Status="urn:status" exclude-result-prefixes="Status"
                xmlns:CardObject="urn:cardobject"
                xmlns:msxsl="urn:schemas-microsoft-com:xslt"
                xmlns:scripts="urn:my-scripts">

  <xsl:output method="xml" version="1.0"
              doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
              doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" indent="yes" omit-xml-declaration="no" />

  <xsl:param name="answercaption" />
  <xsl:param name="questioncaption" />
  <xsl:param name="description" />
  <xsl:param name="chapters" />
  <xsl:param name="baseURL" />
  <xsl:param name="titleText" />

  <xsl:variable name="cardHeight" select="195"/>
  <xsl:variable name="cardWidth" select="300"/>
  <xsl:variable name="cardsOnPage" select="4"/>
  <xsl:variable name="imageMaxHeight" select="135"/>
  <xsl:variable name="imageMaxWidth" select="250"/>

  <xsl:template match = "dictionary">
    <html>
      <head>
        <title>
          <xsl:value-of select="$titleText"/>
        </title>
        <style type="text/css">
          <xsl:text><![CDATA[
          table
          {
          table-layout:fixed;
          }

          td
          {
          border:1px solid #000;
          overflow:hidden;
          text-align:center;
          padding:4px;
          font-family:Helvetica,Arial,sans-serif;
          width:]]></xsl:text>
          <xsl:value-of select="$cardWidth"/>
          <xsl:text><![CDATA[px;
          }

          thead td
          {
          font-size:14pt;
          font-weight:bold;
          color:steelblue;
          vertical-align:middle;
		  height: 45px;
          }
          
          tfoot td
          {
          font-size: 9pt;
          width:100%;
          font-weight:bold;
          color:steelblue;
          }

          div
          {
          max-width:280px;
          max-height:55px;
          min-height:55px;
          overflow:hidden;
          font-size:10px;
          text-align:center;
          }

          span.default_text
          {
          color:#FF0000;
          font-size:12pt;
          }

          span.example_text
          {
          color:#0000FF;
          font-style:italic;
          }
]]></xsl:text>
        </style>

        <base href="{$baseURL}" />

      </head>

      <body>
        <xsl:apply-templates select="card" />
      </body>
    </html>
  </xsl:template>

  <xsl:template match="card">
    <xsl:if test="Status:SendStatus()" />
    <table cellspacing="1" cellpadding="0" align="center">
      <!--following sequence creates periodly a table header-->
      <xsl:if test="(position()-1) mod $cardsOnPage = 0">
        <thead>
			<tr>
            <td>
              <span dir="{CardObject:GetTextDirection('question')}">
                <xsl:value-of select="$questioncaption"/>
              </span>
            </td>
            <td>
              <span dir="{CardObject:GetTextDirection('answer')}">
                  <xsl:value-of select="$answercaption"/>
              </span>
            </td>
          </tr>
        </thead>
      </xsl:if>

      <!--following sequence creates the content of the table (answer and question)-->
      <tr height="{$cardHeight}px">
        <td>
          <xsl:apply-templates select = "questionimage"/>
          <div dir="{CardObject:GetTextDirection('question')}">
            <xsl:apply-templates select = "question"/>
            <br/>
            <xsl:apply-templates select = "questionexample"/>

          </div>
        </td>
        <td>
          <xsl:apply-templates select = "answerimage"/>
          <div dir="{CardObject:GetTextDirection('answer')}">
            <xsl:apply-templates select = "answer"/>
            <br/>
            <xsl:apply-templates select = "answerexample"/>
          </div>
        </td>
      </tr>
      <xsl:if test="(position() mod $cardsOnPage = 0) or (position() = last())">
        <tfoot>
          <tr>
            <td colspan="2">
              <xsl:value-of select="$description"/>
            </td>
          </tr>
        </tfoot>
      </xsl:if>
    </table>

    <!--following sequence creates periodly a page break -->
    <xsl:if test="(position() mod $cardsOnPage = 0) and (position() != last())">
      <br style="page-break-after:always"/>
    </xsl:if>

  </xsl:template>



  <xsl:template match="question">
    <span class="default_text">
      <xsl:value-of select="translate(.,'&quot;','')"/>
    </span>
  </xsl:template>

  <xsl:template match="questionimage">
    <xsl:choose>
      <xsl:when test="./@width > $imageMaxWidth">
        <!--if picture-width is larger than maximum-width-->
        <xsl:choose>
          <xsl:when test="./@height * $imageMaxWidth div ./@width > $imageMaxHeight">

            <img>
              <xsl:attribute name="height">
                <xsl:value-of select="$imageMaxHeight"/>
              </xsl:attribute>
              <xsl:attribute name="src">
                <xsl:value-of select="." />
              </xsl:attribute>
            </img>

          </xsl:when>
          <xsl:otherwise>

            <img>
              <xsl:attribute name="width">
                <xsl:value-of select="$imageMaxWidth"/>
              </xsl:attribute>
              <xsl:attribute name="src">
                <xsl:value-of select="." />
              </xsl:attribute>
            </img>

          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:when test="./@height > $imageMaxHeight">

        <img>
          <xsl:attribute name="height">
            <xsl:value-of select="$imageMaxHeight"/>
          </xsl:attribute>
          <xsl:attribute name="src">
            <xsl:value-of select="." />
          </xsl:attribute>
        </img>

      </xsl:when>
      <xsl:otherwise>

        <img>
          <xsl:attribute name="src">
            <xsl:value-of select="." />
          </xsl:attribute>
        </img>

      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="questionexample">
    <span class="example_text">
      <xsl:value-of select="."/>
    </span>
  </xsl:template>

  <xsl:template match="answer">
    <span class="default_text">
      <xsl:value-of select="translate(.,'&quot;','')"/>
    </span>
  </xsl:template>

  <xsl:template match="answerimage">
    <xsl:choose>
      <xsl:when test="./@width > $imageMaxWidth">
        <!--if picture-width is larger than maximum-width-->
        <xsl:choose>
          <xsl:when test="./@height * $imageMaxWidth div ./@width > $imageMaxHeight">

            <img>
              <xsl:attribute name="height">
                <xsl:value-of select="$imageMaxHeight"/>
              </xsl:attribute>
              <xsl:attribute name="src">
                <xsl:value-of select="." />
              </xsl:attribute>
            </img>
            <xsl:variable name="pic_height" select="$imageMaxHeight"/>

          </xsl:when>
          <xsl:otherwise>
            <img>
              <xsl:attribute name="width">
                <xsl:value-of select="$imageMaxWidth"/>
              </xsl:attribute>
              <xsl:attribute name="src">
                <xsl:value-of select="." />
              </xsl:attribute>
            </img>
            <xsl:variable name="pic_height" select="./@height"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:when test="./@height > $imageMaxHeight">
        <img>
          <xsl:attribute name="height">
            <xsl:value-of select="$imageMaxHeight"/>
          </xsl:attribute>
          <xsl:attribute name="src">
            <xsl:value-of select="." />
          </xsl:attribute>
        </img>
        <xsl:variable name="pic_height" select="$imageMaxHeight"/>
      </xsl:when>
      <xsl:otherwise>
        <img>
          <xsl:attribute name="src">
            <xsl:value-of select="." />
          </xsl:attribute>
        </img>
        <xsl:variable name="pic_height" select="./@height"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="answerexample">
    <span class="example_text">
      <xsl:value-of select="."/>
    </span>
  </xsl:template>
</xsl:stylesheet>



