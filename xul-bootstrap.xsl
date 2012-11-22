<?xml version="1.0"?>
<!--
    XUL-Bootstrap is a single XSLT file designed to translate some XUL elements into HTML ones, using Twitter Bootstrap graphical components
    Copyright (C) 2012 Charles-Edouard Coste

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" indent="yes" />

<xsl:template match="window">
  <html>
    <head>
      <title><xsl:value-of select="@title" /></title>
      <link href="assets/css/bootstrap.min.css" rel="stylesheet" />
      <script src="assets/js/jquery.min.js"></script>
      <script src="assets/js/bootstrap.min.js"></script>
      <style type="text/css">

        body {
          padding-bottom: 40px;
          padding-top: 60px;
        }

        .row {
          margin-bottom : 20px;
        }
      </style>
    </head>
    <body>
      <xsl:apply-templates select="menubar" />
      <div class="container">
        <xsl:apply-templates select="*[.!=preceding-sibling::menubar]" />
      </div>
    </body>
  </html>
</xsl:template>

<!-- Template for status bars -->
<xsl:template match="statusbar">
<div class="navbar navbar-fixed-bottom">
  <div class="navbar-inner">
    <div class="container">
      <ul class="nav">
        <xsl:apply-templates />
      </ul>
    </div>
  </div>
</div>
</xsl:template>

<!-- Template for main menu bars (attached to the window) -->
<xsl:template match="window/menubar">
<div class="navbar navbar-fixed-top">
  <div class="navbar-inner">
    <div class="container">
      <ul class="nav">
        <xsl:apply-templates />
      </ul>
    </div>
  </div>
</div>
</xsl:template>

<!-- Template for any menu bar (may be found anywhere in the page/screen) -->
<xsl:template match="menubar">
<div class="navbar">
  <div class="navbar-inner">
    <div class="container">
      <ul class="nav">
        <xsl:apply-templates />
      </ul>
    </div>
  </div>
</div>
</xsl:template>

<!-- Toolbar separator for menu bars -->
<xsl:template match="menubar/toolbarseparator">
  <li class="divider-vertical"></li>
</xsl:template>

<xsl:template match="menubar/label">
  <li class="disabled">
    <a href="#"><xsl:value-of select="@value" /></a>
  </li>
</xsl:template>

<xsl:template match="statusbar/statusbarpanel">
  <li class="disabled">
    <a href="#"><xsl:value-of select="@label" /></a>
  </li>
</xsl:template>

<xsl:template match="menubar/menu">
  <li class="dropdown">
    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
      <xsl:value-of select="@label" />
      <b class="caret"></b>
    </a>
    <xsl:apply-templates />
  </li>
</xsl:template>

<xsl:template match="menupopup">
  <ul class="dropdown-menu">
    <xsl:apply-templates />
  </ul>
</xsl:template>

<xsl:template match="menupopup/menuseparator">
  <li class="divider"></li>
</xsl:template>

<xsl:template match="menupopup/menuitem">
  <li>
    <a href="#"><xsl:value-of select="@label" /></a>
  </li>
</xsl:template>

<xsl:template match="vbox">
  <div>
    <xsl:apply-templates />
  </div>
</xsl:template>

<xsl:template match="groupbox">
  <div class="span12">
    <xsl:apply-templates />
  </div>
</xsl:template>

<xsl:template match="caption">
  <p><xsl:value-of select="@label" /></p>
</xsl:template>

<xsl:template match="hbox">
  <xsl:variable name="count">
    <xsl:value-of select="(12 div (sum(*/@flex)) - count(*[not(@flex)]))" />
  </xsl:variable>
  <div class="row">
    <xsl:for-each select="*">
      <xsl:choose>
        <xsl:when test="@flex">
          <xsl:apply-templates select=".">
            <xsl:with-param name="span" select="round(@flex * $count)" />
          </xsl:apply-templates>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates select=".">
            <xsl:with-param name="span" select="1" />
          </xsl:apply-templates>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
  </div>
</xsl:template>

<xsl:template match="/*/description">
  <div class="page-header">
    <h2><xsl:value-of select="." /></h2>
  </div>
</xsl:template>

<xsl:template match="/*/caption">
  <h2><xsl:value-of select="@label" /></h2>
</xsl:template>

<xsl:template match="/*/*/caption">
  <h4><xsl:value-of select="@label" /></h4>
</xsl:template>

<xsl:template match="/*/*/*/caption">
  <h4><xsl:value-of select="@label" /></h4>
</xsl:template>

<xsl:template match="description">
  <p><xsl:value-of select="." /></p>
</xsl:template>

<xsl:template match="tabs">
    <ul class="nav nav-tabs">
      <xsl:for-each select="tab">
          <li>
            <xsl:if test="position() = 1">
              <xsl:attribute name="class"><xsl:text>active</xsl:text></xsl:attribute>
            </xsl:if>
            <a data-toggle="tab" href="#{generate-id(../..)}-{position()}">
              <xsl:value-of select="@label" />
            </a>
          </li>
      </xsl:for-each>
    </ul>
</xsl:template>

<xsl:template match="tabpanels">
  <div class="tab-content">
    <xsl:for-each select="label">
      <div class="tab-pane" id="{generate-id(../..)}-{position()}">
        <xsl:if test="position() = 1">
          <xsl:attribute name="class"><xsl:text>tab-pane active</xsl:text></xsl:attribute>
        </xsl:if>
        <p><xsl:value-of select="@value" /></p>
      </div>
    </xsl:for-each>
  </div>
</xsl:template>

<xsl:template match="tabbox">
  <div class="tabbable"> <!-- Only required for left/right tabs -->
    <xsl:apply-templates />
  </div>
   <hr />
</xsl:template>


<!-- Buttons - start -->

<xsl:template match="button[@type='menu']">
<xsl:param name="span" />
<div class="btn-group span{$span}">
    <button class="btn dropdown-toggle" data-toggle="dropdown">
      <xsl:value-of select="@label" />
      <span class="caret"></span>
    </button>
    <xsl:apply-templates />
  </div>
</xsl:template>

<xsl:template match="button[@type='menu-button']">
<xsl:param name="span" />
<div class="btn-group span{$span}">
<button class="btn"><xsl:value-of select="@label" /></button>
<button class="btn dropdown-toggle" data-toggle="dropdown">
<span class="caret"></span>
</button>
<xsl:apply-templates />
</div>
</xsl:template>

<xsl:template match="button[@default='true']">
<xsl:param name="span" />
<button class="btn btn-primary span{$span}"><xsl:value-of select="@label" /><xsl:apply-templates /></button>
</xsl:template>

<xsl:template match="button[@disabled='true']">
<xsl:param name="span" />
<button class="btn span{$span}" disabled="disabled"><xsl:value-of select="@label" /><xsl:apply-templates /></button>
</xsl:template>

<xsl:template match="button[@checked='true']">
<xsl:param name="span" />
<button class="btn active span{$span}" checked="checked"><xsl:value-of select="@label" /><xsl:apply-templates /></button>
</xsl:template>

<xsl:template match="button[@hidden='true']">
<xsl:param name="span" />
<button class="btn span{$span}" style="display:none" ><xsl:value-of select="@label" /></button>
</xsl:template>

<xsl:template match="button">
<xsl:param name="span" />
<button class="btn span{$span}" ><xsl:value-of select="@label" /></button>
</xsl:template>

<!-- Buttons - stop -->

<xsl:template match="spacer">
<xsl:param name="span" />
<div class="span{$span}" />
</xsl:template>

<!-- Checkboxes - start -->
<xsl:template match="checkbox" >
  <label class="checkbox">
    <input type="checkbox">
      <xsl:if test="@checked = 'true'">
        <xsl:attribute name="checked">checked</xsl:attribute>
      </xsl:if>
    </input>
    <xsl:value-of select="@label" />
  </label>
</xsl:template>
<!-- Checkboxes - stop -->

<!-- Textbox - start -->
<xsl:template match="textbox[@type='password']" >
  <input type="password" value="@value" />
</xsl:template>

<xsl:template match="textbox[@multiline='true']" >
  <textarea><xsl:value-of select="@value" /></textarea>
</xsl:template>

<xsl:template match="textbox" >
  <input type="text" value="@value" />
</xsl:template>
<!-- Textbox - stop -->


<xsl:template match="progressmeter[@mode='undetermined']" >
  <div class="progress progress-striped active">
    <div class="bar" style="width: 100%;"></div>
  </div>
</xsl:template>

<xsl:template match="progressmeter">
  <div class="progress progress-striped">
    <div class="bar" style="width: {@value}%;"></div>
  </div>
</xsl:template>

<xsl:template match="script"></xsl:template>

</xsl:stylesheet> 
