<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet exclude-result-prefixes="#all"
    version="2.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    
    <!-- This XSLT transforms a set of EpiDoc documents into a Solr
       index document representing an index of fragments in those
       documents. -->
    
    <xsl:import href="epidoc-index-utils.xsl" />
    
    <xsl:param name="index_type" />
    <xsl:param name="subdirectory" />
    
    
    <xsl:template match="/">
        <add>
            <xsl:for-each-group select="//tei:orig[not(parent::tei:del or parent::tei:choice)] | //tei:w[@part != 'N']" group-by=".">
                <doc>
                    <field name="document_type">
                        <xsl:value-of select="$subdirectory" />
                        <xsl:text>_</xsl:text>
                        <xsl:value-of select="$index_type" />
                        <xsl:text>_index</xsl:text>
                    </field>
                    <xsl:call-template name="field_file_path" />
                    <field name="index_item_name">
                        <xsl:value-of select="." />
                    </field>
                    <field name="language_code">
                        <xsl:value-of select="ancestor-or-self::*[@xml:lang][1]/@xml:lang"/>
                    </field>
                    <xsl:apply-templates select="current-group()" />
                </doc>
            </xsl:for-each-group>
        </add>
    </xsl:template>
    
    <xsl:template match="tei:orig|tei:w">
        <xsl:call-template name="field_index_instance_location" />
    </xsl:template>
    
</xsl:stylesheet>

