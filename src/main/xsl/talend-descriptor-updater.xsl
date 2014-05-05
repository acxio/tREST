<?xml version="1.0" encoding="UTF-8"?>

<!--
This file is part of tREST.

tREST is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

tREST is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License
along with tREST.  If not, see <http://www.gnu.org/licenses/>.
-->

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