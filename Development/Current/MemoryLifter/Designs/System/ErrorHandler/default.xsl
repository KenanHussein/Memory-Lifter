<?xml version='1.0' encoding='utf-16'?>
<!--  (c) 2006 LearnLift   -->
<!--  MemoryLifter Stylesheet   -->
<!--  Version 2.0 Date: 2007-11-09   -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="html"/>

  <xsl:template match="/">
    <html>
      <body>
        <xsl:apply-templates select="comment()"/>
        <xsl:apply-templates select="ErrorReport"/>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="comment()">
    <h1>
      <xsl:value-of select="."/>
    </h1>
  </xsl:template>

  <xsl:template match="ErrorReport">
    <xsl:if test="User_Email">
      <div>
        <xsl:text>User email: </xsl:text>
        <xsl:value-of select="User_Email"/>
      </div>
    </xsl:if>
    <xsl:if test="User_Description">
      <div>
        <xsl:text>User description: </xsl:text>
        <xsl:value-of select="User_Description"/>
      </div>
    </xsl:if>
    <xsl:if test="User_Description"></xsl:if>
    <xsl:apply-templates select="MLInformation"/>
    <xsl:apply-templates select="SystemInformation"/>
    <xsl:apply-templates select="ExtensionsInformation"/>
    <xsl:apply-templates select="Exception"/>
  </xsl:template>

  <xsl:template match="SystemInformation">
    <h2>
      System Information
    </h2>
    <xsl:call-template name="informationtable"/>
  </xsl:template>

  <xsl:template match="MLInformation">
    <h2>
      MemoryLifter Information
    </h2>
    <xsl:call-template name="informationtable"/>
  </xsl:template>

  <xsl:template match="ExtensionsInformation">
    <h2>
      MemoryLifter Extensions
    </h2>
    <xsl:call-template name="informationtable"/>
  </xsl:template>

  <xsl:template name="informationtable">
    <!--Simple table-->
    <table>
      <tr>
        <td>
          <b>
            Parameter
          </b>
        </td>
        <td>
          <b>
            Value
          </b>
        </td>
      </tr>
      <xsl:for-each select="*">
        <tr>
          <td>
            <xsl:value-of select="name()"/>
          </td>
          <td>
            <xsl:choose>
              <xsl:when test="count(child::*) > 0">
                <!--parsing inner nodes-->
                <xsl:call-template name="informationtable"/>
              </xsl:when>
              <xsl:otherwise>
                <!--raw values for text elements-->
                <xsl:value-of select="."/>
              </xsl:otherwise>
            </xsl:choose>
          </td>
        </tr>
      </xsl:for-each>
    </table>
  </xsl:template>

  <xsl:template match="Exception">
    <h2>
      Exception
    </h2>
    <xsl:apply-templates select="Message"/>
    <xsl:apply-templates select="Stacktrace"/>
    <xsl:apply-templates select="Exception"/>
  </xsl:template>

  <xsl:template match="Message">
    <p>
      <b>
        <xsl:value-of select="."/>
      </b>
    </p>
  </xsl:template>

  <xsl:template match="Stacktrace">
    <xsl:call-template name="NewLinesToBR">
      <xsl:with-param name="text" select="."/>
    </xsl:call-template>
  </xsl:template>

  <!--replace newlines with html br tags-->
  <xsl:template name="NewLinesToBR">
    <xsl:param name="text" select="."/>
    <xsl:choose>
      <xsl:when test="contains($text, '&#xa;')">
        <xsl:value-of select="substring-before($text, '&#xa;')"/>
        <br/>
        <xsl:call-template name="NewLinesToBR">
          <xsl:with-param name="text" select="substring-after($text,'&#xa;')"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$text"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>