<?xml version='1.0' encoding='utf-16'?>
<!--  (c) 2006 LearnLift   -->
<!--  MemoryLifter Stylesheet   -->
<!--  Version 2.0 Date: 2007-10-08   -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:CardObject="urn:cardobject" exclude-result-prefixes="CardObject">

  <xsl:template name="jscript">
    <xsl:variable name="path" select="CardObject:GetImage($side)"/>
    <xsl:variable name="width" select="CardObject:GetImageWidth($side)"/>
    <xsl:variable name="height" select="CardObject:GetImageHeight($side)"/>
    <xsl:text disable-output-escaping="yes"><![CDATA[
    window.onerror = function() { return true; }  //[ML-967] forward all exceptions into nirvana...in case someone does something stupid...
    
    var originalSize = false;
    var widthFactor = 0.95;
    var heightFactor = 0.65;
    
    var isWMP7;
    var mpVer = 9

    if(window.ActiveXObject)
    {
      try
      {
        isWMP7 = new ActiveXObject("WMPlayer.OCX.7");
        var matchVersion = /^(\d+)\./;
        matchVersion.exec(isWMP7.versionInfo);
        mpVer = parseInt(RegExp.$1)
      }
      catch (e)
      {
      }
    }
    
    function getImageWidth(iw, ih)
    {
      var ww = getWindowWidth()*widthFactor;
      var wh = getWindowHeight()*heightFactor;
      
      if(ww < iw || wh < ih)
      {
        showResizeInfo();
        if(iw/ww < ih/wh)
          return iw * wh/ih;
        else
          return ww;
      }
      else
      {
        hideResizeInfo()
        return iw;
      }
    }
    
    function onWindowResize(pic, vid)
    {
	  if (pic != null)
	  {
		var width = ]]></xsl:text><xsl:value-of select="$width" /><xsl:text disable-output-escaping="yes"><![CDATA[;
		var height = ]]></xsl:text><xsl:value-of select="$height" /><xsl:text disable-output-escaping="yes"><![CDATA[;
		var scaledWidth = getImageWidth(width,height);
		var scaledHeight = getImageHeight(width,height);

		if (originalSize == false)
		{
		  pic.width = scaledWidth;
		  pic.height = scaledHeight;
		  if (scaledWidth < width || scaledHeight < height)
		  {
			showResizeInfo();
		  }
		  else
		  {
			hideResizeInfo();
		  }
		}
        else if (originalSize == true)
		{
		  hideResizeInfo();
		  if (scaledWidth < width || scaledHeight < height)
		  {
		    document.getElementById('mainImage').style.cursor = "pointer";
			document.getElementById('mainImage').alt = "]]></xsl:text><xsl:value-of select="$restorePicture" /><xsl:text disable-output-escaping="yes"><![CDATA[";
		  }
		}
	  }
      if(vid != null)
      {
        vid.width=getImageWidth(1920,1440);
        vid.height=getImageHeight(1920,1440);
      }
    }
    
    function setImageSize(pic, width, height)
    {
      pic.width=width;
      pic.height=height;
    }
    
    function toggleImageSize(pic, width, height)
    {
	  var width = ]]></xsl:text><xsl:value-of select="$width" /><xsl:text disable-output-escaping="yes"><![CDATA[;
	  var height = ]]></xsl:text><xsl:value-of select="$height" /><xsl:text disable-output-escaping="yes"><![CDATA[;
	  var scaledWidth = getImageWidth(width,height);
	  var scaledHeight = getImageHeight(width,height);

	  if (scaledWidth < width || scaledHeight < height)
	  {
		if (originalSize)
		{
		  pic.width=scaledWidth;
		  pic.height=scaledHeight;
		  originalSize = false;
		  onWindowResize(document.getElementById('mainImage'), document.getElementById('video'));
		}
		else
		{
		  pic.width=width;
		  pic.height=height;
		  originalSize = true;
		  onWindowResize(document.getElementById('mainImage'), document.getElementById('video'));
		}
	  }
    }
        
    function showResizeInfo()
    {
      if (document.getElementById('mainImageSubtitle') && document.getElementById('mainImage'))
      {
        document.getElementById('mainImageSubtitle').style.visibility = 'visible';
        document.getElementById('mainImage').alt = "]]></xsl:text><xsl:value-of select="$resizePicture" /><xsl:text disable-output-escaping="yes"><![CDATA[";
        document.getElementById('mainImage').style.cursor = "pointer";
      }
    }

    function hideResizeInfo()
    {
      if (document.getElementById('mainImageSubtitle') && document.getElementById('mainImage'))
      {
        document.getElementById('mainImageSubtitle').style.visibility = 'hidden';
        document.getElementById('mainImage').alt = "";
        document.getElementById('mainImage').style.cursor = "default";
      }
    }
    
    function getImageHeight(iw, ih)
    {
      var ww = getWindowWidth()*widthFactor;
      var wh = getWindowHeight()*heightFactor;
      
      if(ww < iw || wh < ih)
      {
        if(iw/ww < ih/wh)
          return wh;
        else
          return ih*ww/iw;
      }
      else
      {
        return ih;
      }
    }
    
    function getWindowWidth()
    {
      var ww = 10000;
      d = document;

      if ( typeof window.innerWidth != 'undefined' )
        ww = window.innerWidth;  // NN and Opera version
      else
      {
        if ( d.documentElement && typeof d.documentElement.clientWidth!='undefined' && d.documentElement.clientWidth != 0 )
          ww = d.documentElement.clientWidth;
        else
          if ( d.body && typeof d.body.clientWidth != 'undefined' )
            ww = d.body.clientWidth;
      }
      
      return ww;
    }
    
    function getWindowHeight()
    {
      var ww = 10000;
      d = document;

      if ( typeof window.innerHeight != 'undefined' )
        ww = window.innerHeight;  // NN and Opera version
      else
      {
        if ( d.documentElement && typeof d.documentElement.clientHeight!='undefined' && d.documentElement.clientHeight != 0 )
          ww = d.documentElement.clientHeight;
        else
          if ( d.body && typeof d.body.clientHeight != 'undefined' )
            ww = d.body.clientHeight;
      }
      
      return ww;
    }
    
    function setObjectWidth(obj, iw, ih)
    {
      var ww = getWindowWidth()*widthFactor;
      var wh = getWindowHeight()*heightFactor;
      
      if(ww < iw || wh < ih)
      {
        if(iw/ww < ih/wh)
          obj.width = iw * wh/ih;
        else
          obj.width = ww;
      }
      else
      {
        obj.width = iw;
      }
      if(ww < iw || wh < ih)
      {
        if(iw/ww < ih/wh)
          obj.height = wh;
        else
          obj.height = ih*ww/iw;
      }
      else
      {
        obj.height = iw;
      }
    }

    function toggleListeningImage(buttonId, imageId)
    {
      var image = document.getElementById(imageId);
      var button = document.getElementById(buttonId);
      if (image && button)
      {
        image.style.setAttribute("display", "block", false);
        button.style.setAttribute("display", "none", false);
      }
    }
    
    function playAudio(id)
    {
      var audio = document.getElementById(id);
      if (audio)
      {
        if (isWMP7)
        {
          audio.controls.play();
        }
        else
        {
          audio.Play();
        }
      }
    }
    
    function playVideo(button)
    {
      var video = document.getElementById('video');
      var videoDiv = document.getElementById('videoDIV');
      if (video && videoDiv)
      {
        setObjectWidth(video,1920,1440);
        videoDiv.style.display = 'block';
        if (isWMP7)
        {
          video.controls.play();
        }
        else
        {
          video.Play();
        }
        button.style.display = 'none';
      }
    }
    
    function prepareMediaPlayer(id, url, volume, autostart, isVideo)
    {
      if ( isWMP7 )
      {
         if (mpVer < 9) url = url.replace(/file:\/\/\//, 'file://');  //a work-around for MP 7-8 as it does not read file URIs correctly
         document.write ('<OBJECT ID="' + id + '" ');
         document.write (' CLASSID=CLSID:6BF52A52-394A-11D3-B153-00C04F79FAA6');
         document.write (' TYPE="application/x-oleobject" width="1" height="1"');
         if (isVideo)
           document.write (' EnablePositionControls="false" onLoad="setObjectWidth(this,1920,1440);"');
         document.write ('>');
         document.write ('<PARAM NAME="url" VALUE="' + url + '">');
         document.write ('<PARAM NAME="Volume" VALUE="' + volume + '">');
         document.write ('<PARAM NAME="AutoStart" VALUE="' + autostart + '">');
         if (!isVideo)
           document.write ('<PARAM NAME="uiMode" VALUE="invisible">');
         document.write ('<PARAM NAME="ShowControls" VALUE="false">');
         document.write ('</OBJECT>');
      }
      else
      {
         document.write ('<OBJECT ID="' + id + '" ');
         document.write ('CLASSID=CLSID:22d6f312-b0f6-11d0-94ab-0080c74c7e95 ');
         document.write ('TYPE="application/x-oleobject" width="1" height="1"');
         if (isVideo)
           document.write (' EnablePositionControls="false" onLoad="setObjectWidth(this,1920,1440);"');
         document.write ('>');
         document.write ('<PARAM NAME="FileName" VALUE="' + url + '">');
         document.write ('<PARAM NAME="Volume" VALUE="' + volume + '">');
         document.write ('<PARAM NAME="AutoStart" VALUE="' + autostart + '">');
         document.write ('<PARAM NAME="ShowControls" VALUE="false">');
         document.write ('</OBJECT>');
      }
    }
    
    function init()
    {
      var pic = document.getElementById('mainImage');
      var vid = document.getElementById('video');
      onWindowResize(pic, vid);
    }
    
    window.onload = init;
]]></xsl:text>
  </xsl:template>
</xsl:stylesheet>