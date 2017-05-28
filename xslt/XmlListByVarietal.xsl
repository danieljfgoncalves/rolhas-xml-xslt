<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:r="xml.lprog.isep.pt/rolhas"
                xmlns:tn="xml.lprog.isep.pt/tastingNotes">
    <xsl:output method="xml" indent="yes"/>

    <!-- GROUP KEYS -->
    <xsl:key name="varietalGroup" match="r:varietal" use="self::*"/>
    <xsl:key name="wineGroup" match="r:wine" use="r:technical_sheet/r:varietal"/>

    <xsl:template match="r:o_rolhas">
        <xsl:copy>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="r:wines">
        <xsl:copy>
            <xsl:attribute name="count">
                <xsl:value-of select="count(r:wine)"/>
            </xsl:attribute>
            <xsl:apply-templates select="//r:varietal[generate-id(.) = generate-id(key('varietalGroup', self::*))]"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="r:varietal">
        <xsl:copy>
            <xsl:attribute name="name">
                <xsl:value-of select="self::*"/>
            </xsl:attribute>
            <xsl:apply-templates select="key('wineGroup', self::*)"/>
        </xsl:copy>

    </xsl:template>

    <xsl:template match="r:wine|r:tasting_notes">
        <xsl:copy-of select="self::*"/>
    </xsl:template>

</xsl:stylesheet>