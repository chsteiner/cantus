<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0"
	xmlns:cantus="https://gams.uni-graz.at/cantus/" xmlns:dc="http://purl.org/dc/elements/1.1/"
	xmlns:gams="https://gams.uni-graz.at/o:gams-ontology/#" xmlns:grote="https://gams.uni-graz.at/grotefend/" xmlns:mo="http://purl.org/ontology/mo/"
	xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
	xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
	xmlns:skos="http://www.w3.org/2004/02/skos/core#" xmlns:t="http://www.tei-c.org/ns/1.0" xmlns:rdau="http://rdaregistry.info/Elements/u/">
	<xsl:strip-space elements="*"/>
	
	
	<xsl:variable name="PID" select="//t:idno[@type='PID']"/>
	<xsl:variable name="collection">		
		<xsl:choose>			
			<xsl:when test="$PID='o:cantus.seckau1.pac'"><xsl:text>base</xsl:text></xsl:when>
			<xsl:when test="$PID='o:cantus.seckau1.se1'"><xsl:text>base</xsl:text></xsl:when>
			<xsl:when test="$PID='o:cantus.seckau2'"><xsl:text>base</xsl:text></xsl:when>
			<xsl:when test="$PID='o:cantus.salzburg.ur'"><xsl:text>base</xsl:text></xsl:when>
			<xsl:when test="$PID='o:cantus.passau.ur'"><xsl:text>base</xsl:text></xsl:when>
			<xsl:when test="$PID='o:cantus.stnikola'"><xsl:text>base</xsl:text></xsl:when>
			<xsl:when test="$PID='o:cantus.klosterneuburg.knb1'"><xsl:text>base</xsl:text></xsl:when>
			<xsl:when test="$PID='o:cantus.freising'"><xsl:text>base</xsl:text></xsl:when>
			<xsl:when test="$PID='o:cantus.emmeram.emm2'"><xsl:text>base</xsl:text></xsl:when>
			<xsl:when test="$PID='o:cantus.regensburg'"><xsl:text>base</xsl:text></xsl:when>
			<xsl:when test="$PID='o:cantus.brixen'"><xsl:text>base</xsl:text></xsl:when>
			<xsl:when test="$PID='o:cantus.moosburg'"><xsl:text>base</xsl:text></xsl:when>
			<xsl:when test="$PID='o:cantus.seckau3'"><xsl:text>base</xsl:text></xsl:when>
			<xsl:when test="$PID='o:cantus.hirsau'"><xsl:text>base</xsl:text></xsl:when>
			<xsl:when test="$PID='o:cantus.vorau'"><xsl:text>base</xsl:text></xsl:when>
			<xsl:otherwise><xsl:text>variants</xsl:text></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	
	
	
	
	<xsl:template match="/">
		<rdf:RDF>
			<xsl:apply-templates select="//t:teiHeader | //t:head | //t:div[@type='time:1'] | //t:ab[@type = 'time:2'] | //t:seg[@type = 'incipit'] | //t:seg[@type = 'incipit']/@ana"/>
			<xsl:apply-templates select="//t:metamark" mode="variants"/>
		</rdf:RDF>
	</xsl:template>
	
	<xsl:template match="t:teiHeader">
		<cantus:LO>
			<xsl:attribute name="rdf:about">
				<xsl:value-of select="concat('https://gams.uni-graz.at/',$PID)"/>
			</xsl:attribute>
			<xsl:choose>
			<xsl:when test="$collection='base'"><gams:isMemberOfCollection rdf:resource="https://gams.uni-graz.at/cantus/"/></xsl:when>
			<xsl:otherwise><gams:isMemberOfCollection rdf:resource="https://gams.uni-graz.at/cantus/variants"/></xsl:otherwise>
			</xsl:choose>
			<rdfs:label>
				<xsl:value-of select="//t:titleStmt/t:title[@type = 'short']"/>
			</rdfs:label>
			<skos:preflabel xml:lang="de">
				<xsl:value-of select="//t:titleStmt/t:title[@type = 'short']"/>
			</skos:preflabel>
			<skos:altLabel xml:lang="de">
				<xsl:value-of select="//t:titleStmt/t:title[@type = 'citation']"/>
			</skos:altLabel>
			<skos:altLabel xml:lang="la">
				<xsl:value-of select="//t:titleStmt/t:title[not(@type)]"/>
			</skos:altLabel>
			<xsl:for-each select="//t:altIdentifier/t:placeName">
			<dc:coverage>
				<xsl:value-of select="text()[1]"/>
			</dc:coverage>
			</xsl:for-each>
			<xsl:for-each select="//t:altIdentifier/t:placeName/t:date">
			<dc:date rdf:datatype="http://www.w3.org/2001/XMLSchema#gYear">
				<xsl:value-of select="@to"/>
			</dc:date>
			</xsl:for-each>
			<xsl:for-each select="//t:altIdentifier/t:idno">
			<dc:source>
				<xsl:value-of select="."/>
			</dc:source>
			<rdau:P60052>
				<xsl:value-of select="@n"/>
			</rdau:P60052>
			</xsl:for-each>
			<xsl:for-each select="//t:head">
				<cantus:hasFeast rdf:resource="{concat('https://gams.uni-graz.at/',$PID,'#',@xml:id)}"/>
			</xsl:for-each>
		</cantus:LO>		
	</xsl:template>
	
	<xsl:template match="t:head">
		<grote:Feast>
			<xsl:attribute name="rdf:about">
				<xsl:value-of select="concat('https://gams.uni-graz.at/',$PID,'#',@xml:id)"/>
			</xsl:attribute>
			<rdfs:label>
				<xsl:apply-templates/>	
			</rdfs:label>
			<xsl:if test="@corresp">
				<cantus:feastCode><xsl:value-of select="substring-after(./@corresp,'#')"/></cantus:feastCode>
			</xsl:if>
			<xsl:for-each select="../t:div[@type='time:1']">
				<cantus:hasOffice rdf:resource="{concat('https://gams.uni-graz.at/',$PID,'#',t:ab[@ana='#head']/t:label/@xml:id)}"/>
			</xsl:for-each>
			<xsl:for-each select="..//t:ab[@type = 'time:2']">
				<cantus:hasNocturne rdf:resource="{concat('https://gams.uni-graz.at/',$PID,'#',t:label/@xml:id)}"/>
			</xsl:for-each>
			<xsl:for-each select="..//t:seg[@type = 'incipit']">
				<cantus:hasIncipit rdf:resource="{concat('https://gams.uni-graz.at/',$PID,'#',@xml:id)}"/>
			</xsl:for-each>
			<xsl:for-each select="..//t:seg[@ana = '#person']">
				<cantus:hasPerson><xsl:apply-templates/></cantus:hasPerson>
			</xsl:for-each>
			<xsl:for-each select="..//t:seg[@ana = '#place']">
				<cantus:hasPlace><xsl:apply-templates/></cantus:hasPlace>
			</xsl:for-each>
			<xsl:for-each select="..//t:seg[@ana = '#function']">
				<cantus:hasFunction><xsl:apply-templates/></cantus:hasFunction>
			</xsl:for-each>
				<gams:textualContent>
					<xsl:apply-templates select=".." mode="fulltext"/>
				</gams:textualContent>
			<xsl:for-each select="..//t:metamark">
				<cantus:hasVariant rdf:resource="{concat('https://gams.uni-graz.at/',$PID,'#',@xml:id)}"/>
			</xsl:for-each>
		</grote:Feast>
	</xsl:template>
	
	<xsl:template match="t:metamark" mode="variants">
		<cantus:Variant rdf:about="{concat('https://gams.uni-graz.at/',$PID,'#',@xml:id)}">
			<cantus:partOfLO rdf:resource="{concat('https://gams.uni-graz.at/',$PID)}"/>
			<xsl:for-each select=".//t:seg[@type = 'incipit']">
				<cantus:hasIncipit rdf:resource="{concat('https://gams.uni-graz.at/',$PID,'#',@xml:id)}"/>
			</xsl:for-each>
			<xsl:for-each select="./parent::t:seg[@type = 'incipit']">
				<cantus:partOfIncipit rdf:resource="{concat('https://gams.uni-graz.at/',$PID,'#',@xml:id)}"/>
			</xsl:for-each>
			<xsl:for-each select="./ancestor::t:ab[@type='time:2']">
				<cantus:partOfNocturne rdf:resource="{concat('https://gams.uni-graz.at/',$PID,'#',t:label/@xml:id)}"/>
			</xsl:for-each>
			<xsl:for-each select="./ancestor::t:div[@type='time:1']">
				<cantus:partOfOffice rdf:resource="{concat('https://gams.uni-graz.at/',$PID,'#',t:ab[@ana='#head']/t:label/@xml:id)}"/>
			</xsl:for-each>
			<xsl:for-each select="./ancestor::t:div/t:head">
				<cantus:partOfFeast>
					<xsl:attribute name="rdf:resource">
						<xsl:value-of select="concat('https://gams.uni-graz.at/',$PID,'#',@xml:id)"/>
					</xsl:attribute>
				</cantus:partOfFeast>
			</xsl:for-each>
			<xsl:if test="./descendant::text()">
				<gams:textualContent>
					<xsl:apply-templates select="." mode="fulltext"/>
					<xsl:text> </xsl:text>
				</gams:textualContent>
			</xsl:if>
		</cantus:Variant>
	</xsl:template>
		
	<xsl:template match="t:div[@type='time:1']">
		<cantus:Office rdf:about="{concat('https://gams.uni-graz.at/',$PID,'#',t:ab[@ana='#head']/t:label/@xml:id)}">
			<rdfs:label><xsl:apply-templates select="t:ab[@ana='#head']/t:label"/></rdfs:label>
			<cantus:officeCode><xsl:value-of select="t:ab[@ana='#head']/t:label/@n"/></cantus:officeCode>
			<xsl:for-each select=".//t:seg[@type = 'incipit']">
				<cantus:hasIncipit rdf:resource="{concat('https://gams.uni-graz.at/',$PID,'#',@xml:id)}"/>
			</xsl:for-each>
			<xsl:for-each select=".//t:ab[@type = 'time:2']">
				<cantus:hasNocturne rdf:resource="{concat('https://gams.uni-graz.at/',$PID,'#',t:label/@xml:id)}"/>
			</xsl:for-each>
			<gams:textualContent>
				<xsl:apply-templates select="." mode="fulltext"/>
			</gams:textualContent>
		</cantus:Office>
	</xsl:template>
	<xsl:template match="t:ab[@type = 'time:2']">
		<cantus:Nocturne rdf:about="{concat('https://gams.uni-graz.at/',$PID,'#',t:label/@xml:id)}">
			<rdfs:label><xsl:apply-templates select="t:label"/></rdfs:label>
			<xsl:for-each select=".//t:seg[@type = 'incipit']">
				<cantus:hasIncipit rdf:resource="{concat('https://gams.uni-graz.at/',$PID,'#',@xml:id)}"/>
			</xsl:for-each>
		</cantus:Nocturne>
		
	</xsl:template>
	<xsl:template match="t:seg[@type = 'incipit']">
		<cantus:Incipit rdf:about="{concat('https://gams.uni-graz.at/',$PID,'#',@xml:id)}">
			<rdfs:label><xsl:apply-templates/></rdfs:label>
			<mo:genre rdf:resource="{concat('https://gams.uni-graz.at/cantus/',substring-after(@ana,'#'))}"/>
			<xsl:if test="@n">
				<dc:identifier><xsl:value-of select="@n"/></dc:identifier>
				<xsl:if test="@corresp">
				<cantus:concordance><xsl:value-of select="@corresp"/></cantus:concordance>
				</xsl:if>
			</xsl:if>
			<xsl:if test="contains(./@corresp,'preceding-sibling')">
				<cantus:incipitEnd rdf:datatype="http://www.w3.org/2001/XMLSchema#boolean">true</cantus:incipitEnd>
			</xsl:if>
			<xsl:for-each select=".//t:phr">
				<cantus:hasNeumes><xsl:apply-templates/></cantus:hasNeumes>
			</xsl:for-each>
		</cantus:Incipit>
	</xsl:template>
	
	<xsl:template match="t:seg[@type = 'incipit']/@ana">
		<mo:Genre rdf:about="{concat('https://gams.uni-graz.at/cantus/',substring-after(.,'#'))}">
			<skos:prefLabel><xsl:value-of select="substring-after(.,'#')"/></skos:prefLabel>
			<xsl:for-each select="document('https://gams.uni-graz.at/context:cantus/GENRES')//t:cell[1][text()=substring-after(current(),'#')][normalize-space(.)]">	
				<skos:altLabel xml:lang="la">
						<xsl:value-of select="following-sibling::t:cell/normalize-space()"/>
				</skos:altLabel>
				<xsl:if test="parent::t:row/@corresp">
					<skos:related rdf:resource="http://www.wikidata.org/entity/{parent::t:row/@corresp}"/>
				</xsl:if>
			</xsl:for-each>
		</mo:Genre>
	</xsl:template>
	
	<xsl:template match="t:div[t:head]" mode="fulltext">
		<xsl:apply-templates mode="fulltext"/>
	</xsl:template>
	<xsl:template match="t:head" mode="fulltext">
		<xsl:apply-templates mode="fulltext"/><xsl:text> </xsl:text>
	</xsl:template>
	<xsl:template match="t:ab[not(@ana='#head')]" mode="fulltext">
		<xsl:apply-templates mode="fulltext"/><xsl:text> </xsl:text>
	</xsl:template>
	<xsl:template match="t:ab[@ana='#head']/t:seg" mode="fulltext">
		<xsl:apply-templates mode="fulltext"/><xsl:text> </xsl:text>
	</xsl:template>
	<xsl:template match="t:seg[@type = 'incipit']" mode="fulltext">
		<xsl:text> </xsl:text>
		<xsl:value-of select="lower-case(substring-after(./@ana,'#'))"/>
		<xsl:text> </xsl:text>
		<xsl:apply-templates mode="fulltext"/>
	</xsl:template>
	
	<xsl:template match="t:choice" mode="fulltext #default">
		<xsl:value-of select="lower-case(t:corr)"/>
	</xsl:template>
	<xsl:template match="text()" mode="fulltext #default">
		<xsl:value-of select="translate(lower-case(.),'.,','  ')"/>
	</xsl:template>
	
	
</xsl:stylesheet>
