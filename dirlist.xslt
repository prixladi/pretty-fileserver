<?xml version="1.0"?>
<!DOCTYPE fnord [<!ENTITY nbsp "&#160;">]>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xhtml="http://www.w3.org/1999/xhtml" xmlns="http://www.w3.org/1999/xhtml" xmlns:func="http://exslt.org/functions" xmlns:str="http://exslt.org/strings" version="1.1" exclude-result-prefixes="xhtml" extension-element-prefixes="func str">
  <xsl:output method="xml" version="1.0" encoding="UTF-8" doctype-public="-//W3C//DTD XHTML 1.1//EN" doctype-system="http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd" indent="no" media-type="application/xhtml+xml"/>
  <xsl:strip-space elements="*" />

  <xsl:template name="size">
    <!-- transform a size in bytes into a human readable representation -->
    <xsl:param name="bytes"/>
    <xsl:choose>
      <xsl:when test="$bytes &lt; 1000"><xsl:value-of select="$bytes" />B</xsl:when>
      <xsl:when test="$bytes &lt; 1048576"><xsl:value-of select="format-number($bytes div 1024, '0.0')" />K</xsl:when>
      <xsl:when test="$bytes &lt; 1073741824"><xsl:value-of select="format-number($bytes div 1048576, '0.0')" />M</xsl:when>
      <xsl:otherwise><xsl:value-of select="format-number(($bytes div 1073741824), '0.00')" />G</xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template name="timestamp">
    <xsl:param name="iso-timestamp" />
    <xsl:value-of select="concat(substring($iso-timestamp, 0, 11), ' ', substring($iso-timestamp, 12, 5))" />
  </xsl:template>


  <xsl:template match="directory">
    <tr>
      <td class="n"><a href="{str:encode-uri(current(),true())}/"><xsl:value-of select="."/></a>/</td>
      <td class="m"><xsl:call-template name="timestamp"><xsl:with-param name="iso-timestamp" select="@mtime" /></xsl:call-template></td>
      <td class="s">- &nbsp;</td>
      <td class="t">Directory</td>
    </tr>
  </xsl:template>

  <xsl:template match="file">
    <tr>
      <td class="n"><a href="{str:encode-uri(current(),true())}"><xsl:value-of select="." /></a></td>
      <td class="m"><xsl:call-template name="timestamp"><xsl:with-param name="iso-timestamp" select="@mtime" /></xsl:call-template></td>
      <td class="s"><xsl:call-template name="size"><xsl:with-param name="bytes" select="@size" /></xsl:call-template></td>
      <td class="t">File</td>
    </tr>
  </xsl:template>

  <xsl:template match="/">
    <html>
      <head>
        <link rel="stylesheet" href="/assets/dirlist.css" type="text/css" media="all" />
        <script src="/js/dirlist.js"></script>
        <title>Shamyr FTP | Index of <xsl:value-of select="$path"/></title>
        <xsl:choose>
            <xsl:when test="count(//file[text()='Readme.html'])=1"><script>writeReadmeHtml("Readme.html")</script></xsl:when>
            <xsl:when test="count(//file[text()='Readme.htm'])=1"><script>writeReadmeHtml("Readme.htm")</script></xsl:when>
            <xsl:when test="count(//file[text()='Readme'])=1"><script>writeReadmeText("Readme")</script></xsl:when>
            <xsl:when test="count(//file[text()='Readme.txt'])=1"><script>writeReadmeText("Readme.txt")</script></xsl:when>
        </xsl:choose>
      </head>
      <body>
        <h2>Shamyr FTP | Index of <xsl:value-of select="$path"/></h2>
        <div class="list">
          <table summary="Directory Listing" cellpadding="0" cellspacing="0">
            <thead>
              <tr><th class="n">Name</th><th class="m">Last Modified</th><th class="s">Size</th><th class="t">Type</th></tr>
            </thead>
            <tfoot>
              <tr>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td colspan="4">
                  <xsl:value-of select="count(//directory)"/> directories,
                  <xsl:value-of select="count(//file)"/> files,
                  <xsl:call-template name="size"><xsl:with-param name="bytes" select="sum(//file/@size)" /></xsl:call-template> total
                </td>
              </tr>
            </tfoot>
            <tbody>
              <tr><td class="n"><a href="../">Parent Directory</a>/</td><td class="m">&nbsp;</td><td class="s">- &nbsp;</td><td class="t">Directory</td></tr>
              <xsl:apply-templates />
            </tbody>
          </table>
        </div>
        <div id="foot" />
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>