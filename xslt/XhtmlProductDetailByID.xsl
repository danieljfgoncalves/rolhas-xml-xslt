<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:r="xml.lprog.isep.pt/rolhas"
                xmlns:tn="xml.lprog.isep.pt/tastingNotes">
    <xsl:output method="xml" indent="yes"
                doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
                doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"/>
    <!-- GLOBAL PARAMS & VARS-->
    <xsl:param name="idParam" select="286195"/>
    <!-- MAIN TEMPLATE -->
    <xsl:template match="r:o_rolhas">
        <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
            <head>
                <title>O'Rolhas Winery</title>
                <!-- Kube CSS -->
                <link rel="stylesheet" type="text/css" href="../resources/css/kube.min.css"/>
                <link rel="stylesheet" type="text/css" href="../resources/css/master.css"/>
                <!-- Kube JS + jQuery are used for some functionality, but are not required for the basic setup -->
                <script src="../resources/js/jquery-2.0.3.min.js" type="text/javascript"/>
                <script src="../resources/js/kube.js" type="text/javascript"/>
                <meta name="viewport" content="width=device-width, initial-scale=1"/>
            </head>
            <body>
                <!-- TITLE -->
                <div id="hero">
                    <img class="w10" src="{concat('../', @logo)}" alt="{'logo'}"/>
                    <h1 class="w-auto">O'Rolhas Winery</h1>
                    <p id="hero-lead" class="w-auto">
                        <xsl:value-of select="r:wines/r:wine[@reference=$idParam]/r:name"/>
                    </p>
                    <kbd class="w-auto" style="margin-top: 10px;">
                        <xsl:text>reference: </xsl:text>
                        <xsl:value-of select="r:wines/r:wine[@reference=$idParam]/@reference"/>
                    </kbd>
                    <xsl:if test="r:wines/r:wine[@reference=$idParam]/@tasting_note_id">
                        <xsl:variable name="tastingNoteId" select="r:wines/r:wine[@reference=$idParam]/@tasting_note_id"/>
                        <p>
                            <xsl:value-of select="r:tasting_notes/tn:tasting_note[@id=$tastingNoteId]"/>
                        </p>
                    </xsl:if>
                </div>
                <div class="row align-center">
                    <!-- DO DETAIL -->
                    <div style="border: 1px solid rgba(0, 0, 0, 0.07);padding: 32px;margin-bottom: 16px;">
                        <xsl:apply-templates select="r:wines/r:wine[@reference=$idParam]"/>
                    </div>
                </div>
                <!-- FOOTER -->
                <b class=""/>
                <div id="footer">
                    <p>&#x24B8; 2017 | LPROG &#x2022; ISEP &#x2022; 2DD</p>
                    <p class="push-right">Daniel Gonçalves <kbd class="strong" style="margin-right: 5px;">1151452</kbd>&#x2022;
                        Eric Amaral
                        <kbd class="strong">1141570</kbd>
                    </p>
                </div>
            </body>
        </html>
    </xsl:template>

    <!-- EXTRA TEMPLATES -->
    <!-- WINE -->
    <xsl:template match="r:wines/r:wine">
        <div class="row gutters around" style="width: 1000px;">
            <div class="col col-6">
                <xsl:call-template name="rowImage">
                    <xsl:with-param name="source" select="r:image/@thumb"/>
                    <xsl:with-param name="alt" select="r:name"/>
                </xsl:call-template>
            </div>
            <div class="col col-6">
                <div class="row align-left" style="padding-bottom:10px;">
                    <xsl:call-template name="genericLabel">
                        <xsl:with-param name="title" select="'Name:'"/>
                        <xsl:with-param name="value" select="r:name"/>
                    </xsl:call-template>
                </div>
                <div class="row align-left" style="padding-bottom:10px;">
                    <xsl:call-template name="genericLabel">
                        <xsl:with-param name="title" select="'Producer:'"/>
                        <xsl:with-param name="value" select="r:producer"/>
                    </xsl:call-template>
                </div>
                <div class="row align-left" style="padding-bottom:10px;">
                    <xsl:variable name="originString">
                        <xsl:choose>
                            <xsl:when test="r:origin/r:region">
                                <xsl:value-of select="concat(r:origin/r:region, ', ', r:origin/r:country)"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="r:origin/r:country"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:variable>
                    <xsl:call-template name="genericLabel">
                        <xsl:with-param name="title" select="'Origin:'"/>
                        <xsl:with-param name="value" select="$originString"/>
                    </xsl:call-template>
                </div>
                <div class="row align-left" style="padding-bottom:10px;">
                    <xsl:call-template name="genericLabel">
                        <xsl:with-param name="title" select="'Pacakge:'"/>
                        <xsl:with-param name="value" select="concat(r:package,' ', r:package/@unit)"/>
                    </xsl:call-template>
                    <code style="margin-left:5px;">
                        <xsl:value-of select="r:package/@type"/>
                    </code>
                </div>
                <div class="row align-left"
                     style="border: 1px solid rgba(0, 0, 0, 0.07);padding: 15px;margin-bottom: 16px;">
                    <div class="col col-12">
                        <div class="row" style="margin-bottom:16px;">
                            <div class="col col-12">
                                <mark>
                                    <h6 style="margin-bottom:0px;">
                                        <xsl:text>Technical Sheet:</xsl:text>
                                    </h6>
                                </mark>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col col-12">
                                <xsl:call-template name="genericLabel">
                                    <xsl:with-param name="title" select="'Alcohol Content:'"/>
                                    <xsl:with-param name="value" select="r:technical_sheet/r:alchool_content"/>
                                </xsl:call-template>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col col-12">
                                <xsl:call-template name="genericLabel">
                                    <xsl:with-param name="title" select="'Sweetness:'"/>
                                    <xsl:with-param name="value"
                                                    select="concat(r:technical_sheet/r:sweetness/r:sweetness_content, ' ',
                                                r:technical_sheet/r:sweetness/r:sweetness_content/@unit)"/>
                                </xsl:call-template>
                                <samp>
                                    <xsl:value-of select="concat(r:technical_sheet/r:sweetness/r:sweetness_descriptor/@acronym, ' - ',
                                                r:technical_sheet/r:sweetness/r:sweetness_descriptor/@designation)"/>
                                </samp>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col col-12">
                                <xsl:call-template name="genericLabel">
                                    <xsl:with-param name="title" select="'Varietal:'"/>
                                    <xsl:with-param name="value" select="r:technical_sheet/r:varietal"/>
                                </xsl:call-template>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col col-12">
                                <xsl:call-template name="genericLabel">
                                    <xsl:with-param name="title" select="'Style:'"/>
                                    <xsl:with-param name="value" select="r:technical_sheet/r:style"/>
                                </xsl:call-template>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row align-right">
                    <div class="col col-4 text-right">
                        <xsl:choose>
                            <xsl:when test="r:price&gt;'10'">
                                <samp class="large" style="background:#F5A2A2;padding: 20px;">
                                    <xsl:value-of select="r:price"/>
                                    <xsl:apply-templates select="r:price/@currency"/>
                                </samp>
                            </xsl:when>
                            <xsl:when test="r:price&lt;'5'">
                                <samp class="large" style="background:#82BFA0;padding: 20px;">
                                    <xsl:value-of select="r:price"/>
                                    <xsl:apply-templates select="r:price/@currency"/>
                                </samp>
                            </xsl:when>
                            <xsl:otherwise>
                                <samp class="large" style="padding: 20px;">
                                    <xsl:value-of select="r:price"/>
                                    <xsl:apply-templates select="r:price/@currency"/>
                                </samp>
                            </xsl:otherwise>
                        </xsl:choose>
                    </div>
                </div>
            </div>
        </div>
    </xsl:template>
    <!-- CURRENCY -->
    <xsl:template match="r:price/@currency">
        <span style="margin-left: 5px;">
            <xsl:choose>
                <xsl:when test=".='euro'">
                    <xsl:value-of select="'&#x20AC;'"/>
                </xsl:when>
                <xsl:when test=".='pound'">
                    <xsl:value-of select="'&#x20A4;'"/>
                </xsl:when>
                <xsl:when test=".='dollar'">
                    <xsl:value-of select="'&#36;'"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="."/>
                </xsl:otherwise>
            </xsl:choose>
        </span>
    </xsl:template>

    <!-- GENERIC LABEL -->
    <xsl:template name="genericLabel">
        <xsl:param name="title"/>
        <xsl:param name="value"/>
        <kbd class="strong" style="margin-right:5px;">
            <xsl:value-of select="$title"/>
        </kbd>
        <span>
            <xsl:value-of select="$value"/>
        </span>
    </xsl:template>
    <!-- IMAGE -->
    <xsl:template name="rowImage">
        <xsl:param name="source"/>
        <xsl:param name="alt"/>
        <img src="{concat('../', $source)}" alt="{$alt}" style="max-width: 750px;display:block;
    margin:auto;"/>
    </xsl:template>

</xsl:stylesheet>