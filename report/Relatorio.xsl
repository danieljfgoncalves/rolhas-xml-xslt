<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:rel="http://www.dei.isep.ipp.pt/lprog">
    <xsl:output method="xml" indent="yes"
                doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
                doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"/>
    <!-- MAIN TEMPLATE -->
    <xsl:template match="rel:relatório">
        <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
            <head>
                <title>
                    <xsl:value-of select="rel:páginaRosto/rel:tema"/>
                </title>
                <!-- Kube CSS -->
                <link rel="stylesheet" type="text/css" href="../resources/css/kube.min.css"/>
                <link rel="stylesheet" type="text/css" href="../resources/css/master.css"/>
                <!-- Kube JS + jQuery are used for some functionality, but are not required for the basic setup -->
                <script src="../resources/js/jquery-2.0.3.min.js" type="text/javascript"/>
                <script src="../resources/js/kube.js" type="text/javascript"/>
                <meta name="viewport" content="width=device-width, initial-scale=1"/>
            </head>
            <body>
                <xsl:call-template name="pagina-rosto"/>
                <div id="kube-component" class="content">
                    <!-- INDICE -->
                    <xsl:call-template name="indice">
                        <xsl:with-param name="root" select="rel:corpo"/>
                    </xsl:call-template>
                    <!-- CORPO -->
                    <xsl:call-template name="seccao">
                        <xsl:with-param name="root" select="rel:corpo"/>
                    </xsl:call-template>
                </div>

            </body>
        </html>
    </xsl:template>

    <!-- CORPO -->
    <xsl:template name="seccao">
        <xsl:param name="root"/>
        <xsl:for-each select="descendant::*[@id and @tituloSecção]">
            <h3 class="section-head" id="{@id}">
                <a href="#{@id}">
                    <xsl:value-of select="@tituloSecção"/>
                </a>
            </h3>
            <xsl:apply-templates/>
        </xsl:for-each>
    </xsl:template>

    <!-- PAGINA DE ROSTO -->
    <xsl:template name="pagina-rosto">
        <!-- TITLE -->
        <div id="hero">
            <img class="w10" src="{rel:páginaRosto/rel:logotipoDEI}" alt="{'dei'}"/>
            <h1 class="w-auto">
                <xsl:value-of select="rel:páginaRosto/rel:tema"/>
            </h1>
            <xsl:apply-templates select="rel:páginaRosto/rel:disciplina"/>
            <p>
                <xsl:apply-templates select="rel:páginaRosto/rel:professor"/>
            </p>
            <p>
                <xsl:apply-templates select="rel:páginaRosto/rel:autor"/>
            </p>
        </div>
    </xsl:template>

    <!-- INDICE -->
    <xsl:template name="indice">
        <xsl:param name="root"/>
        <h3 class="text-center">Índice</h3>
        <nav id="contents">
            <ol>
                <xsl:for-each
                        select="$root/descendant::*[@id and @tituloSecção]|$root/following-sibling::*[@id and @tituloSecção]">
                    <li>
                        <a href="#{@id}">
                            <xsl:value-of select="@tituloSecção"/>
                        </a>
                        <xsl:if test="descendant::*[@id]">
                            <ul>
                                <xsl:for-each select="descendant::*[@id]">
                                    <li>
                                        <a href="#{@id}">
                                            <xsl:value-of select="."/>
                                        </a>
                                    </li>
                                </xsl:for-each>
                            </ul>
                        </xsl:if>
                    </li>
                </xsl:for-each>
            </ol>
        </nav>

    </xsl:template>

    <!-- DISCIPLINA -->
    <xsl:template match="rel:disciplina">
        <p id="hero-lead">
            <xsl:value-of select="rel:designação"/>
            <br/>
            <mark style="margin:12px;">
                <xsl:value-of select="concat(following-sibling::rel:turma, ' &#x2022; ', rel:sigla)"/>
            </mark>
            <br/>
            <span class="muted">
                <xsl:value-of select="following-sibling::rel:data"/>
            </span>
        </p>
    </xsl:template>
    <!-- PROFESSORES -->
    <xsl:template match="rel:professor">
        <xsl:for-each select="self::*">
            <kbd>
                <xsl:value-of select="concat(@sigla, ' &#x2022; ', @tipoAula)"/>
            </kbd>
        </xsl:for-each>
    </xsl:template>
    <!-- AUTORES -->
    <xsl:template match="rel:autor">
        <samp>
            <b>
                <xsl:value-of select="rel:nome"/>
            </b>
            <b>
                <xsl:value-of select="rel:número"/>
            </b>
            <b>
                <xsl:value-of select="rel:mail"/>
            </b>
        </samp>
    </xsl:template>

    <!-- PARAGRAFOS -->
    <xsl:template match="rel:parágrafo">
        <p>
            <xsl:apply-templates select="@* | node()"/>
        </p>
    </xsl:template>
    <!-- NEGRITOS -->
    <xsl:template match="rel:negrito">
        <b>
            <xsl:value-of select="self::*"/>
        </b>
    </xsl:template>
    <!-- ITALICO -->
    <xsl:template match="rel:itálico">
        <i>
            <xsl:value-of select="self::*"/>
        </i>
    </xsl:template>
    <!-- SUBLINHADOS -->
    <xsl:template match="rel:sublinhado">
        <u>
            <xsl:value-of select="self::*"/>
        </u>
    </xsl:template>
    <!-- CITACOES -->
    <xsl:template match="rel:citação">
        <sup>
            <a href="#{self::*}">
                <xsl:value-of select="self::*"/>
            </a>
        </sup>
    </xsl:template>
    <!-- SUBSECCOES -->
    <xsl:template match="rel:subsecção">
        <h3 class="section-head" id="{@id}" style="padding-left:24px;">
            <a href="#{@id}" style="text-decoration:none;">
                <xsl:value-of select="self::*"/>
            </a>
        </h3>
    </xsl:template>
    <!-- LISTA ITEMS -->
    <xsl:template match="rel:listaItems">
        <ol>
            <xsl:apply-templates/>
        </ol>
    </xsl:template>
    <!-- ITEMS -->
    <xsl:template match="rel:item">
        <li>
            <xsl:apply-templates/>
        </li>
    </xsl:template>
    <!-- FIGURA -->
    <xsl:template match="rel:figura">
        <img src="{@src}" alt="{@descrição}"/>
    </xsl:template>
    <!-- CODIGO -->
    <xsl:template match="rel:codigo">
        <div style="border: 1px solid rgba(0, 0, 0, 0.07);padding: 32px;margin-bottom: 16px;">
            <xsl:for-each select="rel:bloco">
                <p>
                    <code>
                        <xsl:value-of select="self::*"/>
                    </code>
                </p>
            </xsl:for-each>
        </div>
    </xsl:template>
    <!-- REFS -->
    <xsl:template match="rel:refWeb">
            <p id="{@idRef}">
                <a href="{rel:URL}" target="_blank">
                    <xsl:value-of select="rel:descrição"/>
                </a>
                <xsl:text> &#x2022; consultado em: </xsl:text>
                <xsl:value-of select="rel:consultadoEm"/>
            </p>
    </xsl:template>


</xsl:stylesheet>