<?xml version='1.0' encoding='utf-16'?>
<!--  (c) 2006 LearnLift   -->
<!--  MemoryLifter Stylesheet   -->
<!--  Version 2.0 Date: 2007-10-08   -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:CardObject="urn:cardobject" exclude-result-prefixes="CardObject">

  <xsl:template name="displayText">
    <span dir="{CardObject:GetTextDirection($side)}">
      <xsl:value-of select="CardObject:GetText($side)" disable-output-escaping="yes"/>
    </span>
  </xsl:template>

  <xsl:template name="displayExample">
    <span dir="{CardObject:GetTextDirection($side)}">
      <xsl:value-of select="CardObject:GetExample($side)" disable-output-escaping="yes"/>
    </span>
  </xsl:template>

  <xsl:template name="displayImage">
    <xsl:param name="mode" select="'default'" />
    <xsl:if test="CardObject:ContainsImage($side)">
      <xsl:variable name="path" select="CardObject:GetImage($side)"/>
      <xsl:variable name="width" select="CardObject:GetImageWidth($side)"/>
      <xsl:variable name="height" select="CardObject:GetImageHeight($side)"/>
      <div id="image">
        <img id="mainImage" src="{$path}" class="image" name="image" 
			 onload="setImageSize(this,{$width},{$height})"
			 onclick="toggleImageSize(this,{$width},{$height});">
          <xsl:attribute name="alt">
            <xsl:value-of select="$resizePicture"/>
          </xsl:attribute>
        </img>
        <div class="imageSubtitle" id="mainImageSubtitle" style='visibility:visible'>
          <xsl:value-of select='$resizePicture'/>
        </div>
      </div>
      <xsl:if test="$mode = 'listening'">
        <div id="buttonListeningMode">
          <button onclick="toggleListeningImage('buttonListeningMode', 'image');">
            <span>
              <xsl:value-of select="$listeningModeText"/>
            </span>
          </button>
        </div>
      </xsl:if>
    </xsl:if>
  </xsl:template>

  <xsl:template name="displayAudio">
    <xsl:if test="CardObject:ContainsAudio($side)">
      <button id="buttonPlayAudio" class="buttonPlayAudio" onClick="playAudio('audio');">
        <xsl:if test="not($side = 'question' and ($mode = 'listeningmode' or $mode = 'imagemode'))">
          <xsl:attribute name="style">
            <xsl:text>float: right</xsl:text>
          </xsl:attribute>
        </xsl:if>

        <img id="playAudioButton" src="{$stylePath}play.gif" alt="Play"
             onMouseOver="this.src = '{$stylePath}playHover.gif'"
             onMouseOut="this.src = '{$stylePath}play.gif'"/>
      </button>
      <xsl:if test="not($side = 'question' and ($mode = 'listeningmode' or $mode = 'imagemode'))">
        <div id="buttonMirror">
          <span></span>
        </div>
      </xsl:if>
      <!-- some MP 7/ only code -->
      <style type="text/css">
        <xsl:text disable-output-escaping="yes"><![CDATA[
div.hide {
    display:expression((mpVer < 9) ? "inline" : false);
}
]]></xsl:text>
      </style>
      <div class="hide">
        <script type="text/javascript" language="JavaScript">
          <xsl:text>
            prepareMediaPlayer('audio', '</xsl:text>
          <!--<xsl:value-of select="translate($baseURL,'\','/')" disable-output-escaping="yes"/>-->
          <xsl:value-of select="translate(CardObject:GetAudio($side),'\','/')" disable-output-escaping="yes"/>
          <xsl:text>', '100', 'false', false);
          </xsl:text>
        </script>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template name="displayExampleAudio">
    <xsl:if test="CardObject:ContainsExampleAudio($side)">
      <button id="buttonPlayExampleAudio" class="buttonPlayExampleAudio" onClick="playAudio('example');">
        <xsl:if test="not($side = 'question' and ($mode = 'listeningmode' or $mode = 'imagemode'))">
          <xsl:attribute name="style">
            <xsl:text>float: right</xsl:text>
          </xsl:attribute>
        </xsl:if>

        <img id="playExampleAudioButton" src="{$stylePath}play.gif" alt="Play"
             onMouseOver="this.src = '{$stylePath}playHover.gif'"
             onMouseOut="this.src = '{$stylePath}play.gif'"/>
      </button>
      <xsl:if test="not($side = 'question' and ($mode = 'listeningmode' or $mode = 'imagemode'))">
        <div id="buttonMirror">
          <span></span>
        </div>
      </xsl:if>
      <!-- some MP 7/ only code -->
      <style type="text/css">
        <xsl:text disable-output-escaping="yes"><![CDATA[
div.hide {
    display:expression((mpVer < 9) ? "inline" : false);
}
]]></xsl:text>
      </style>
      <div class="hide">
        <script type="text/javascript" language="JavaScript">
          <xsl:text>
            prepareMediaPlayer('example', '</xsl:text>
          <!--<xsl:value-of select="translate($baseURL,'\','/')" />-->
          <xsl:value-of select="translate(CardObject:GetExampleAudio($side),'\','/')" />
          <xsl:text>', '100', 'false', false);
          </xsl:text>
        </script>
      </div>
    </xsl:if>
  </xsl:template>

  <xsl:template name="displayVideo">
    <xsl:if test="CardObject:ContainsVideo($side)">
      <button id="buttonPlayVideo" class="buttonPlayVideo"
            onClick="playVideo(this);">
        <img src="{$stylePath}playVideo.gif" alt="Play Video" border="0"
        onMouseOver="this.src = '{$stylePath}playVideoHover.gif'"
        onMouseOut="this.src = '{$stylePath}playVideo.gif'"/>
      </button>
      <div class="video" id="videoDIV">
        <script type="text/javascript" language="JavaScript">
          <xsl:text>
              prepareMediaPlayer('video', '</xsl:text>
          <!--<xsl:value-of select="translate($baseURL,'\','/')" />-->
          <xsl:value-of select="translate(CardObject:GetVideo($side),'\','/')" />
          <xsl:text>', '100', 'false', true);
            </xsl:text>
        </script>
      </div>
      <p />
    </xsl:if>
  </xsl:template>

</xsl:stylesheet>