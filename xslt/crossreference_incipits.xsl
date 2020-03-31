<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:t="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs t">
    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
    <xsl:strip-space elements="*"/>
    
    <xsl:variable name="filename">
        <xsl:value-of select="concat(substring-before(tokenize(base-uri(), '/')[last()],'_current'),'.xml')"/>
    </xsl:variable>
    <xsl:param name="ids"
        select="document(concat('file:/Z:/CANTUS/2018/git/cantus.git/trunk/all_incipits/references_DB/from_db/',$filename))"/>

    <xsl:key name="grp_seg" match="t:seg[@type='incipit']" use="normalize-space(.)"/>
    <xsl:key name="ref" match="row" use="title"/>

    <!-- identity transform -->
    <xsl:template match="@* | node() | text() | *">
        <xsl:copy>
            <xsl:apply-templates select="@* | node() | text() | *"/>
        </xsl:copy>
    </xsl:template>

    
    <xsl:template match="t:seg[@type='incipit']">
        <xsl:variable name="i" select="index-of(key('grp_seg', normalize-space(.))/generate-id(), generate-id())"/>
        <xsl:copy>
            <xsl:if test="normalize-space(key('ref', normalize-space(.), $ids)[$i]/cdb) != 'NULL'">
            <xsl:attribute name="n">
                <xsl:value-of select="normalize-space(key('ref', normalize-space(.), $ids)[$i]/cdb)"/>
            </xsl:attribute>
            </xsl:if>
            <xsl:if test="normalize-space(key('ref', normalize-space(.), $ids)[$i]/ams) != 'NULL'">
            <xsl:attribute name="corresp">
                <xsl:value-of select="normalize-space(key('ref', normalize-space(.), $ids)[$i]/ams)"/>
            </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates select="@* | node() | text() | *"/>
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>
