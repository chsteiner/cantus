<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="t xs xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:t="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0" xmlns:xhtml="http://www.w3.org/1999/xhtml" version="2.0">
    <xsl:output method="text"/>



    <xsl:template match="/">

        <xsl:apply-templates select="//t:seg[@type = 'incipit']"/>

    </xsl:template>

    <xsl:template match="t:seg[@type = 'incipit']">
        <xsl:variable name="exclude_genres"
            select="@subtype = 'supplied' and substring(@ana, 2) = 'AG' or @subtype = 'supplied' and substring(@ana, 2) = 'AL' or @subtype = 'supplied' and substring(@ana, 2) = 'MA' or @subtype = 'supplied' and substring(@ana, 2) = 'ND' or @subtype = 'supplied' and substring(@ana, 2) = 'BD' or @subtype = 'supplied' and substring(@ana, 2) = 'BE' or @subtype = 'supplied' and substring(@ana, 2) = 'CD' or @subtype = 'supplied' and substring(@ana, 2) = 'CIT' or @subtype = 'supplied' and substring(@ana, 2) = 'CPI' or @subtype = 'supplied' and substring(@ana, 2) = 'CR' or @subtype = 'supplied' and substring(@ana, 2) = 'EVI' or @subtype = 'supplied' and substring(@ana, 2) = 'EX' or @subtype = 'supplied' and substring(@ana, 2) = 'GL' or @subtype = 'supplied' and substring(@ana, 2) = 'IM' or @subtype = 'supplied' and substring(@ana, 2) = 'IP' or @subtype = 'supplied' and substring(@ana, 2) = 'KY' or @subtype = 'supplied' and substring(@ana, 2) = 'LT' or @subtype = 'supplied' and substring(@ana, 2) = 'MA' or @subtype = 'supplied' and substring(@ana, 2) = 'ND' or @subtype = 'supplied' and substring(@ana, 2) = 'ORI' or @subtype = 'supplied' and substring(@ana, 2) = 'PN' or @subtype = 'supplied' and substring(@ana, 2) = 'PNI' or @subtype = 'supplied' and substring(@ana, 2) = 'REP' or @subtype = 'supplied' and substring(@ana, 2) = 'SA' or @subtype = 'supplied' and substring(@ana, 2) = 'TD' or @subtype = 'supplied' and substring(@ana, 2) = 'VAR' or @subtype = 'supplied' and substring(@ana, 2) = 'VIS' or @subtype = 'supplied' and substring(@ana, 2) = 'HV' or @subtype = 'supplied' and substring(@ana, 2) = 'REP'"/>
        <!--<xsl:choose>
            <!-\-<xsl:when test="$exclude_genres"/>-\->
            <xsl:when test="string-length(.) > 0">-->
                <xsl:value-of select="ancestor::t:div/preceding-sibling::t:head/normalize-space()"/>
                <xsl:text>;</xsl:text>
                <xsl:value-of
                    select="substring-after(ancestor::t:div/preceding-sibling::t:head/@corresp, '#')"/>
                <xsl:text>;</xsl:text>
                <xsl:value-of select="ancestor::t:div/preceding-sibling::t:head/@n"/>
                <xsl:text>;</xsl:text>
                <xsl:value-of
                    select="ancestor::t:div/t:ab[@ana = '#head']/t:label/normalize-space()"/>
                <xsl:text>;</xsl:text>
                <xsl:value-of
                    select="ancestor::t:div/t:ab[@ana = '#head']/t:label/@n"/>
                <xsl:text>;</xsl:text>
                <xsl:value-of select="substring(@ana, 2)"/>
                <xsl:text>;</xsl:text>
                <xsl:value-of select="./normalize-space()"/>
                <xsl:text>;</xsl:text>
                <xsl:value-of select="@n"/>
                <xsl:text>;</xsl:text>
                <xsl:value-of select="@corresp"/>
                <xsl:text>&#xD;</xsl:text>
            <!--</xsl:when>
        </xsl:choose>-->
    </xsl:template>




</xsl:stylesheet>
