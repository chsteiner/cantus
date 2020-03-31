<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:t="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs t">
    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
    <xsl:strip-space elements="*"/>
   
    <xsl:param name="ids"
        select="document('file:///Z:/CANTUS/2018/git/cantus.git/trunk/all_horae/all_horae_regensburg_reg2.xml')"/>
    
    <xsl:key name="grp" match="t:ab[@ana='#head']/t:label" use="normalize-space(.)"/>
    <xsl:key name="id" match="t:row" use="t:cell[1]"/>
    
    
    <!-- identity transform -->
    <xsl:template match="@* | node() | text() | *">
        <xsl:copy>
            <xsl:apply-templates select="@* | node() | text() | *"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="t:ab[@ana='#head']/t:label">     
        <xsl:copy>
            <xsl:variable name="i" select="index-of(key('grp', normalize-space(.))/generate-id(), generate-id())"/>       
            <xsl:attribute name="n">
                <xsl:value-of select="normalize-space(key('id', normalize-space(.), $ids)/t:cell[2])"/>
            </xsl:attribute>
            <xsl:apply-templates select="@* | node() | text() | *"/>   
        </xsl:copy>
    </xsl:template>
    
</xsl:stylesheet>
