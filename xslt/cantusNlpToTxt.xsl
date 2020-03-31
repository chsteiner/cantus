<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    
    <xsl:template match="/">
        <xsl:param name="docs" select="collection('file:///C:/Users/stoffse/Desktop/cantus_teis_28_05/cantus-master/TEIs?select=*.xml;recurse=yes')"></xsl:param>
        <xsl:for-each select="$docs">
            <xsl:variable name="currentDoc" select=".">
               
            </xsl:variable>
            <xsl:variable name="result">
                <xsl:apply-templates select="$currentDoc//tei:body"/>
            </xsl:variable>
            <xsl:variable name="currentDocName">
                <xsl:value-of select="$currentDoc//tei:title[@type='short']"/>
            </xsl:variable>
            <xsl:result-document method="text" omit-xml-declaration="no" href="file:///C:/Users/stoffse/Desktop/cantus_teis_28_05/cantus-master/textFiles/{$currentDocName}.txt">
                <xsl:value-of select="$result"/>
            </xsl:result-document>
        </xsl:for-each>
    </xsl:template>
   
   <xsl:template match="tei:note">
       
   </xsl:template>
    
   <xsl:template match="tei:ab">
       <xsl:text> </xsl:text>
       <xsl:apply-templates></xsl:apply-templates>
   </xsl:template> 
    
   <xsl:template match="tei:choice">
       <xsl:apply-templates select="tei:corr"></xsl:apply-templates>
   </xsl:template> 
    
   <xsl:template match="tei:corr">
       <xsl:apply-templates></xsl:apply-templates>
   </xsl:template>
    
</xsl:stylesheet>