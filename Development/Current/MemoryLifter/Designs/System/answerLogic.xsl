<?xml version='1.0' encoding='utf-16'?>
<!--  (c) 2006 LearnLift   -->
<!--  MemoryLifter Stylesheet   -->
<!--  Version 2.0 Date: 2007-10-08   -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                 xmlns:CardObject="urn:cardobject" exclude-result-prefixes="CardObject">
  <xsl:include href="../System/blockLogic.xsl"/>
  <xsl:include href="../System/wordmodeLogic.xsl"/>
  <xsl:include href="../System/sentencemodeLogic.xsl"/>
  <xsl:include href="../System/listeningmodeLogic.xsl"/>
  <xsl:include href="../System/imagemodeLogic.xsl"/>

  <xsl:template name="card">
    <xsl:param name="class" select="'answerWrong'"/>

    <body class="answer {$class}" onResize="onWindowResize(document.getElementById('mainImage'),document.getElementById('video'))" onLoad="onWindowResize(document.getElementById('mainImage'),document.getElementById('video'))">
      <div id="main">

        <xsl:if test="$slideshowMode = 'false'">
          <div id="feedback">
            <!-- Apply feedback div correct / wrong class -->
            <xsl:choose>
              <xsl:when test="$correct = 'true'">
                <xsl:attribute name="class">
                  <xsl:text>feedbackCorrect</xsl:text>
                </xsl:attribute>
              </xsl:when>
              <xsl:otherwise>
                <xsl:attribute name="class">
                  <xsl:text>feedbackWrong</xsl:text>
                </xsl:attribute>
              </xsl:otherwise>
            </xsl:choose>

            <div id="closeBar">
              <!-- Apply closeBar correct / wrong class -->
              <xsl:choose>
                <xsl:when test="$correct = 'true'">
                  <xsl:attribute name="class">
                    <xsl:text>closebarCorrect</xsl:text>
                  </xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:attribute name="class">
                    <xsl:text>closebarWrong</xsl:text>
                  </xsl:attribute>
                </xsl:otherwise>
              </xsl:choose>

              <button onClick="document.getElementById('feedback').style.display = 'none'">
                <xsl:attribute name="onMouseOver">
                  <xsl:text>document.getElementById('closeButtonImage').src = '</xsl:text>
                  <xsl:value-of select="$stylePath"/>
                  <xsl:text>closeButtonHover.gif'</xsl:text>
                </xsl:attribute>
                <xsl:attribute name="onMouseOut">
                  <xsl:text>document.getElementById('closeButtonImage').src = '</xsl:text>
                  <xsl:value-of select="$stylePath"/>
                  <xsl:text>closeButton.gif'</xsl:text>
                </xsl:attribute>
                <img id="closeButtonImage">
                  <xsl:attribute name="src">
                    <xsl:value-of select="$stylePath"/>
                    <xsl:text>closeButton.gif</xsl:text>
                  </xsl:attribute>
                </img>
              </button>
            </div>
            <table>
              <tr>
                <td>
                  <img>
                    <xsl:choose>
                      <xsl:when test="$correct = 'true'">
                        <xsl:attribute name="id">
                          <xsl:text>feedbackImageCorrect</xsl:text>
                        </xsl:attribute>
                        <xsl:attribute name="src">
                          <xsl:value-of select="$stylePath"/>
                          <xsl:text>feedbackCorrect.gif</xsl:text>
                        </xsl:attribute>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:attribute name="id">
                          <xsl:text>feedbackImageWrong</xsl:text>
                        </xsl:attribute>
                        <xsl:attribute name="src">
                          <xsl:value-of select="$stylePath"/>
                          <xsl:text>feedbackWrong.gif</xsl:text>
                        </xsl:attribute>
                      </xsl:otherwise>
                    </xsl:choose>
                  </img>
                </td>
                <td>
                  <xsl:if test="($class != 'answerCorrect' and normalize-space($userAnswer) != '' and normalize-space($userAnswer) != $nothing) or CardObject:CheckSynonyms($userAnswer) = 'false'">
                    <div id="userInputBox">
                      <span id="youEnteredText"><xsl:value-of select="$youEnteredText"/></span>
                      <div id="userInput" dir="{CardObject:GetTextDirection($side)}">
                        <xsl:value-of select="CardObject:ColorSynonyms($userAnswer, 'question')" disable-output-escaping="yes"/>
                      </div>
                    </div>
                  </xsl:if>

                  <div id="feedbackMessage">
                    <xsl:choose>
                      <xsl:when test="$class = 'answerWrong' or CardObject:CheckSynonyms($userAnswer) = 'false'">
                        <span id="correctAnswerText"><xsl:value-of select="$correctAnswerText"/></span>
                        <div dir="{CardObject:GetTextDirection($side)}">
                          <xsl:value-of select="CardObject:ColorSynonyms($userAnswer, 'answer')" disable-output-escaping="yes"/>
                        </div>
                      </xsl:when>
                      <xsl:when test="$class = 'answerCorrect'">
                        <xsl:value-of select="$correctFeedbackText"/>
                        <br/>
                      </xsl:when>
                    </xsl:choose>
                  </div>
                </td>
              </tr>
            </table>
            <!-- Hide promote/demote message when only learning one box or in a maintain dialog -->
            <xsl:if test="$learningBox = 0 and $cardBox != 0">
              <div id="boxMessage">
                <xsl:choose>
                  <xsl:when test="$selfAssessmentMode = 'false'">
                    <xsl:choose>
                      <xsl:when test="$promoted = 'true'">
                        <xsl:value-of select="$promotedMessage"/>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:value-of select="$demotedMessage"/>
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:choose>
                      <xsl:when test="$promoted = 'true'">
                        <xsl:value-of select="$selfassesmentPromotedMessage"/>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:value-of select="$selfassesmentDemotedMessage"/>
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:otherwise>
                </xsl:choose>
              </div>
            </xsl:if>
          </div>
        </xsl:if>
        <div id="correctAnswerBox">
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
      <p />
    </body>
  </xsl:template>
</xsl:stylesheet>