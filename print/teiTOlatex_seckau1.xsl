<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs t" version="2.0">
    <xsl:strip-space elements="*"/>

    <xsl:output method="text" indent="yes" encoding="utf8"/>
     <!-- <xsl:variable name="sve"
        select="document('/o:cantus.passau.sve/TEI_SOURCE')"/>
    <xsl:variable name="knb"
        select="document('/o:cantus.passau.knb/TEI_SOURCE')"/>
    <xsl:variable name="sp1"
        select="document('/o:cantus.passau.sp/TEI_SOURCE')"/>
    <xsl:variable name="sal"
        select="document('/o:cantus.passau.sal/TEI_SOURCE')"/>
    <xsl:variable name="wie"
        select="document('/o:cantus.passau.wie/TEI_SOURCE')"/>-->
    <xsl:variable name="se1" 
        select="document('seckau1_se1_current_tei.xml')"/>
    <!--<xsl:variable name="sal_sal" select="document('salzburg_sal_current_tei.xml')"/>
    <xsl:variable name="vo" select="document('salzburg_vo_current_tei.xml')"/>
    <xsl:variable name="ra" select="document('salzburg_ra_current_tei.xml')"/>-->
    

    <xsl:template match="/">
        <xsl:text>
\documentclass[paper=b5,fontsize=12pt,twoside=semi]{scrbook}
\usepackage[left=28mm, right=28mm, top=25mm, bottom=29mm,includehead]{geometry} 
\usepackage[headsepline]{scrlayer-scrpage}
%\usepackage[normalem]{ulem}
%\usepackage{libertine}
\usepackage{import}
\usepackage{polyglossia}
\usepackage{fontspec}
\usepackage{imakeidx}
\usepackage{soul}
\usepackage{microtype}
\usepackage{reledmac}
\usepackage{ebgaramond}
\pagestyle{scrheadings}
\clearpairofpagestyles
\chead{\headmark}
\automark{section}
\ohead{\pagemark}
\makeindex[title=Personen,name=pers]
\makeindex[title=Orte,name=ort]
\makeindex[title=Index der Incipits,name=incipits]
\Xarrangement[A]{normal}
\Xarrangement[B]{normal}
\linenummargin{inner}
\firstlinenum{5}
\linenumincrement{5}
\date{}
\setsansfont{Garamond}
\setmainfont{Garamond}
\setdefaultlanguage[variant=classic]{latin}
\renewcommand*{\headfont}{\normalfont}
\RedeclareSectionCommand[
    beforeskip=1em,
    afterskip=0.2em]{section}
% \newcommand{\textjuni}[1]{{\fontspec{Junicode}#1}}
% \newcommand{\myparagraph}[1]{\paragraph{#1}\mbox{}\\}
\setul{1pt}{.4pt}
\addtokomafont{section}{\normalsize}
\addtokomafont{subsection}{\normalsize}
\setlength{\parindent}{0pt}

\begin{document}
\beginnumbering
    \part*{</xsl:text>
        <xsl:value-of select="//t:teiHeader/t:fileDesc/t:titleStmt/t:title[not(@*)]"/>
        <xsl:text>}</xsl:text>

        <xsl:apply-templates select="//t:body"/>

        <xsl:text>
    \endnumbering
    \printindex[pers]
    \printindex[ort]
    \printindex[incipits]
    \end{document}
   </xsl:text>
    </xsl:template>

    <xsl:template match="t:metamark[not(descendant::text()) and not(@corresp)]"> 
        <xsl:for-each select="$se1//t:metamark[@xml:id = current()/@xml:id][normalize-space(.)]">                    
              <xsl:text> \edtext{+}{\Bfootnote{</xsl:text><xsl:apply-templates mode="leermetamarks"/><xsl:text> SE1}}</xsl:text>                                                               
        </xsl:for-each>          
    </xsl:template>

    <xsl:template match="t:metamark[not(t:pb) and normalize-space(.)]">
        <xsl:param name="text" select="."/>
        <xsl:variable name="exclude_genres"
            select=".[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'AG']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'BD']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'BE']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'CD']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'CIT']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'CPI']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'CR']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'EP']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'EPP']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'EV']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'EVI']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'EX']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'GL']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'GR']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'GV']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'HV']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'HY']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'IM']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'IN']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'INV']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'IP']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'IV']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'KY']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'MA']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'ND']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'OF']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'OR']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'ORI']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'ORC']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'OV']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'OP']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'PC']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'PE']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'PF']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'PN']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'PNI']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'PR']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'PS']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'PV']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'RB']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'REP']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'RP']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'RPP']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'RV']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'SA']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'SE']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'SV']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'TD']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'TP']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'TPV']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'TR']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'TV']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'VAR']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'VIS']]]"/>
        <xsl:variable name="lastword">
            <xsl:choose>
                <xsl:when
                    test=".[string-length() > 20]//*/t:seg[@type = 'incipit'][last()][not(following-sibling::text()[string-length() > 1])]">
                    <xsl:text>\textit{</xsl:text>
                    <xsl:value-of
                        select="tokenize(normalize-space(.[string-length() > 20]//*/t:seg[@type = 'incipit'][last()][not(following-sibling::text()[string-length() > 1])]), ' ')[last()]"/>
                    <xsl:text>}</xsl:text>
                </xsl:when>
                <xsl:when
                    test=".[string-length() > 20]//t:seg[@type = 'incipit'][last()][not(following-sibling::text()[string-length() > 1])]">
                    <xsl:text>\textit{</xsl:text>
                    <xsl:value-of
                        select="tokenize(normalize-space(.[string-length() > 20]//t:seg[@type = 'incipit'][last()][not(following-sibling::text()[string-length() > 1])]), ' ')[last()]"/>
                    <xsl:text>}</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of
                        select="tokenize(normalize-space(.[string-length() > 20]), ' ')[last()]"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="firstword">
            <xsl:choose>
                <xsl:when
                    test=".[string-length() > 20][descendant::text()[1][ancestor::t:seg[@type = 'incipit']]]">
                    <xsl:choose>
                        <xsl:when test=".[descendant::text()[1][ancestor::t:seg[@corresp]]]"/>
                        <xsl:when test="$exclude_genres"/>
                        <xsl:otherwise>
                            <xsl:value-of select="./t:seg[@type = 'incipit'][1]/substring(@ana, 2)"
                            />
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:choose>
                        <xsl:when
                            test="normalize-space(.[string-length() > 20]//*/t:seg[@type = 'incipit'][1][not(preceding-sibling::text())])">
                            <xsl:text> \textit{</xsl:text>
                            <xsl:value-of
                                select="tokenize(normalize-space(.[string-length() > 20]//*/t:seg[@type = 'incipit'][1]), ' ')[1]"/>
                            <xsl:text>}</xsl:text>
                        </xsl:when>
                        <xsl:when
                            test="normalize-space(.[string-length() > 20]//t:seg[@type = 'incipit'][1][not(preceding-sibling::text())])">
                            <xsl:text> \textit{</xsl:text>
                            <xsl:value-of
                                select="tokenize(normalize-space(.[string-length() > 20]//t:seg[@type = 'incipit'][1]), ' ')[1]"/>
                            <xsl:text>}</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of
                                select="tokenize(normalize-space(.[string-length() > 20]), ' ')[1]"
                            />
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of
                        select="tokenize(normalize-space(.[string-length() > 20]), ' ')[1]"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <!--<xsl:param name="pb" select="./t:pb/@n"/>-->
        <xsl:text> \edtext{</xsl:text>
        <!-- <xsl:choose>
            <xsl:when test="t:pb">
                <xsl:text>(</xsl:text><xsl:value-of select="./t:pb/@n"/><xsl:text>)</xsl:text>
            </xsl:when>
            <xsl:when test="not(normalize-space(.)) and not(t:pb)">
                <xsl:text>*</xsl:text>
            </xsl:when>
            <xsl:otherwise><xsl:apply-templates/></xsl:otherwise>
        </xsl:choose>
       
       <xsl:if test="./t:seg[@type='incipit'][1]"><xsl:value-of select="./t:seg[@type='incipit'][1]/substring(@ana, 2)"/><xsl:text> \textit{</xsl:text></xsl:if>
       <xsl:apply-templates select=".[string-length()>20]/substring-before(node()[1]//text()[not(ancestor::t:sic)],' ')"/>
       <xsl:if test="./t:seg[@type='incipit'][1]"><xsl:text>}</xsl:text></xsl:if>
       -->
        <xsl:apply-templates/>
        <xsl:text>}</xsl:text>
        <xsl:if test=".[string-length() > 20]">
            <xsl:text>{\lemma{</xsl:text>
            <xsl:value-of select="$firstword"/>
            <xsl:text>\ldots </xsl:text>
            <xsl:value-of select="$lastword"/>
            <xsl:text>}</xsl:text>
        </xsl:if>
        <xsl:text>{\Bfootnote{</xsl:text>
        <xsl:for-each select="$se1//t:metamark[@xml:id = current()/@xml:id]">
            <xsl:variable name="current_text_se1" select="."/>

            <xsl:choose>

                <!--Wenn der Text übereinstimmt keine Fußnoten-->
                <!--<xsl:when test="$current_text_se1 = $text"/>-->

                <xsl:when test="descendant::t:del[@subtype = 'signingover']">
                    <xsl:choose>
                        <xsl:when
                            test="descendant::t:del[@subtype = 'signingover']/t:add[t:seg[@type = 'incipit']]">
                            <xsl:text>\textit{ras., deinde add.} </xsl:text>
                            <xsl:value-of
                                select="descendant::t:del[@subtype = 'signingover']/t:add/t:seg[@type = 'incipit']/substring(@ana, 2)"/>
                            <xsl:text xml:space="preserve"> SE1</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text>\textit{ras., deinde add.} </xsl:text>
                            <xsl:value-of select="descendant::t:del[@subtype = 'signingover']"/>
                            <xsl:text xml:space="preserve"> SE1</xsl:text>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:when test="descendant::t:del[@subtype = 'marginal']">
                    <xsl:text>\textit{ras., deinde add. in marg.:} </xsl:text>
                    <xsl:value-of select="descendant::t:del[@subtype = 'marginal']"/>
                    <xsl:text xml:space="preserve"> SE1</xsl:text>
                </xsl:when>
                <xsl:when test="descendant::t:del[@subtype = 'deciphered']">
                    <xsl:text>\textit{lectio ex ras.} </xsl:text>
                    <xsl:value-of select="descendant::t:del[@subtype = 'deciphered']"/>
                    <xsl:text xml:space="preserve"> SE1</xsl:text>
                </xsl:when>
                <xsl:when test="descendant::t:del[not(@*)]">
                    <xsl:text>\textit{esp.} </xsl:text>
                    <xsl:text xml:space="preserve"> SE1</xsl:text>
                </xsl:when>
                <xsl:when test="descendant::t:choice">
                    <xsl:text>\textit{corr., cod.} </xsl:text>
                    <xsl:value-of select="descendant::t:choice/t:sic"/>
                    <xsl:text xml:space="preserve"> SE1</xsl:text>
                </xsl:when>
                <xsl:when test="descendant::t:note[@type = 'supplied']">
                    <xsl:text>&lt;</xsl:text>
                    <xsl:value-of select="descendant::t:note[@type = 'supplied']"/>
                    <xsl:text xml:space="preserve">&gt; SE1</xsl:text>
                </xsl:when>

                <!--add.in marg.-->
                <xsl:when test="descendant::t:add[not(parent::t:del)][@type = 'marginal']">
                    <xsl:if
                        test="not($current_text_se1//t:metamark[@xml:id = current()/@xml:id]//t:add[not(parent::t:del)] = $text//t:metamark[@xml:id = current()/@xml:id]//t:add[not(parent::t:del)])">
                        <xsl:text>\textit{add. in marg.} </xsl:text>
                        <xsl:value-of select="descendant::t:add[not(parent::t:del)]"/>
                    </xsl:if>
                    <xsl:text xml:space="preserve"> SE1</xsl:text>
                </xsl:when>

                <!--superscript-->
                <xsl:when test="descendant::t:add[not(parent::t:del)]">
                    <xsl:if
                        test="not($current_text_se1//t:metamark[@xml:id = current()/@xml:id]//t:add[not(parent::t:del)] = $text//t:metamark[@xml:id = current()/@xml:id]//t:add[not(parent::t:del)])">
                        <xsl:text>\textit{superscript.} </xsl:text>
                        <xsl:value-of select="descendant::t:add[not(parent::t:del)]"/>
                    </xsl:if>
                    <xsl:text xml:space="preserve"> SE1</xsl:text>
                </xsl:when>

                <xsl:when test="descendant::t:gap">
                    <xsl:text>\textit{lacuna}</xsl:text>
                    <xsl:text xml:space="preserve"> SE1</xsl:text>
                </xsl:when>



                <!--<xsl:when test="./t:pb/@n=$pb"></xsl:when>
                <xsl:when test="t:pb"><xsl:text>(</xsl:text><xsl:value-of select="./t:pb/@n"/><xsl:text>)</xsl:text><xsl:text xml:space="preserve"> SP1;</xsl:text></xsl:when>-->
                <!--<xsl:when test="not(normalize-space(.))"><xsl:text>\textit{om.}</xsl:text><xsl:text xml:space="preserve"> SE1</xsl:text></xsl:when>-->

                <!--om.-->
                <xsl:when test="not(normalize-space(.))">
                    <!--Es wird auf Gleichheit der Wörter wieder geprüft, stimmen die Wörter überein wurde omn. bereits geschrieben!-->
                    <xsl:text xml:space="preserve">\textit{om.} SE1</xsl:text>
                </xsl:when>
                <!--om. end-->



                <!--<xsl:when test="$current_text_se1=$text"></xsl:when>-->
                <!--Sebi: Habe ich an den Anfang verlegt!-->
               
                <xsl:otherwise>
                    <xsl:apply-templates/>
                    <xsl:text xml:space="preserve"> SE1</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:for-each>

        <xsl:text>}}</xsl:text>
        <xsl:if test=".[string-length() > 20]">
            <xsl:text>}</xsl:text>
        </xsl:if>
    </xsl:template>

    <!--   <xsl:template match="t:metamark[not(t:pb) and normalize-space(.)]/descendant::text()[1]">     
           <xsl:choose>
             <xsl:when test="starts-with(.,' ')">
                 <xsl:value-of select="replace(., '^\s+', '')"/>
             </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="."/>
            </xsl:otherwise>
           </xsl:choose>
    </xsl:template>
    <xsl:template match="t:metamark[not(t:pb) and normalize-space(.)]/descendant::text()[last()]">     
        <xsl:choose>
            <xsl:when test="ends-with(.,' ')">
                <xsl:value-of select="replace(., '\s+$', '')"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="."/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>-->

    <xsl:template match="t:choice">
        <xsl:value-of select="./t:corr"/>
        <xsl:text>\footnoteA{\textit{corr., cod. }'</xsl:text>
        <xsl:value-of select="./t:sic"/>
        <xsl:text>'}</xsl:text>
    </xsl:template>

    <xsl:template match="t:note[not(@*)]">
        <xsl:text>*\footnoteA{</xsl:text>
        <xsl:value-of select="."/>
        <xsl:text>}</xsl:text>
    </xsl:template>

    <xsl:template match="t:seg[@ana = '#person']">
        <xsl:value-of select="."/>
        <xsl:text>\edindex[pers]{</xsl:text>
        <xsl:value-of select="."/>
        <xsl:text>}</xsl:text>
    </xsl:template>
    <xsl:template match="t:seg[@ana = '#place']">
        <xsl:value-of select="."/>
        <xsl:text>\edindex[ort]{</xsl:text>
        <xsl:value-of select="."/>
        <xsl:text>}</xsl:text>
    </xsl:template>
    <xsl:template match="t:seg[@ana = '#function']">
        <xsl:value-of select="."/>
    </xsl:template>
    <xsl:template match="t:seg[@type = 'supplied']">
        <xsl:text>&lt;</xsl:text>
        <xsl:value-of select="."/>
        <xsl:text>&gt;</xsl:text>
    </xsl:template>
    <xsl:template match="t:del">
        <xsl:choose>
            <xsl:when test="not(normalize-space(.))">
                <xsl:text>[...]</xsl:text>
            </xsl:when>
            <xsl:when test="@subtype = 'signingover'">
                <xsl:choose>
                    <xsl:when test="t:add[t:seg[@type = 'incipit']]">
                        <xsl:for-each select="t:add//t:seg[@type = 'incipit']">
                        <xsl:text>[...]\footnoteA{\textit{ras., deinde add. }'</xsl:text>
                        <xsl:value-of select="substring(@ana, 2)"/>
                        <xsl:text xml:space="preserve"> \textit{</xsl:text>
                        <xsl:value-of select="."/>
                        <xsl:text>}'}</xsl:text>
                        </xsl:for-each>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>[...]\footnoteA{\textit{ras., deinde add. }'</xsl:text>
                        <xsl:value-of select="."/>
                        <xsl:text>'}</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="@subtype = 'marginal'">
                <xsl:text>[...]\footnoteA{\textit{ras., deinde add. in marg.: }'</xsl:text>
                <xsl:value-of select="."/>
                <xsl:text>'}</xsl:text>
            </xsl:when>
            <xsl:when test="@subtype = 'deciphered'">
                <xsl:value-of select="./t:add"/>
                <xsl:text>\footnoteA{\textit{lectio ex ras.}}</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
                <xsl:text>\footnoteA{\textit{esp.}}</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="t:gap">
        <xsl:text>[...]\footnoteA{\textit{lacuna}}</xsl:text>
    </xsl:template>

    <xsl:template match="t:add[not(parent::t:del)]">
        <xsl:choose>
            <xsl:when test="@type = 'marginal'">
                <xsl:apply-templates/>
                <xsl:text>\footnoteA{</xsl:text>
                <xsl:apply-templates/>
                <xsl:text> \textit{add. in marg.}}</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
                <xsl:text>\footnoteA{</xsl:text>
                <xsl:apply-templates/>
                <xsl:text> \textit{superscript.}}</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>


    <xsl:template match="t:div[t:head]">

        <xsl:apply-templates/>

    </xsl:template>
    

    <xsl:template match="t:div[preceding-sibling::t:head]">
        <xsl:if test="string-length() > 0">
            <!--  <xsl:if test="position()!=1"><xsl:text>\newline</xsl:text></xsl:if>-->
            <xsl:text> \pstart </xsl:text>
            <xsl:apply-templates/>
            <xsl:text> \pend </xsl:text>
            <xsl:text>&#xd;</xsl:text>
        </xsl:if>
    </xsl:template>

    <xsl:template match="t:ab[@ana = '#head']">
        <xsl:text>\textbf{</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>}</xsl:text>   
    </xsl:template>

    <xsl:template match="t:note[@type = 'supplied']">
        <xsl:text>&lt;</xsl:text><xsl:apply-templates/><xsl:text>&gt;</xsl:text>
    </xsl:template>

    <xsl:template match="t:phr">       
        <xsl:text>\ul{</xsl:text><xsl:apply-templates/><xsl:text>}</xsl:text>
    </xsl:template>
    
    <xsl:template match="t:phr" mode="leermetamarks">       
        <xsl:text>\ul{</xsl:text><xsl:apply-templates/><xsl:text>}</xsl:text>
    </xsl:template>

    <xsl:template match="t:pb">
        <xsl:text>(</xsl:text>
        <xsl:value-of select="./@n"/>
        <xsl:text>)</xsl:text>
    </xsl:template>

    <xsl:template match="t:ab">
        <xsl:if test="@subtype = 'marginal'">
            <xsl:text>\footnoteA{\textit{add. in marg.}}</xsl:text>
        </xsl:if>
        <xsl:apply-templates/>
        <xsl:if test="following-sibling::t:ab">
            <xsl:text xml:space="preserve"> </xsl:text>
        </xsl:if>
    </xsl:template>

    <xsl:template match="t:quote">
        <xsl:variable name="exclude_genres"
            select=".[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'AG']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'BD']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'BE']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'CD']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'CIT']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'CPI']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'CR']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'EP']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'EPP']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'EV']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'EVI']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'EX']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'GL']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'GR']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'GV']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'HV']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'HY']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'IM']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'IN']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'INV']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'IP']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'IV']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'KY']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'MA']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'ND']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'OF']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'OR']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'ORI']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'ORC']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'OV']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'OP']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'PC']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'PE']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'PF']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'PN']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'PNI']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'PR']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'PS']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'PV']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'RB']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'REP']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'RP']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'RPP']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'RV']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'SA']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'SE']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'SV']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'TD']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'TP']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'TPV']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'TR']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'TV']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'VAR']]] or .[descendant::text()[1][ancestor::t:seg[@subtype = 'supplied' and substring(@ana, 2) = 'VIS']]]"/>
        <xsl:variable name="lastword">
            <xsl:choose>
                <xsl:when
                    test=".[string-length() > 20]//*/t:seg[@type = 'incipit'][last()][not(descendant::text()[string-length() > 1])]">
                    <xsl:text>\textit{</xsl:text>
                    <xsl:value-of
                        select="tokenize(normalize-space(.[string-length() > 20]//*/t:seg[@type = 'incipit'][last()][not(descendant::text()[string-length() > 1])]), ' ')[last()]"/>
                    <xsl:text>}</xsl:text>
                </xsl:when>
                <xsl:when
                    test=".[string-length() > 20]//t:seg[@type = 'incipit'][last()][not(descendant::text()[string-length() > 1])]">
                    <xsl:text>\textit{</xsl:text>
                    <xsl:value-of
                        select="tokenize(normalize-space(.[string-length() > 20]//t:seg[@type = 'incipit'][last()][not(descendant::text()[string-length() > 1])]), ' ')[last()]"/>
                    <xsl:text>}</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of
                        select="tokenize(normalize-space(.[string-length() > 20]), ' ')[last()]"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="firstword">
            <xsl:choose>
                <xsl:when
                    test=".[string-length() > 20][descendant::text()[1][ancestor::t:seg[@type = 'incipit']]]">
                    <xsl:choose>
                        <xsl:when test="$exclude_genres"/>
                        <xsl:when test=".[descendant::text()[1][ancestor::t:seg[@corresp]]]"/>
                        <xsl:otherwise>
                            <xsl:value-of select="./t:seg[@type = 'incipit'][1]/substring(@ana, 2)"
                            />
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:choose>
                        <xsl:when
                            test="normalize-space(.[string-length() > 20]//*/t:seg[@type = 'incipit'][1][not(preceding-sibling::text())])">
                            <xsl:text> \textit{</xsl:text>
                            <xsl:value-of
                                select="tokenize(normalize-space(.[string-length() > 20]//*/t:seg[@type = 'incipit'][1][not(preceding-sibling::text())]), ' ')[1]"/>
                            <xsl:text>}</xsl:text>
                        </xsl:when>
                        <xsl:when
                            test="normalize-space(.[string-length() > 20]//t:seg[@type = 'incipit'][1][not(preceding-sibling::text())])">
                            <xsl:text> \textit{</xsl:text>
                            <xsl:value-of
                                select="tokenize(normalize-space(.[string-length() > 20]//t:seg[@type = 'incipit'][1][not(preceding-sibling::text())]), ' ')[1]"/>
                            <xsl:text>}</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of
                                select="tokenize(normalize-space(.[string-length() > 20]), ' ')[1]"
                            />
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of
                        select="tokenize(normalize-space(.[string-length() > 20]), ' ')[1]"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:variable name="tractate"
            select="//t:item[@xml:id = current()/substring-after(@source, '#')]"/>
        <xsl:variable name="zitat">
            <xsl:value-of select="$tractate/t:bibl/t:author"/>
            <xsl:text>, </xsl:text>
            <xsl:value-of select="$tractate/t:bibl/t:title"/>
            <xsl:text>, </xsl:text>
            <xsl:value-of select="$tractate/t:bibl/t:series"/>
            <xsl:text>: cap. </xsl:text>
            <xsl:choose>
                <xsl:when test="contains(@n, ';')">
                    <xsl:value-of select="substring-before(@n, ';')"/>
                    <xsl:text>, </xsl:text>
                    <xsl:value-of select="substring-after(@n, ';')"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="@n"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:text>\edtext{</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>}{\lemma{</xsl:text>
        <xsl:value-of select="$firstword"/>
        <xsl:text>\ldots </xsl:text>
        <xsl:value-of select="$lastword"/>
        <xsl:text>}\Afootnote{</xsl:text>
        <xsl:value-of select="$zitat"/>
        <xsl:text>}}</xsl:text>
    </xsl:template>

    <xsl:template match="t:head">
        <xsl:if test="string-length() > 0">
            <xsl:choose>
                <xsl:when
                    test="./text()[contains(., 'KOMMENTAR')] | t:head/t:note[@type = 'supplied']/text()[contains(., 'KOMMENTAR')]">
                    <xsl:text xml:space="preserve"/>
                </xsl:when>
                <xsl:when test="./t:note[@type = 'supplied']">
                    <xsl:text>\pstart \eledsection*{\markright{&lt;</xsl:text>
                    <xsl:value-of select="./t:note[@type = 'supplied']"/>
                    <xsl:text>&gt;}</xsl:text>
                    <xsl:text>&lt;</xsl:text>
                    <xsl:value-of select="."/>
                    <xsl:text>&gt;}\pend </xsl:text>
                    <xsl:text>&#xd;</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>\pstart \eledsection*{\markright{</xsl:text>
                    <xsl:value-of select="."/>
                    <xsl:text>}</xsl:text>
                    <xsl:value-of select="."/>
                    <xsl:text>}\pend </xsl:text>
                    <xsl:text>&#xd;</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
    </xsl:template> 

    <xsl:template match="t:seg[@type = 'incipit']">
        <xsl:variable name="exclude_genres"
            select="@subtype = 'supplied' and substring(@ana, 2) = 'AG' or @subtype = 'supplied' and substring(@ana, 2) = 'BD' or @subtype = 'supplied' and substring(@ana, 2) = 'BE' or @subtype = 'supplied' and substring(@ana, 2) = 'CD' or @subtype = 'supplied' and substring(@ana, 2) = 'CIT' or @subtype = 'supplied' and substring(@ana, 2) = 'CPI' or @subtype = 'supplied' and substring(@ana, 2) = 'CR' or @subtype = 'supplied' and substring(@ana, 2) = 'EP' or @subtype = 'supplied' and substring(@ana, 2) = 'EPP' or @subtype = 'supplied' and substring(@ana, 2) = 'EV' or @subtype = 'supplied' and substring(@ana, 2) = 'EVI' or @subtype = 'supplied' and substring(@ana, 2) = 'EX' or @subtype = 'supplied' and substring(@ana, 2) = 'GL' or @subtype = 'supplied' and substring(@ana, 2) = 'GR' or @subtype = 'supplied' and substring(@ana, 2) = 'GV' or @subtype = 'supplied' and substring(@ana, 2) = 'HV' or @subtype = 'supplied' and substring(@ana, 2) = 'HY' or @subtype = 'supplied' and substring(@ana, 2) = 'IM' or @subtype = 'supplied' and substring(@ana, 2) = 'IN' or @subtype = 'supplied' and substring(@ana, 2) = 'INV' or @subtype = 'supplied' and substring(@ana, 2) = 'IP' or @subtype = 'supplied' and substring(@ana, 2) = 'IV' or @subtype = 'supplied' and substring(@ana, 2) = 'KY' or @subtype = 'supplied' and substring(@ana, 2) = 'MA' or @subtype = 'supplied' and substring(@ana, 2) = 'ND' or @subtype = 'supplied' and substring(@ana, 2) = 'OF' or @subtype = 'supplied' and substring(@ana, 2) = 'OR' or @subtype = 'supplied' and substring(@ana, 2) = 'ORI' or @subtype = 'supplied' and substring(@ana, 2) = 'ORC' or @subtype = 'supplied' and substring(@ana, 2) = 'OV' or @subtype = 'supplied' and substring(@ana, 2) = 'OP' or @subtype = 'supplied' and substring(@ana, 2) = 'PC' or @subtype = 'supplied' and substring(@ana, 2) = 'PE' or @subtype = 'supplied' and substring(@ana, 2) = 'PF' or @subtype = 'supplied' and substring(@ana, 2) = 'PN' or @subtype = 'supplied' and substring(@ana, 2) = 'PNI' or @subtype = 'supplied' and substring(@ana, 2) = 'PR' or @subtype = 'supplied' and substring(@ana, 2) = 'PS' or @subtype = 'supplied' and substring(@ana, 2) = 'PV' or @subtype = 'supplied' and substring(@ana, 2) = 'RB' or @subtype = 'supplied' and substring(@ana, 2) = 'REP' or @subtype = 'supplied' and substring(@ana, 2) = 'RP' or @subtype = 'supplied' and substring(@ana, 2) = 'RPP' or @subtype = 'supplied' and substring(@ana, 2) = 'RV' or @subtype = 'supplied' and substring(@ana, 2) = 'SA' or @subtype = 'supplied' and substring(@ana, 2) = 'SE' or @subtype = 'supplied' and substring(@ana, 2) = 'SV' or @subtype = 'supplied' and substring(@ana, 2) = 'TD' or @subtype = 'supplied' and substring(@ana, 2) = 'TP' or @subtype = 'supplied' and substring(@ana, 2) = 'TPV' or @subtype = 'supplied' and substring(@ana, 2) = 'TR' or @subtype = 'supplied' and substring(@ana, 2) = 'TV' or @subtype = 'supplied' and substring(@ana, 2) = 'VAR' or @subtype = 'supplied' and substring(@ana, 2) = 'VIS'"/>
        <xsl:if test="string-length() > 0">
            <xsl:choose>
                <xsl:when test="@rend">
                    <xsl:value-of select="substring(@ana, 2)"/>
                    <xsl:text xml:space="preserve">\footnoteA{\textit{corr., cod. }'</xsl:text>
                    <xsl:value-of select="substring(@rend, 2)"/>
                    <xsl:text>'}</xsl:text>
                </xsl:when>
                <!-- <xsl:when test="@subtype = 'supplied' and substring(@ana, 2)='VS'">
                    <xsl:text>&lt;</xsl:text>
                    <xsl:text>\textjuni{\char"2123}</xsl:text>
                    <xsl:text>&gt;</xsl:text>
                </xsl:when>-->
                <xsl:when test="starts-with(@corresp,'#')"/>
                <xsl:when test="$exclude_genres"/>
                <xsl:when test="@subtype = 'supplied'">
                    <xsl:text>&lt;</xsl:text>
                    <xsl:value-of select="substring(@ana, 2)"/>
                    <xsl:text>&gt;</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="substring(@ana, 2)"/>
                </xsl:otherwise>
            </xsl:choose>
            <!-- <xsl:choose>
                <xsl:when test="parent::t:metamark"><xsl:text xml:space="preserve">\textit{</xsl:text></xsl:when>
                <xsl:otherwise><xsl:text xml:space="preserve"> \textit{</xsl:text></xsl:otherwise>
            </xsl:choose>-->
            <xsl:text xml:space="preserve"> \textit{</xsl:text>
            <xsl:apply-templates/>
            <xsl:text>}</xsl:text>
            <xsl:text>\edindex[incipits]{</xsl:text>
            <xsl:value-of select=".//text()[not(ancestor::t:sic)]"/>
            <xsl:text> (</xsl:text>
            <xsl:value-of select="substring(@ana, 2)"/>
            <xsl:text>): </xsl:text>
            <xsl:value-of select="@n"/>
            <xsl:text>}</xsl:text>
        </xsl:if>
    </xsl:template>
    <xsl:template match="t:seg[@type = 'incipit']" mode="leermetamarks">
        <xsl:variable name="exclude_genres"
            select="@subtype = 'supplied' and substring(@ana, 2) = 'AG' or @subtype = 'supplied' and substring(@ana, 2) = 'BD' or @subtype = 'supplied' and substring(@ana, 2) = 'BE' or @subtype = 'supplied' and substring(@ana, 2) = 'CD' or @subtype = 'supplied' and substring(@ana, 2) = 'CIT' or @subtype = 'supplied' and substring(@ana, 2) = 'CPI' or @subtype = 'supplied' and substring(@ana, 2) = 'CR' or @subtype = 'supplied' and substring(@ana, 2) = 'EP' or @subtype = 'supplied' and substring(@ana, 2) = 'EPP' or @subtype = 'supplied' and substring(@ana, 2) = 'EV' or @subtype = 'supplied' and substring(@ana, 2) = 'EVI' or @subtype = 'supplied' and substring(@ana, 2) = 'EX' or @subtype = 'supplied' and substring(@ana, 2) = 'GL' or @subtype = 'supplied' and substring(@ana, 2) = 'GR' or @subtype = 'supplied' and substring(@ana, 2) = 'GV' or @subtype = 'supplied' and substring(@ana, 2) = 'HV' or @subtype = 'supplied' and substring(@ana, 2) = 'HY' or @subtype = 'supplied' and substring(@ana, 2) = 'IM' or @subtype = 'supplied' and substring(@ana, 2) = 'IN' or @subtype = 'supplied' and substring(@ana, 2) = 'INV' or @subtype = 'supplied' and substring(@ana, 2) = 'IP' or @subtype = 'supplied' and substring(@ana, 2) = 'IV' or @subtype = 'supplied' and substring(@ana, 2) = 'KY' or @subtype = 'supplied' and substring(@ana, 2) = 'MA' or @subtype = 'supplied' and substring(@ana, 2) = 'ND' or @subtype = 'supplied' and substring(@ana, 2) = 'OF' or @subtype = 'supplied' and substring(@ana, 2) = 'OR' or @subtype = 'supplied' and substring(@ana, 2) = 'ORI' or @subtype = 'supplied' and substring(@ana, 2) = 'ORC' or @subtype = 'supplied' and substring(@ana, 2) = 'OV' or @subtype = 'supplied' and substring(@ana, 2) = 'OP' or @subtype = 'supplied' and substring(@ana, 2) = 'PC' or @subtype = 'supplied' and substring(@ana, 2) = 'PE' or @subtype = 'supplied' and substring(@ana, 2) = 'PF' or @subtype = 'supplied' and substring(@ana, 2) = 'PN' or @subtype = 'supplied' and substring(@ana, 2) = 'PNI' or @subtype = 'supplied' and substring(@ana, 2) = 'PR' or @subtype = 'supplied' and substring(@ana, 2) = 'PS' or @subtype = 'supplied' and substring(@ana, 2) = 'PV' or @subtype = 'supplied' and substring(@ana, 2) = 'RB' or @subtype = 'supplied' and substring(@ana, 2) = 'REP' or @subtype = 'supplied' and substring(@ana, 2) = 'RP' or @subtype = 'supplied' and substring(@ana, 2) = 'RPP' or @subtype = 'supplied' and substring(@ana, 2) = 'RV' or @subtype = 'supplied' and substring(@ana, 2) = 'SA' or @subtype = 'supplied' and substring(@ana, 2) = 'SE' or @subtype = 'supplied' and substring(@ana, 2) = 'SV' or @subtype = 'supplied' and substring(@ana, 2) = 'TD' or @subtype = 'supplied' and substring(@ana, 2) = 'TP' or @subtype = 'supplied' and substring(@ana, 2) = 'TPV' or @subtype = 'supplied' and substring(@ana, 2) = 'TR' or @subtype = 'supplied' and substring(@ana, 2) = 'TV' or @subtype = 'supplied' and substring(@ana, 2) = 'VAR' or @subtype = 'supplied' and substring(@ana, 2) = 'VIS'"/>
        <xsl:if test="string-length() > 0">
            <xsl:choose>
                <xsl:when test="@rend">
                    <xsl:value-of select="substring(@ana, 2)"/>
                    <xsl:text xml:space="preserve">\footnoteA{\textit{corr., cod. }'</xsl:text>
                    <xsl:value-of select="substring(@rend, 2)"/>
                    <xsl:text>'}</xsl:text>
                </xsl:when>
                <!-- <xsl:when test="@subtype = 'supplied' and substring(@ana, 2)='VS'">
                    <xsl:text>&lt;</xsl:text>
                    <xsl:text>\textjuni{\char"2123}</xsl:text>
                    <xsl:text>&gt;</xsl:text>
                </xsl:when>-->
                <xsl:when test="starts-with(@corresp,'#')"/>
                <xsl:when test="$exclude_genres"/>
                <xsl:when test="@subtype = 'supplied'">
                    <xsl:text>&lt;</xsl:text>
                    <xsl:value-of select="substring(@ana, 2)"/>
                    <xsl:text>&gt;</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="substring(@ana, 2)"/>
                </xsl:otherwise>
            </xsl:choose>
            <!-- <xsl:choose>
                <xsl:when test="parent::t:metamark"><xsl:text xml:space="preserve">\textit{</xsl:text></xsl:when>
                <xsl:otherwise><xsl:text xml:space="preserve"> \textit{</xsl:text></xsl:otherwise>
            </xsl:choose>-->
            <xsl:text xml:space="preserve"> \textit{</xsl:text>
            <xsl:apply-templates/>
            <xsl:text>}</xsl:text>
            <xsl:text>\edindex[incipits]{</xsl:text>
            <xsl:value-of select=".//text()[not(ancestor::t:sic)]"/>
            <xsl:text> (</xsl:text>
            <xsl:value-of select="substring(@ana, 2)"/>
            <xsl:text>): </xsl:text>
            <xsl:value-of select="@n"/>
            <xsl:text>}</xsl:text>
        </xsl:if>
    </xsl:template>
    
    
    

</xsl:stylesheet>
