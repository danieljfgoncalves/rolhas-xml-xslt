<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:r="xml.lprog.isep.pt/rolhas">
    <xsl:output method="xml" indent="yes"
                doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
                doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"/>
    <!-- GLOBAL PARAMS & VARS-->
    <xsl:param name="priceLimitParam" select="10"/>
    <xsl:param name="alchoolContentBelowLimitParam" select="10"/>
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
                    <p id="hero-lead">
                        the
                        <kbd class="strong" style="margin-right: 5px;">
                            <b>best</b>
                        </kbd>
                        wine selection.
                    </p>
                </div>
                <div id="kube-features">
                    <!-- TABLE -->
                    <div class="row align-center align-middle hero-lead">
                        <table class="bordered">
                            <thead style="background-color: rgba(140,4,74, 0.85);color: #FFF;">
                                <tr>
                                    <th class="text-center" rowspan="2">Label</th>
                                    <th class="text-center" rowspan="2">Name</th>
                                    <th class="text-center" rowspan="2">Price</th>
                                    <th class="text-center" rowspan="2">Producer</th>
                                    <th class="text-center" colspan="2">Origin</th>
                                    <th class="text-center" rowspan="2">Varietal</th>
                                    <th class="text-center" rowspan="2">Style</th>
                                    <th class="text-center" rowspan="2">More Info</th>
                                </tr>
                                <tr>
                                    <th class="text-center">Country</th>
                                    <th class="text-center">Region</th>
                                </tr>
                            </thead>
                            <tbody>
                                <!-- LIST WINES -->
                                <xsl:apply-templates
                                        select="r:wines/r:wine[r:price&lt;$priceLimitParam][r:technical_sheet/r:alchool_content&gt;$alchoolContentBelowLimitParam]"/>
                                <tr>
                                    <td colspan="9">
                                        <b class="upper">Available Wines:</b>
                                        <kbd style="margin-left: 5px;">
                                            <xsl:value-of
                                                    select="count(r:wines/r:wine[r:price&lt;$priceLimitParam][r:technical_sheet/r:alchool_content&gt;$alchoolContentBelowLimitParam])"/>
                                        </kbd>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
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
        <tr>
            <td class="text-center" style="vertical-align: middle;">
                <xsl:call-template name="rowImage">
                    <xsl:with-param name="source" select="r:image/@thumb"/>
                    <xsl:with-param name="alt" select="r:name"/>
                </xsl:call-template>
            </td>
            <td class="text-center strong large" style="vertical-align: middle;">
                <xsl:value-of select="r:name"/>
            </td>
            <td class="text-center" style="vertical-align: middle;">
                <xsl:choose>
                    <xsl:when test="r:price&gt;'10'">
                        <samp style="background:#F5A2A2">
                            <xsl:value-of select="r:price"/>
                            <xsl:apply-templates select="r:price/@currency"/>
                        </samp>
                    </xsl:when>
                    <xsl:when test="r:price&lt;'5'">
                        <samp style="background:#82BFA0">
                            <xsl:value-of select="r:price"/>
                            <xsl:apply-templates select="r:price/@currency"/>
                        </samp>
                    </xsl:when>
                    <xsl:otherwise>
                        <samp>
                            <xsl:value-of select="r:price"/>
                            <xsl:apply-templates select="r:price/@currency"/>
                        </samp>
                    </xsl:otherwise>
                </xsl:choose>
            </td>
            <td class="text-center" style="vertical-align: middle;">
                <xsl:value-of select="r:producer"/>
            </td>
            <xsl:apply-templates select="r:origin"/>
            <td class="text-center" style="vertical-align: middle;">
                <b>
                    <xsl:value-of select="r:technical_sheet/r:varietal"/>
                </b>
            </td>
            <td class="text-center" style="vertical-align: middle;">
                <kbd>
                    <xsl:value-of select="r:technical_sheet/r:style"/>
                </kbd>
            </td>
            <td style="vertical-align: middle;">
                <button data-component="toggleme" data-target="#{@reference}-target" data-text="hide">
                    <i class="kube-menu"/>
                </button>
            </td>
        </tr>
        <tr id="{@reference}-target" class="hide">
            <td colspan="9" class="text-center" style="vertical-align: middle;">
                <mark style="vertical-align: middle;">
                    <b>alcohol content:</b>
                    <xsl:value-of select="r:technical_sheet/r:alchool_content"/> %
                </mark>
                <samp style="vertical-align: middle;">
                    <b>sweetness:</b>
                    <xsl:value-of select="r:technical_sheet/r:sweetness/r:sweetness_content"/>
                    <xsl:value-of
                            select="concat(' ',r:technical_sheet/r:sweetness/r:sweetness_content/@unit, ' &#x2022; ')"/>
                    <xsl:value-of select="r:technical_sheet/r:sweetness/r:sweetness_descriptor/@designation"/>
                </samp>
                <kbd style="vertical-align: middle;">
                    <b>package:</b>
                    <xsl:value-of select="concat(r:package, ' ', r:package/@unit, ' ')"/>
                    <xsl:value-of select="r:package/@type"/>
                </kbd>
            </td>
        </tr>
    </xsl:template>
    <!-- ORIGIN -->
    <xsl:template match="r:origin">
        <!-- LOCAL VARIABLE -->
        <xsl:variable name="acronymVar" select="r:country/@acronym"/>

        <td class="text-center" style="vertical-align: middle;">
            <xsl:value-of select="r:country"/>
            <span class="highlight float-right">[<xsl:value-of select="$acronymVar"/>]
            </span>
        </td>
        <td class="text-center" style="vertical-align: middle;">
            <xsl:if test="r:region">
                <xsl:value-of select="r:region"/>
            </xsl:if>
            <xsl:if test="not(r:region)">Not Specified</xsl:if>
        </td>
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

    <!-- IMAGE -->
    <xsl:template name="rowImage">
        <xsl:param name="source"/>
        <xsl:param name="alt"/>
        <img src="{concat('../', $source)}" alt="{$alt}" style="max-width: 100px;"/>
    </xsl:template>

</xsl:stylesheet>