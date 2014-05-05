<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xhtml="http://www.w3.org/1999/xhtml">

	<xsl:output indent="yes"/>

	<xsl:param name="projectname"/>
	<xsl:param name="projectversion"/>
	<xsl:param name="projectreleasedate"/>
	<xsl:param name="dependenciestxt"/>

	<xsl:template match="/COMPONENT/CODEGENERATION/IMPORTS">
		<xsl:element name="IMPORTS">
		<xsl:for-each select="tokenize(unparsed-text($dependenciestxt), '\r?\n')">
			<xsl:analyze-string select="." regex="^.*[\\/](([^\\/]*)\.[^.]*)$">
				<xsl:matching-substring>
			<xsl:element name="IMPORT">
				<xsl:attribute name="MODULE"><xsl:value-of select="regex-group(1)"/></xsl:attribute>
				<xsl:attribute name="NAME"><xsl:value-of select="regex-group(2)"/></xsl:attribute>
				<xsl:attribute name="REQUIRED">true</xsl:attribute>
			</xsl:element>
				</xsl:matching-substring>
			</xsl:analyze-string>
		</xsl:for-each>
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="/COMPONENT/HEADER">
		<xsl:copy>
			<xsl:copy-of select="@*"/>
			<xsl:attribute name="SHORTNAME"><xsl:value-of select="$projectname"/></xsl:attribute>
			<xsl:attribute name="VERSION"><xsl:value-of select="$projectversion"/></xsl:attribute>
			<xsl:attribute name="RELEASE_DATE"><xsl:value-of select="$projectreleasedate"/></xsl:attribute>
			<xsl:apply-templates/>
		</xsl:copy>
	</xsl:template>
	
	<!-- standard copy template -->
	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*"/>
			<xsl:apply-templates/>
		</xsl:copy>
	</xsl:template>	
</xsl:stylesheet>