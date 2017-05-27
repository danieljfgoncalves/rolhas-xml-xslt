<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:r="xml.lprog.isep.pt/rolhas">
    <xsl:output method="text"/>
    <!-- GLOBAL PARAMS & VARS-->
    <xsl:param name="countryParam" select="'undefined'"/>
    <xsl:param name="acronymParam" select="'undefined'"/>
    <!-- MAIN TEMPLATE -->
    <xsl:template match="r:o_rolhas">
        <xsl:variable name="countryVar">
            <xsl:choose>
                <xsl:when test="$countryParam='undefined' and not($acronymParam='undefined')">
                    <xsl:value-of select="r:wines/r:wine/r:origin/r:country[@acronym=$acronymParam]"/>
                </xsl:when>
                <xsl:when test="not($countryParam='undefined')">
                    <xsl:value-of select="$countryParam"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="'Portugal'"/> <!-- DEFAULT VALUE -->
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:text>O'Rolhas Winery</xsl:text>
        <xsl:call-template name="border">
            <xsl:with-param name="length" select="'16'"/>
            <xsl:with-param name="startEndSymbol" select="'*'"/>
        </xsl:call-template>
        <xsl:call-template name="border">
            <xsl:with-param name="length" select="'27'"/>
            <xsl:with-param name="startEndSymbol" select="'*'"/>
        </xsl:call-template>
        <xsl:text>2017 | LPROG &#x2022; ISEP &#x2022; 2DD&#xD;&#xA;Daniel Gonçalves [ 1151452 ]&#xD;&#xA;Eric Amaral [ 1141570 ]</xsl:text>
        <xsl:call-template name="border">
            <xsl:with-param name="length" select="'27'"/>
            <xsl:with-param name="startEndSymbol" select="'*'"/>
        </xsl:call-template>
        <xsl:text>&#xD;&#xA;</xsl:text> <!-- LINE FEED -->
        <xsl:text>WINES</xsl:text>
        <xsl:text>&#xD;&#xA;</xsl:text> <!-- LINE FEED -->
        <xsl:text>&#xD;&#xA;</xsl:text> <!-- LINE FEED -->
        <xsl:text>COUNTRY: </xsl:text>
        <xsl:value-of select="$countryVar"/>
        <xsl:text>&#xD;&#xA;</xsl:text> <!-- LINE FEED -->
        <xsl:apply-templates select="r:wines/r:wine[r:origin/r:country=$countryVar]"/>
    </xsl:template>

    <!-- EXTRA TEMPLATES -->
    <xsl:template match="r:wines/r:wine">
        <xsl:call-template name="border">
            <xsl:with-param name="length" select="'118'"/>
            <xsl:with-param name="startEndSymbol" select="'+'"/>
        </xsl:call-template>
        <xsl:text>&#xD;&#xA;</xsl:text>
        <xsl:for-each select="@*">
            <xsl:value-of select="concat('[',name(), ': ', .,'] ')"/>
        </xsl:for-each>
        <xsl:text>&#xD;&#xA;</xsl:text>
        <xsl:call-template name="printElements">
            <xsl:with-param name="root" select="self::*"/>
        </xsl:call-template>
        <xsl:call-template name="border">
            <xsl:with-param name="length" select="'118'"/>
            <xsl:with-param name="startEndSymbol" select="'+'"/>
        </xsl:call-template>
    </xsl:template>
    <!-- RECURSIVE PRINT ELEMENTS -->
    <xsl:template name="printElements">
        <xsl:param name="root"/>
        <xsl:for-each select="$root/*">
            <xsl:choose>
                <xsl:when test="descendant::*">
                    <xsl:for-each select="self::*">
                        <xsl:call-template name="printElements">
                            <xsl:with-param name="root" select="self::*"/>
                        </xsl:call-template>
                    </xsl:for-each>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:if test="not(name()='country')">
                        <xsl:value-of select="concat(name(), ' : ', ., ' ')"/>
                        <xsl:for-each select="@*">
                            <xsl:value-of select="concat('[',name(), ': ', .,'] ')"/>
                        </xsl:for-each>
                        <xsl:text>&#xD;&#xA;</xsl:text>
                    </xsl:if>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:for-each>
    </xsl:template>
    <!-- BUILD BORDER -->
    <xsl:template name="border">
        <xsl:param name="startEndSymbol"/>
        <xsl:param name="length"/>
        <xsl:text>&#xD;&#xA;</xsl:text>
        <xsl:value-of select="$startEndSymbol"/>
        <xsl:call-template name="repeater">
            <xsl:with-param name="num" select="$length"/>
            <xsl:with-param name="symbol" select="'-'"/>
        </xsl:call-template>
        <xsl:value-of select="$startEndSymbol"/>
        <xsl:text>&#xD;&#xA;</xsl:text>
    </xsl:template>
    <!-- RECURSIVE REPEATER -->
    <xsl:template name="repeater">
        <xsl:param name="symbol"/>
        <xsl:param name="num"/>
        <xsl:choose>
            <xsl:when test="$num > 0">
                <xsl:value-of select="$symbol"/>
                <xsl:call-template name="repeater">
                    <xsl:with-param name="symbol" select="$symbol"/>
                    <xsl:with-param name="num" select="$num - 1"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise/>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>