<xsl:stylesheet version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:npo="http://xmlns.sven.to/npo"
    xmlns:str="http://exslt.org/strings"
    extension-element-prefixes="str npo">
<npo:comment>[hosts]
        Filter a scan by a list of hosts so that only the specified hosts are in the output.
        Filter a list of hosts from scan result by its IP address. Expects a comma-separated list as input.
        You can pipe the output, for instance:
            nmap-parse-output scan.xml include '192.168.1.1,192.168.1.20' | nmap-parse-output - service-names
</npo:comment>
<!-- see http://exslt.org/str/index.html -->


<xsl:variable name="include-hosts" select="str:tokenize($param1, ',')" />

<xsl:output method="xml" indent="yes"/>
<xsl:strip-space elements="*" />

<xsl:template match="@*|node()">
 <xsl:copy>
  <xsl:apply-templates select="@*|node()"/>
 </xsl:copy>
</xsl:template>

<!-- Filter: -->
<xsl:template match="/nmaprun/host">
    <xsl:if test="$include-hosts = ./address/@addr">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:if>
</xsl:template>

</xsl:stylesheet>
