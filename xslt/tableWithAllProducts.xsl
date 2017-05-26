<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:r="xml.lprog.isep.pt/rolhas">
    <xsl:output method="xml" indent="yes"
                doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
                doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"/>
    <!-- MAIN TEMPLATE -->
    <xsl:template match="/r:o_rolhas">
        <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
            <head>
                <title>O'Rolhas Winery</title>
                <!-- Kube CSS -->
                <link rel="stylesheet" type="text/css" href="../resources/css/kube.min.css"/>
                <meta name="viewport" content="width=device-width, initial-scale=1"/>
            </head>
            <body>
                <div class="row align-center align-middle">
                    <img class="w10" src="{concat('../', @logo)}" alt="{'logo'}"/>
                </div>
                <div class="row align-center align-middle">
                    <h1>O'Rolhas Winery</h1>
                </div>
            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>