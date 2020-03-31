<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs t" version="3.0">
    
    <xsl:mode on-no-match="shallow-copy"/>

    <xsl:template match="* | @* | text() | comment()">
        <xsl:copy>
            <xsl:apply-templates select="* | @* | text()| comment()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="t:teiHeader">
        <xsl:copy>
            <xsl:choose>
                <xsl:when test="not(@xml:id)">
                    <xsl:attribute name="xml:id">
                        <xsl:value-of select="substring-after(//t:idno[@type = 'PID'], 'cantus.')"/>
                    </xsl:attribute>
                    <xsl:apply-templates select="* | @* except @xml:id | text() | comment()"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates select="* | @* | text() | comment()"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:copy>
    </xsl:template>
    
   <!-- Das durchzählen auf head Ebene funktioniert auch für Varianten weil immer ein head erzeugt wird, auch wenn er leer is (nur metamark enthalten)-->
    <xsl:template match="t:head">
        <xsl:variable name="num">
            <xsl:number level="any" format="1" count="t:head"/>
        </xsl:variable>

        <xsl:copy>
            <xsl:attribute name="xml:id">
                <xsl:choose>
                    <xsl:when test="@corresp">
                        <xsl:text>feast.</xsl:text><xsl:value-of
                            select="substring-after(@corresp, '#')"/>.<xsl:value-of select="$num"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>feast.nocdb.</xsl:text>
                        <xsl:value-of select="$num"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>
            <xsl:apply-templates select="* | @* except @xml:id | text()| comment()"/>
        </xsl:copy>
    </xsl:template>
    
    <!-- Das durchzählen auf time:1 Ebene funktioniert auch für Varianten weil immer ein head erzeugt wird, auch wenn er leer is (nur metamark enthalten)-->
    <xsl:template match="t:ab[@ana = '#head']/t:label">
        <xsl:variable name="num">
            <xsl:number level="any" format="1" count="t:ab[@ana = '#head']/t:label"/>
        </xsl:variable>

        <xsl:copy>
            <xsl:attribute name="xml:id">
                <xsl:choose>
                    <xsl:when test="ancestor::t:div[t:head]/t:head/@corresp">
                        <xsl:text>office.</xsl:text><xsl:value-of
                            select="ancestor::t:div[t:head]/t:head/substring-after(@corresp, '#')"
                        />.<xsl:choose>
                            <xsl:when test="@n!=''"><xsl:value-of select="@n"/></xsl:when>
                            <xsl:otherwise><xsl:text>VAR</xsl:text></xsl:otherwise>
                        </xsl:choose>.<xsl:value-of select="$num"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>office.nocdb.</xsl:text>
                        <xsl:choose>
                            <xsl:when test="@n!=''"><xsl:value-of select="@n"/></xsl:when>
                            <xsl:otherwise><xsl:text>VAR</xsl:text></xsl:otherwise>
                        </xsl:choose>
                        <xsl:text>.</xsl:text><xsl:value-of select="$num"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>
            <xsl:apply-templates select="* | @* except @xml:id | text()| comment()"/>
        </xsl:copy>
    </xsl:template>
    
    <!-- Das durchzählen auf time:2 Ebene funktioniert auch für Varianten weil immer ein head erzeugt wird, auch wenn er leer is (nur metamark enthalten)-->
    <xsl:template match="t:ab[@type = 'time:2']/t:label">
        <xsl:variable name="num">
            <xsl:number level="any" format="1" count="t:ab[@type = 'time:2']/t:label"/>
        </xsl:variable>
        
        <xsl:copy>
            <xsl:attribute name="xml:id">
                <xsl:choose>
                    <xsl:when test="ancestor::t:div[t:head]/t:head/@corresp">
                        <xsl:text>nocturne.</xsl:text><xsl:value-of
                            select="ancestor::t:div[t:head]/t:head/substring-after(@corresp, '#')"
                        /><xsl:if test="ancestor::t:div[@type = 'time:1']">.<xsl:choose>
                            <xsl:when test="ancestor::t:div[@type = 'time:1']/t:ab[@ana = '#head']/t:label/@n!=''"><xsl:value-of select="ancestor::t:div[@type = 'time:1']/t:ab[@ana = '#head']/t:label/@n"/></xsl:when>
                            <xsl:otherwise><xsl:text>VAR</xsl:text></xsl:otherwise>
                        </xsl:choose></xsl:if>.<xsl:value-of select="$num"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>nocturne.nocdb.</xsl:text><xsl:choose>
                            <xsl:when test="ancestor::t:div[@type = 'time:1']/t:ab[@ana = '#head']/t:label/@n!=''"><xsl:value-of select="ancestor::t:div[@type = 'time:1']/t:ab[@ana = '#head']/t:label/@n"/></xsl:when>
                            <xsl:otherwise><xsl:text>VAR</xsl:text></xsl:otherwise>
                        </xsl:choose><xsl:text>.</xsl:text><xsl:value-of
                            select="$num"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>
            <xsl:apply-templates select="* | @* except @xml:id | text()| comment()"/>
        </xsl:copy>
    </xsl:template>

    <!-- Das durchzählen auf seg Ebene funktioniert nicht für Varianten -->
    <xsl:template match="t:seg[@type = 'incipit']">
        
        <xsl:variable name="num_inc">
            <xsl:choose>
                <xsl:when test="ancestor::t:div[t:head]/t:head/@corresp">
                    <xsl:value-of
                        select="ancestor::t:div[t:head]/t:head/substring-after(@corresp, '#')"/>
                    <xsl:text>.</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>nocdb.</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:choose>
                <xsl:when test="ancestor::t:div[@type = 'time:1']/t:ab[@ana = '#head']/t:label/@n!=''">
                    <xsl:value-of
                        select="ancestor::t:div[@type = 'time:1']/t:ab[@ana = '#head']/t:label/@n"/>
                </xsl:when>
                <xsl:when test="ancestor::t:div[@type = 'time:1']/t:ab[@ana = '#head']/t:label/@n=''">
                    <xsl:text>VAR</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>comment</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:text>.</xsl:text>
            <xsl:number level="any" format="1"
                count="t:seg[@type = 'incipit']"/> 
        </xsl:variable>

        <xsl:copy>
            <xsl:if test="ancestor::t:metamark">
                <xsl:attribute name="function">
                    <xsl:value-of select="//t:witDetail/@wit"/>
                    <xsl:text>.incipit.</xsl:text>
                    <xsl:value-of select="translate(current()/ancestor::t:metamark/@xml:id,'.','')"/>
                    <xsl:text>.</xsl:text>
                    <xsl:value-of select="$num_inc"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:attribute name="xml:id">
                <xsl:text>incipit.</xsl:text>
                <xsl:value-of select="$num_inc"/>
            </xsl:attribute>
            <xsl:apply-templates select="* | @* except @xml:id | text()| comment()"/>
        </xsl:copy>
    </xsl:template>
    
    <!--Hier werden eigene IDs für die Incipits eingeführt, die nur in Varianten enthalten sind-->
    <!--<xsl:template match="t:seg[@type = 'incipit'][ancestor::t:metamark]">
        <xsl:variable name="num_inc">
            <xsl:choose>
                <xsl:when test="ancestor::t:div[t:head]/t:head/@corresp">
                    <xsl:value-of
                        select="ancestor::t:div[t:head]/t:head/substring-after(@corresp, '#')"/>
                    <xsl:text>.</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>nocdb.</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:choose>
                <xsl:when test="ancestor::t:div[@type = 'time:1']/t:ab[@ana = '#head']/t:label/@n!=''">
                    <xsl:value-of
                        select="ancestor::t:div[@type = 'time:1']/t:ab[@ana = '#head']/t:label/@n"/>
                </xsl:when>
                <xsl:when test="ancestor::t:div[@type = 'time:1']/t:ab[@ana = '#head']/t:label/@n=''">
                    <xsl:text>VAR</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>comment</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:text>.</xsl:text>
            <xsl:number level="any" format="1"
                count="t:seg[@type = 'incipit'][ancestor::t:metamark]"/>
        </xsl:variable>
        
        <xsl:copy>
            <xsl:attribute name="function">
                <xsl:value-of select="//t:witDetail/@wit"/>
                <xsl:text>.incipit.</xsl:text>
                <xsl:value-of select="translate(current()/ancestor::t:metamark/@xml:id,'.','')"/>
                <xsl:text>.</xsl:text>
                <xsl:value-of select="$num_inc"/>
            </xsl:attribute>
            <xsl:apply-templates select="* | @* except @xml:id | text()| comment()"/>
        </xsl:copy>
    </xsl:template>-->
    

    <xsl:template match="t:seg[@ana='#person'][not(ancestor::t:metamark)]">
        <xsl:variable name="num_pers">
            <xsl:choose>
                <xsl:when test="ancestor::t:div[t:head]/t:head/@corresp">
                    <xsl:value-of
                        select="ancestor::t:div[t:head]/t:head/substring-after(@corresp, '#')"/>
                    <xsl:text>.</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>nocdb.</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:choose>
                <xsl:when test="ancestor::t:div[@type = 'time:1']/t:ab[@ana = '#head']/t:label/@n!=''">
                    <xsl:value-of
                        select="ancestor::t:div[@type = 'time:1']/t:ab[@ana = '#head']/t:label/@n"/>
                </xsl:when>
                <xsl:when test="ancestor::t:div[@type = 'time:1']/t:ab[@ana = '#head']/t:label/@n=''">
                    <xsl:text>VAR</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>comment</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:text>.</xsl:text>
            <xsl:number level="any" format="1"
                count="t:seg[@ana = '#person'][not(ancestor::t:metamark)]"/>
        </xsl:variable>
        
        <xsl:copy>
            <xsl:attribute name="xml:id">
                <xsl:text>person.</xsl:text>
                <xsl:choose>
                    <xsl:when test="./t:choice">
                        <xsl:value-of select="normalize-space(translate(./t:choice/t:corr,' ',''))"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="normalize-space(translate(.,' ',''))"/>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:text>.</xsl:text>
                <xsl:value-of select="$num_pers"/>
            </xsl:attribute>
            <xsl:apply-templates select="* | @* except @xml:id  except @xml:id| text()| comment()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="t:seg[@ana='#person'][ancestor::t:metamark]">
        <xsl:variable name="num_pers">
            <xsl:choose>
                <xsl:when test="ancestor::t:div[t:head]/t:head/@corresp">
                    <xsl:value-of
                        select="ancestor::t:div[t:head]/t:head/substring-after(@corresp, '#')"/>
                    <xsl:text>.</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>nocdb.</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:choose>
                <xsl:when test="ancestor::t:div[@type = 'time:1']/t:ab[@ana = '#head']/t:label/@n!=''">
                    <xsl:value-of
                        select="ancestor::t:div[@type = 'time:1']/t:ab[@ana = '#head']/t:label/@n"/>
                </xsl:when>
                <xsl:when test="ancestor::t:div[@type = 'time:1']/t:ab[@ana = '#head']/t:label/@n=''">
                    <xsl:text>VAR</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>comment</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:text>.</xsl:text>
            <xsl:number level="single" format="1"
                count="t:seg[@ana = '#person'][ancestor::t:metamark]"/>
        </xsl:variable>
        
        <xsl:copy>
            <xsl:attribute name="xml:id">
                <xsl:value-of select="//t:witDetail/@wit"/>
                <xsl:text>.person.</xsl:text>
                <xsl:value-of select="translate(current()/ancestor::t:metamark/@xml:id,'.','')"/><xsl:text>.</xsl:text>
                <xsl:choose>
                    <xsl:when test="./t:choice">
                        <xsl:value-of select="normalize-space(translate(./t:choice/t:corr,' ',''))"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="normalize-space(translate(.,' ',''))"/>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:text>.</xsl:text>
                <xsl:value-of select="$num_pers"/>
            </xsl:attribute>
            <xsl:apply-templates select="* | @* except @xml:id | text()| comment()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="t:seg[@ana='#place'][not(ancestor::t:metamark)]">
        <xsl:variable name="num_pers">
            <xsl:choose>
                <xsl:when test="ancestor::t:div[t:head]/t:head/@corresp">
                    <xsl:value-of
                        select="ancestor::t:div[t:head]/t:head/substring-after(@corresp, '#')"/>
                    <xsl:text>.</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>nocdb.</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:choose>
                <xsl:when test="ancestor::t:div[@type = 'time:1']/t:ab[@ana = '#head']/t:label/@n!=''">
                    <xsl:value-of
                        select="ancestor::t:div[@type = 'time:1']/t:ab[@ana = '#head']/t:label/@n"/>
                </xsl:when>
                <xsl:when test="ancestor::t:div[@type = 'time:1']/t:ab[@ana = '#head']/t:label/@n=''">
                    <xsl:text>VAR</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>comment</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:text>.</xsl:text>
            <xsl:number level="any" format="1"
                count="t:seg[@ana = '#place'][not(ancestor::t:metamark)]"/>
        </xsl:variable>
        
        <xsl:copy>
            <xsl:attribute name="xml:id">
                <xsl:text>place.</xsl:text>
                <xsl:choose>
                    <xsl:when test="./t:choice">
                        <xsl:value-of select="normalize-space(translate(./t:choice/t:corr,' ',''))"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="normalize-space(translate(.,' ',''))"/>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:text>.</xsl:text>
                <xsl:value-of select="$num_pers"/>
            </xsl:attribute>
            <xsl:apply-templates select="* | @* except @xml:id | text()| comment()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="t:seg[@ana='#place'][ancestor::t:metamark]">
        <xsl:variable name="num_pers">
            <xsl:choose>
                <xsl:when test="ancestor::t:div[t:head]/t:head/@corresp">
                    <xsl:value-of
                        select="ancestor::t:div[t:head]/t:head/substring-after(@corresp, '#')"/>
                    <xsl:text>.</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>nocdb.</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:choose>
                <xsl:when test="ancestor::t:div[@type = 'time:1']/t:ab[@ana = '#head']/t:label/@n!=''">
                    <xsl:value-of
                        select="ancestor::t:div[@type = 'time:1']/t:ab[@ana = '#head']/t:label/@n"/>
                </xsl:when>
                <xsl:when test="ancestor::t:div[@type = 'time:1']/t:ab[@ana = '#head']/t:label/@n=''">
                    <xsl:text>VAR</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>comment</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:text>.</xsl:text>
            <xsl:number level="single" format="1"
                count="t:seg[@ana = '#place'][ancestor::t:metamark]"/>
        </xsl:variable>
        
        <xsl:copy>
            <xsl:attribute name="xml:id">
                <xsl:value-of select="//t:witDetail/@wit"/>
                <xsl:text>.place.</xsl:text>
                <xsl:value-of select="translate(current()/ancestor::t:metamark/@xml:id,'.','')"/><xsl:text>.</xsl:text>
                <xsl:choose>
                    <xsl:when test="./t:choice">
                        <xsl:value-of select="normalize-space(translate(./t:choice/t:corr,' ',''))"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="normalize-space(translate(.,' ',''))"/>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:text>.</xsl:text>
                <xsl:value-of select="$num_pers"/>
            </xsl:attribute>
            <xsl:apply-templates select="* | @* except @xml:id | text()| comment()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="t:seg[@ana='#function'][not(ancestor::t:metamark)]">
        <xsl:variable name="num_pers">
            <xsl:choose>
                <xsl:when test="ancestor::t:div[t:head]/t:head/@corresp">
                    <xsl:value-of
                        select="ancestor::t:div[t:head]/t:head/substring-after(@corresp, '#')"/>
                    <xsl:text>.</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>nocdb.</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:choose>
                <xsl:when test="ancestor::t:div[@type = 'time:1']/t:ab[@ana = '#head']/t:label/@n!=''">
                    <xsl:value-of
                        select="ancestor::t:div[@type = 'time:1']/t:ab[@ana = '#head']/t:label/@n"/>
                </xsl:when>
                <xsl:when test="ancestor::t:div[@type = 'time:1']/t:ab[@ana = '#head']/t:label/@n=''">
                    <xsl:text>VAR</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>comment</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:text>.</xsl:text>
            <xsl:number level="any" format="1"
                count="t:seg[@ana = '#function'][not(ancestor::t:metamark)]"/>
        </xsl:variable>
        
        <xsl:copy>
            <xsl:attribute name="xml:id">
                <xsl:text>function.</xsl:text>
                <xsl:choose>
                    <xsl:when test="./t:choice">
                        <xsl:value-of select="normalize-space(translate(./t:choice/t:corr,' ',''))"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="normalize-space(translate(.,' ',''))"/>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:text>.</xsl:text>
                <xsl:value-of select="$num_pers"/>
            </xsl:attribute>
            <xsl:apply-templates select="* | @* except @xml:id | text()| comment()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="t:seg[@ana='#function'][ancestor::t:metamark]">
        <xsl:variable name="num_pers">
            <xsl:choose>
                <xsl:when test="ancestor::t:div[t:head]/t:head/@corresp">
                    <xsl:value-of
                        select="ancestor::t:div[t:head]/t:head/substring-after(@corresp, '#')"/>
                    <xsl:text>.</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>nocdb.</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:choose>
                <xsl:when test="ancestor::t:div[@type = 'time:1']/t:ab[@ana = '#head']/t:label/@n!=''">
                    <xsl:value-of
                        select="ancestor::t:div[@type = 'time:1']/t:ab[@ana = '#head']/t:label/@n"/>
                </xsl:when>
                <xsl:when test="ancestor::t:div[@type = 'time:1']/t:ab[@ana = '#head']/t:label/@n=''">
                   <xsl:text>VAR</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>comment</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:text>.</xsl:text>
            <xsl:number level="single" format="1"
                count="t:seg[@ana = '#function'][ancestor::t:metamark]"/>
        </xsl:variable>
        
        <xsl:copy>
            <xsl:attribute name="xml:id">
                <xsl:value-of select="//t:witDetail/@wit"/>
                <xsl:text>.function.</xsl:text>
                <xsl:value-of select="translate(current()/ancestor::t:metamark/@xml:id,'.','')"/><xsl:text>.</xsl:text>
                <xsl:choose>
                    <xsl:when test="./t:choice">
                        <xsl:value-of select="normalize-space(translate(./t:choice/t:corr,' ',''))"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="normalize-space(translate(.,' ',''))"/>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:text>.</xsl:text>
                <xsl:value-of select="$num_pers"/>
            </xsl:attribute>
            <xsl:apply-templates select="* | @* except @xml:id | text()| comment()"/>
        </xsl:copy>
    </xsl:template>
    

</xsl:stylesheet>
