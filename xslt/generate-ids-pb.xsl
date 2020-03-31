<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:t="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs t"
    version="2.0">
    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
    <xsl:strip-space elements="*"/>
    
    
    <xsl:template match="*|@*|text()">
        <xsl:copy>
            <xsl:apply-templates select="*|@*|text()"/>
        </xsl:copy>
    </xsl:template>
    
   <!-- Für Passau-->
    <!--<xsl:template match="t:pb">
        <xsl:copy>
            <xsl:attribute name="n">
                <xsl:value-of select="./@n"></xsl:value-of>
            </xsl:attribute>
            <xsl:attribute name="xml:id">
                <xsl:choose>
                 <xsl:when test="string-length(./@n)=2">
                    <xsl:text>SP.00</xsl:text><xsl:value-of select="./@n"></xsl:value-of>
                </xsl:when>
                    <xsl:when test="string-length(./@n)=3">
                        <xsl:text>SP.0</xsl:text><xsl:value-of select="./@n"></xsl:value-of>
                    </xsl:when>
                <xsl:otherwise>
                    <xsl:text>SP.</xsl:text><xsl:value-of select="./@n"></xsl:value-of>
                </xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>
        </xsl:copy>
    </xsl:template>-->
     
    <!-- Für Brixen-->
   <!-- <xsl:template match="t:pb">
        <xsl:copy>
            <xsl:attribute name="n">
                <xsl:value-of select="./@n"></xsl:value-of>
            </xsl:attribute>
            <xsl:attribute name="xml:id">
                <xsl:choose>
                    <xsl:when test="string-length(./@n)=2">
                        <xsl:text>BRI.00</xsl:text><xsl:value-of select="./@n"></xsl:value-of>
                    </xsl:when>
                    <xsl:when test="string-length(./@n)=3">
                        <xsl:text>BRI.0</xsl:text><xsl:value-of select="./@n"></xsl:value-of>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>BRI.</xsl:text><xsl:value-of select="./@n"></xsl:value-of>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>
        </xsl:copy>
    </xsl:template>-->
    
   <!-- Für Freising-->
   <!-- <xsl:template match="t:pb">
        <xsl:copy>
            <xsl:attribute name="n">
                <xsl:value-of select="./@n"></xsl:value-of>
            </xsl:attribute>
            <xsl:attribute name="xml:id">
                <xsl:choose>
                    <xsl:when test="string-length(./@n)=2">
                        <xsl:text>FREI.00</xsl:text><xsl:value-of select="./@n"></xsl:value-of>
                    </xsl:when>
                    <xsl:when test="string-length(./@n)=3">
                        <xsl:text>FREI.0</xsl:text><xsl:value-of select="./@n"></xsl:value-of>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>FREI.</xsl:text><xsl:value-of select="./@n"></xsl:value-of>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>
        </xsl:copy>
    </xsl:template>-->
    
    <!-- Für Seckau3-->
<!--    <xsl:template match="t:pb">
        <xsl:copy>
            <xsl:attribute name="n">
                <xsl:value-of select="./@n"></xsl:value-of>
            </xsl:attribute>
            <xsl:attribute name="xml:id">
                <xsl:choose>
                    <xsl:when test="string-length(./@n)=2">
                        <xsl:text>SEC3.00</xsl:text><xsl:value-of select="./@n"></xsl:value-of>
                    </xsl:when>
                    <xsl:when test="string-length(./@n)=3">
                        <xsl:text>SEC3.0</xsl:text><xsl:value-of select="./@n"></xsl:value-of>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>SEC3.</xsl:text><xsl:value-of select="./@n"></xsl:value-of>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>
        </xsl:copy>
    </xsl:template>-->
    
    <!--  Für Regensburg-->
  <!--  <xsl:template match="t:pb">
        <xsl:copy>
            <xsl:attribute name="n">
                <xsl:value-of select="./@n"></xsl:value-of>
            </xsl:attribute>
            <xsl:attribute name="xml:id">
                <xsl:choose>
                    <xsl:when test="string-length(./@n)=2">
                        <xsl:text>REG.00</xsl:text><xsl:value-of select="./@n"></xsl:value-of>
                    </xsl:when>
                    <xsl:when test="string-length(./@n)=3">
                        <xsl:text>REG.0</xsl:text><xsl:value-of select="./@n"></xsl:value-of>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>REG.</xsl:text><xsl:value-of select="./@n"></xsl:value-of>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>
        </xsl:copy>
    </xsl:template>-->
    
     <!-- for mengotus (stnikola)-->
    <xsl:template match="t:pb">
        <xsl:copy>
            <xsl:attribute name="n">
                <xsl:value-of select="./@n"></xsl:value-of>
            </xsl:attribute>
            <xsl:attribute name="xml:id">
                <xsl:choose>
                    <xsl:when test="string-length(./@n)=2">
                        <xsl:text>VOR.00</xsl:text><xsl:value-of select="./@n"></xsl:value-of>
                    </xsl:when>
                    <xsl:when test="string-length(./@n)=3">
                        <xsl:text>VOR.0</xsl:text><xsl:value-of select="./@n"></xsl:value-of>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>VOR.</xsl:text><xsl:value-of select="./@n"></xsl:value-of>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>
        </xsl:copy>
    </xsl:template>
    
    <!--Für emmeram-->
    <!--<xsl:template match="t:pb">
        <xsl:copy>
            <xsl:attribute name="n">
                <xsl:value-of select="./@n"></xsl:value-of>
            </xsl:attribute>
            <xsl:attribute name="xml:id">
                <xsl:choose>
                    <xsl:when test="string-length(./@n)=2">
                        <xsl:value-of select="//t:witDetail/@wit"/><xsl:text>.00</xsl:text><xsl:value-of select="./@n"></xsl:value-of>
                    </xsl:when>
                    <xsl:when test="string-length(./@n)=3">
                        <xsl:value-of select="//t:witDetail/@wit"/><xsl:text>.0</xsl:text><xsl:value-of select="./@n"></xsl:value-of>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="//t:witDetail/@wit"/><xsl:text>.</xsl:text><xsl:value-of select="./@n"></xsl:value-of>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>
        </xsl:copy>
    </xsl:template>-->
</xsl:stylesheet>