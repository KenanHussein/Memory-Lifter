<?xml version='1.0' encoding='utf-16'?>
<!--  (c) 2006 LearnLift   -->
<!--  MemoryLifter Stylesheet   -->
<!--  Version 2.0 Date: 2007-10-08   -->
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:CardObject="urn:cardobject"
	exclude-result-prefixes="CardObject">

  <xsl:template name="jquery-timer">
    <xsl:text disable-output-escaping="yes"><![CDATA[
/*
 *
 *	jQuery Timer plugin v0.1
 *		Matt Schmidt [http://www.mattptr.net]
 *
 *	Licensed under the BSD License:
 *		http://mattptr.net/license/license.txt
 *
 */
 
 jQuery.timer = function (interval, callback)
 {
 /**
  *
  * timer() provides a cleaner way to handle intervals  
  *
  *	@usage
  * $.timer(interval, callback);
  *
  *
  * @example
  * $.timer(1000, function (timer) {
  * 	alert("hello");
  * 	timer.stop();
  * });
  * @desc Show an alert box after 1 second and stop
  * 
  * @example
  * var second = false;
  *	$.timer(1000, function (timer) {
  *		if (!second) {
  *			alert('First time!');
  *			second = true;
  *			timer.reset(3000);
  *		}
  *		else {
  *			alert('Second time');
  *			timer.stop();
  *		}
  *	});
  * @desc Show an alert box after 1 second and show another after 3 seconds
  *
  * 
  */

	var interval = interval || 100;

	if (!callback)
		return false;
	
	_timer = function (interval, callback) {
		this.stop = function () {
			clearInterval(self.id);
		};
		
		this.internalCallback = function () {
			callback(self);
		};
		
		this.reset = function (val) {
			if (self.id)
				clearInterval(self.id);
			
			var val = val || 100;
			this.id = setInterval(this.internalCallback, val);
		};
		
		this.interval = interval;
		this.id = setInterval(this.internalCallback, this.interval);
		
		var self = this;
	};
	
	return new _timer(interval, callback);
 };
 ]]></xsl:text>
  </xsl:template>
</xsl:stylesheet>