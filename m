Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1BB17616FC
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232791AbjGYLoP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235022AbjGYLnq (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:43:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750E71BF9
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:43:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20B29616BC
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:43:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07220C433C9;
        Tue, 25 Jul 2023 11:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690285409;
        bh=IF2P76VR3tXhgg7eQy1+LqrEUfHPXSnlbB7znX/ECj0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wC55S5GWndpMS1TmieX8aa4znEAicxqxw1xmPCSne6Hzx98fCKf/auM+mn31YM/TT
         Ppcteu9boUrfX8VJDCsPFn7m2seSFtXTBZ/fRWdur/Kn66IgPFoP/6NBnipW9MohLT
         alL1QIHRMD0+uSSxJpPBAnp/Z2zlyLUgfH5NahSQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 195/313] drm/panel: Initialise panel dev and funcs through drm_panel_init()
Date:   Tue, 25 Jul 2023 12:45:48 +0200
Message-ID: <20230725104529.451984036@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104521.167250627@linuxfoundation.org>
References: <20230725104521.167250627@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

[ Upstream commit 6dbe0c4b0fc0646442b2b1580d022404e582fd7b ]

Instead of requiring all drivers to set the dev and funcs fields of
drm_panel manually after calling drm_panel_init(), pass the data as
arguments to the function. This simplifies the panel drivers, and will
help future refactoring when adding new arguments to drm_panel_init().

The panel drivers have been updated with the following Coccinelle
semantic patch, with manual inspection to verify that no call to
drm_panel_init() with a single argument still exists.

@@
expression panel;
expression device;
identifier ops;
@@
 drm_panel_init(&panel
+	, device, &ops
 );
 ...
(
-panel.dev = device;
-panel.funcs = &ops;
|
-panel.funcs = &ops;
-panel.dev = device;
)

Suggested-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20190823193245.23876-3-laurent.pinchart@ideasonboard.com
Stable-dep-of: 2c56a751845d ("drm/panel: simple: Add connector_type for innolux_at043tn24")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_panel.c                           | 11 ++++++++---
 drivers/gpu/drm/panel/panel-arm-versatile.c           |  4 +---
 drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c |  4 +---
 drivers/gpu/drm/panel/panel-ilitek-ili9322.c          |  4 +---
 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c         |  4 +---
 drivers/gpu/drm/panel/panel-innolux-p079zca.c         |  4 +---
 drivers/gpu/drm/panel/panel-jdi-lt070me05000.c        |  4 +---
 drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c    |  5 ++---
 drivers/gpu/drm/panel/panel-lg-lb035q02.c             |  4 +---
 drivers/gpu/drm/panel/panel-lg-lg4573.c               |  4 +---
 drivers/gpu/drm/panel/panel-lvds.c                    |  4 +---
 drivers/gpu/drm/panel/panel-nec-nl8048hl11.c          |  4 +---
 drivers/gpu/drm/panel/panel-novatek-nt39016.c         |  4 +---
 drivers/gpu/drm/panel/panel-olimex-lcd-olinuxino.c    |  4 +---
 drivers/gpu/drm/panel/panel-orisetech-otm8009a.c      |  4 +---
 drivers/gpu/drm/panel/panel-osd-osd101t2587-53ts.c    |  5 ++---
 drivers/gpu/drm/panel/panel-panasonic-vvx10f034n00.c  |  5 ++---
 drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c |  4 +---
 drivers/gpu/drm/panel/panel-raydium-rm67191.c         |  4 +---
 drivers/gpu/drm/panel/panel-raydium-rm68200.c         |  4 +---
 drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c    |  4 +---
 drivers/gpu/drm/panel/panel-ronbo-rb070d30.c          |  4 +---
 drivers/gpu/drm/panel/panel-samsung-ld9040.c          |  4 +---
 drivers/gpu/drm/panel/panel-samsung-s6d16d0.c         |  4 +---
 drivers/gpu/drm/panel/panel-samsung-s6e3ha2.c         |  4 +---
 drivers/gpu/drm/panel/panel-samsung-s6e63j0x03.c      |  4 +---
 drivers/gpu/drm/panel/panel-samsung-s6e63m0.c         |  4 +---
 drivers/gpu/drm/panel/panel-samsung-s6e8aa0.c         |  4 +---
 drivers/gpu/drm/panel/panel-seiko-43wvf1g.c           |  4 +---
 drivers/gpu/drm/panel/panel-sharp-lq101r1sx01.c       |  4 +---
 drivers/gpu/drm/panel/panel-sharp-ls037v7dw01.c       |  4 +---
 drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c       |  5 ++---
 drivers/gpu/drm/panel/panel-simple.c                  |  4 +---
 drivers/gpu/drm/panel/panel-sitronix-st7701.c         |  4 +---
 drivers/gpu/drm/panel/panel-sitronix-st7789v.c        |  4 +---
 drivers/gpu/drm/panel/panel-sony-acx565akm.c          |  4 +---
 drivers/gpu/drm/panel/panel-tpo-td028ttec1.c          |  4 +---
 drivers/gpu/drm/panel/panel-tpo-td043mtea1.c          |  4 +---
 drivers/gpu/drm/panel/panel-tpo-tpg110.c              |  4 +---
 drivers/gpu/drm/panel/panel-truly-nt35597.c           |  4 +---
 include/drm/drm_panel.h                               |  3 ++-
 41 files changed, 53 insertions(+), 121 deletions(-)

diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
index 6b0bf42039cfa..ba2fad4c96489 100644
--- a/drivers/gpu/drm/drm_panel.c
+++ b/drivers/gpu/drm/drm_panel.c
@@ -44,13 +44,18 @@ static LIST_HEAD(panel_list);
 /**
  * drm_panel_init - initialize a panel
  * @panel: DRM panel
+ * @dev: parent device of the panel
+ * @funcs: panel operations
  *
- * Sets up internal fields of the panel so that it can subsequently be added
- * to the registry.
+ * Initialize the panel structure for subsequent registration with
+ * drm_panel_add().
  */
-void drm_panel_init(struct drm_panel *panel)
+void drm_panel_init(struct drm_panel *panel, struct device *dev,
+		    const struct drm_panel_funcs *funcs)
 {
 	INIT_LIST_HEAD(&panel->list);
+	panel->dev = dev;
+	panel->funcs = funcs;
 }
 EXPORT_SYMBOL(drm_panel_init);
 
diff --git a/drivers/gpu/drm/panel/panel-arm-versatile.c b/drivers/gpu/drm/panel/panel-arm-versatile.c
index 5f72c922a04b1..a4333ed0f20ca 100644
--- a/drivers/gpu/drm/panel/panel-arm-versatile.c
+++ b/drivers/gpu/drm/panel/panel-arm-versatile.c
@@ -350,9 +350,7 @@ static int versatile_panel_probe(struct platform_device *pdev)
 			dev_info(dev, "panel mounted on IB2 daughterboard\n");
 	}
 
-	drm_panel_init(&vpanel->panel);
-	vpanel->panel.dev = dev;
-	vpanel->panel.funcs = &versatile_panel_drm_funcs;
+	drm_panel_init(&vpanel->panel, dev, &versatile_panel_drm_funcs);
 
 	return drm_panel_add(&vpanel->panel);
 }
diff --git a/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c b/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
index dabf59e0f56fa..7d5d7455bc01f 100644
--- a/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
+++ b/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
@@ -204,9 +204,7 @@ static int feiyang_dsi_probe(struct mipi_dsi_device *dsi)
 	mipi_dsi_set_drvdata(dsi, ctx);
 	ctx->dsi = dsi;
 
-	drm_panel_init(&ctx->panel);
-	ctx->panel.dev = &dsi->dev;
-	ctx->panel.funcs = &feiyang_funcs;
+	drm_panel_init(&ctx->panel, &dsi->dev, &feiyang_funcs);
 
 	ctx->dvdd = devm_regulator_get(&dsi->dev, "dvdd");
 	if (IS_ERR(ctx->dvdd)) {
diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9322.c b/drivers/gpu/drm/panel/panel-ilitek-ili9322.c
index 3c58f63adbf7e..ad2405baa0ac5 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9322.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9322.c
@@ -895,9 +895,7 @@ static int ili9322_probe(struct spi_device *spi)
 		ili->input = ili->conf->input;
 	}
 
-	drm_panel_init(&ili->panel);
-	ili->panel.dev = dev;
-	ili->panel.funcs = &ili9322_drm_funcs;
+	drm_panel_init(&ili->panel, dev, &ili9322_drm_funcs);
 
 	return drm_panel_add(&ili->panel);
 }
diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
index 3ad4a46c4e945..1d714f961c009 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
@@ -433,9 +433,7 @@ static int ili9881c_dsi_probe(struct mipi_dsi_device *dsi)
 	mipi_dsi_set_drvdata(dsi, ctx);
 	ctx->dsi = dsi;
 
-	drm_panel_init(&ctx->panel);
-	ctx->panel.dev = &dsi->dev;
-	ctx->panel.funcs = &ili9881c_funcs;
+	drm_panel_init(&ctx->panel, &dsi->dev, &ili9881c_funcs);
 
 	ctx->power = devm_regulator_get(&dsi->dev, "power");
 	if (IS_ERR(ctx->power)) {
diff --git a/drivers/gpu/drm/panel/panel-innolux-p079zca.c b/drivers/gpu/drm/panel/panel-innolux-p079zca.c
index df90b66079816..8f3647804a1e4 100644
--- a/drivers/gpu/drm/panel/panel-innolux-p079zca.c
+++ b/drivers/gpu/drm/panel/panel-innolux-p079zca.c
@@ -487,9 +487,7 @@ static int innolux_panel_add(struct mipi_dsi_device *dsi,
 	if (IS_ERR(innolux->backlight))
 		return PTR_ERR(innolux->backlight);
 
-	drm_panel_init(&innolux->base);
-	innolux->base.funcs = &innolux_panel_funcs;
-	innolux->base.dev = dev;
+	drm_panel_init(&innolux->base, dev, &innolux_panel_funcs);
 
 	err = drm_panel_add(&innolux->base);
 	if (err < 0)
diff --git a/drivers/gpu/drm/panel/panel-jdi-lt070me05000.c b/drivers/gpu/drm/panel/panel-jdi-lt070me05000.c
index ff3e89e61e3fc..7bfdbfbc868ed 100644
--- a/drivers/gpu/drm/panel/panel-jdi-lt070me05000.c
+++ b/drivers/gpu/drm/panel/panel-jdi-lt070me05000.c
@@ -437,9 +437,7 @@ static int jdi_panel_add(struct jdi_panel *jdi)
 		return ret;
 	}
 
-	drm_panel_init(&jdi->base);
-	jdi->base.funcs = &jdi_panel_funcs;
-	jdi->base.dev = &jdi->dsi->dev;
+	drm_panel_init(&jdi->base, &jdi->dsi->dev, &jdi_panel_funcs);
 
 	ret = drm_panel_add(&jdi->base);
 
diff --git a/drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c b/drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c
index 1e7fecab72a9f..bb131749a0b92 100644
--- a/drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c
+++ b/drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c
@@ -391,9 +391,8 @@ static int kingdisplay_panel_add(struct kingdisplay_panel *kingdisplay)
 	if (IS_ERR(kingdisplay->backlight))
 		return PTR_ERR(kingdisplay->backlight);
 
-	drm_panel_init(&kingdisplay->base);
-	kingdisplay->base.funcs = &kingdisplay_panel_funcs;
-	kingdisplay->base.dev = &kingdisplay->link->dev;
+	drm_panel_init(&kingdisplay->base, &kingdisplay->link->dev,
+		       &kingdisplay_panel_funcs);
 
 	return drm_panel_add(&kingdisplay->base);
 }
diff --git a/drivers/gpu/drm/panel/panel-lg-lb035q02.c b/drivers/gpu/drm/panel/panel-lg-lb035q02.c
index ee4379729a5b8..c7b9b47849bb8 100644
--- a/drivers/gpu/drm/panel/panel-lg-lb035q02.c
+++ b/drivers/gpu/drm/panel/panel-lg-lb035q02.c
@@ -196,9 +196,7 @@ static int lb035q02_probe(struct spi_device *spi)
 	if (ret < 0)
 		return ret;
 
-	drm_panel_init(&lcd->panel);
-	lcd->panel.dev = &lcd->spi->dev;
-	lcd->panel.funcs = &lb035q02_funcs;
+	drm_panel_init(&lcd->panel, &lcd->spi->dev, &lb035q02_funcs);
 
 	return drm_panel_add(&lcd->panel);
 }
diff --git a/drivers/gpu/drm/panel/panel-lg-lg4573.c b/drivers/gpu/drm/panel/panel-lg-lg4573.c
index 41bf02d122a1f..608f2de91662d 100644
--- a/drivers/gpu/drm/panel/panel-lg-lg4573.c
+++ b/drivers/gpu/drm/panel/panel-lg-lg4573.c
@@ -259,9 +259,7 @@ static int lg4573_probe(struct spi_device *spi)
 		return ret;
 	}
 
-	drm_panel_init(&ctx->panel);
-	ctx->panel.dev = &spi->dev;
-	ctx->panel.funcs = &lg4573_drm_funcs;
+	drm_panel_init(&ctx->panel, &spi->dev, &lg4573_drm_funcs);
 
 	return drm_panel_add(&ctx->panel);
 }
diff --git a/drivers/gpu/drm/panel/panel-lvds.c b/drivers/gpu/drm/panel/panel-lvds.c
index bf5fcc3e53791..ff1e305d56a02 100644
--- a/drivers/gpu/drm/panel/panel-lvds.c
+++ b/drivers/gpu/drm/panel/panel-lvds.c
@@ -254,9 +254,7 @@ static int panel_lvds_probe(struct platform_device *pdev)
 	 */
 
 	/* Register the panel. */
-	drm_panel_init(&lvds->panel);
-	lvds->panel.dev = lvds->dev;
-	lvds->panel.funcs = &panel_lvds_funcs;
+	drm_panel_init(&lvds->panel, lvds->dev, &panel_lvds_funcs);
 
 	ret = drm_panel_add(&lvds->panel);
 	if (ret < 0)
diff --git a/drivers/gpu/drm/panel/panel-nec-nl8048hl11.c b/drivers/gpu/drm/panel/panel-nec-nl8048hl11.c
index 20f17e46e65da..272a1434e1558 100644
--- a/drivers/gpu/drm/panel/panel-nec-nl8048hl11.c
+++ b/drivers/gpu/drm/panel/panel-nec-nl8048hl11.c
@@ -205,9 +205,7 @@ static int nl8048_probe(struct spi_device *spi)
 	if (ret < 0)
 		return ret;
 
-	drm_panel_init(&lcd->panel);
-	lcd->panel.dev = &lcd->spi->dev;
-	lcd->panel.funcs = &nl8048_funcs;
+	drm_panel_init(&lcd->panel, &lcd->spi->dev, &nl8048_funcs);
 
 	return drm_panel_add(&lcd->panel);
 }
diff --git a/drivers/gpu/drm/panel/panel-novatek-nt39016.c b/drivers/gpu/drm/panel/panel-novatek-nt39016.c
index 2ad1063b068d5..64cfe111aaadb 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt39016.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt39016.c
@@ -292,9 +292,7 @@ static int nt39016_probe(struct spi_device *spi)
 		return err;
 	}
 
-	drm_panel_init(&panel->drm_panel);
-	panel->drm_panel.dev = dev;
-	panel->drm_panel.funcs = &nt39016_funcs;
+	drm_panel_init(&panel->drm_panel, dev, &nt39016_funcs);
 
 	err = drm_panel_add(&panel->drm_panel);
 	if (err < 0) {
diff --git a/drivers/gpu/drm/panel/panel-olimex-lcd-olinuxino.c b/drivers/gpu/drm/panel/panel-olimex-lcd-olinuxino.c
index 2bae1db3ff344..f2d6a4ec00467 100644
--- a/drivers/gpu/drm/panel/panel-olimex-lcd-olinuxino.c
+++ b/drivers/gpu/drm/panel/panel-olimex-lcd-olinuxino.c
@@ -288,9 +288,7 @@ static int lcd_olinuxino_probe(struct i2c_client *client,
 	if (IS_ERR(lcd->backlight))
 		return PTR_ERR(lcd->backlight);
 
-	drm_panel_init(&lcd->panel);
-	lcd->panel.dev = dev;
-	lcd->panel.funcs = &lcd_olinuxino_funcs;
+	drm_panel_init(&lcd->panel, dev, &lcd_olinuxino_funcs);
 
 	return drm_panel_add(&lcd->panel);
 }
diff --git a/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c b/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c
index 3ee265f1755f4..5aacd632c6f69 100644
--- a/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c
+++ b/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c
@@ -455,9 +455,7 @@ static int otm8009a_probe(struct mipi_dsi_device *dsi)
 	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
 			  MIPI_DSI_MODE_LPM;
 
-	drm_panel_init(&ctx->panel);
-	ctx->panel.dev = dev;
-	ctx->panel.funcs = &otm8009a_drm_funcs;
+	drm_panel_init(&ctx->panel, dev, &otm8009a_drm_funcs);
 
 	ctx->bl_dev = devm_backlight_device_register(dev, dev_name(dev),
 						     dev, ctx,
diff --git a/drivers/gpu/drm/panel/panel-osd-osd101t2587-53ts.c b/drivers/gpu/drm/panel/panel-osd-osd101t2587-53ts.c
index e0e20ecff916d..38f114b03b897 100644
--- a/drivers/gpu/drm/panel/panel-osd-osd101t2587-53ts.c
+++ b/drivers/gpu/drm/panel/panel-osd-osd101t2587-53ts.c
@@ -166,9 +166,8 @@ static int osd101t2587_panel_add(struct osd101t2587_panel *osd101t2587)
 	if (IS_ERR(osd101t2587->backlight))
 		return PTR_ERR(osd101t2587->backlight);
 
-	drm_panel_init(&osd101t2587->base);
-	osd101t2587->base.funcs = &osd101t2587_panel_funcs;
-	osd101t2587->base.dev = &osd101t2587->dsi->dev;
+	drm_panel_init(&osd101t2587->base, &osd101t2587->dsi->dev,
+		       &osd101t2587_panel_funcs);
 
 	return drm_panel_add(&osd101t2587->base);
 }
diff --git a/drivers/gpu/drm/panel/panel-panasonic-vvx10f034n00.c b/drivers/gpu/drm/panel/panel-panasonic-vvx10f034n00.c
index 3dff0b3f73c23..6035bf4580744 100644
--- a/drivers/gpu/drm/panel/panel-panasonic-vvx10f034n00.c
+++ b/drivers/gpu/drm/panel/panel-panasonic-vvx10f034n00.c
@@ -223,9 +223,8 @@ static int wuxga_nt_panel_add(struct wuxga_nt_panel *wuxga_nt)
 			return -EPROBE_DEFER;
 	}
 
-	drm_panel_init(&wuxga_nt->base);
-	wuxga_nt->base.funcs = &wuxga_nt_panel_funcs;
-	wuxga_nt->base.dev = &wuxga_nt->dsi->dev;
+	drm_panel_init(&wuxga_nt->base, &wuxga_nt->dsi->dev,
+		       &wuxga_nt_panel_funcs);
 
 	ret = drm_panel_add(&wuxga_nt->base);
 	if (ret < 0)
diff --git a/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c b/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c
index a621dd28ff70d..cded730f29ad2 100644
--- a/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c
+++ b/drivers/gpu/drm/panel/panel-raspberrypi-touchscreen.c
@@ -433,9 +433,7 @@ static int rpi_touchscreen_probe(struct i2c_client *i2c,
 		return PTR_ERR(ts->dsi);
 	}
 
-	drm_panel_init(&ts->base);
-	ts->base.dev = dev;
-	ts->base.funcs = &rpi_touchscreen_funcs;
+	drm_panel_init(&ts->base, dev, &rpi_touchscreen_funcs);
 
 	/* This appears last, as it's what will unblock the DSI host
 	 * driver's component bind function.
diff --git a/drivers/gpu/drm/panel/panel-raydium-rm67191.c b/drivers/gpu/drm/panel/panel-raydium-rm67191.c
index 6a5d37006103e..f82a1f69f13ba 100644
--- a/drivers/gpu/drm/panel/panel-raydium-rm67191.c
+++ b/drivers/gpu/drm/panel/panel-raydium-rm67191.c
@@ -606,9 +606,7 @@ static int rad_panel_probe(struct mipi_dsi_device *dsi)
 	if (ret)
 		return ret;
 
-	drm_panel_init(&panel->panel);
-	panel->panel.funcs = &rad_panel_funcs;
-	panel->panel.dev = dev;
+	drm_panel_init(&panel->panel, dev, &rad_panel_funcs);
 	dev_set_drvdata(dev, panel);
 
 	ret = drm_panel_add(&panel->panel);
diff --git a/drivers/gpu/drm/panel/panel-raydium-rm68200.c b/drivers/gpu/drm/panel/panel-raydium-rm68200.c
index ba889625ad435..f004b78fb8bc9 100644
--- a/drivers/gpu/drm/panel/panel-raydium-rm68200.c
+++ b/drivers/gpu/drm/panel/panel-raydium-rm68200.c
@@ -404,9 +404,7 @@ static int rm68200_probe(struct mipi_dsi_device *dsi)
 	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
 			  MIPI_DSI_MODE_LPM;
 
-	drm_panel_init(&ctx->panel);
-	ctx->panel.dev = dev;
-	ctx->panel.funcs = &rm68200_drm_funcs;
+	drm_panel_init(&ctx->panel, dev, &rm68200_drm_funcs);
 
 	drm_panel_add(&ctx->panel);
 
diff --git a/drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c b/drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c
index b9109922397ff..d7f56374f2f17 100644
--- a/drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c
+++ b/drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c
@@ -343,9 +343,7 @@ static int jh057n_probe(struct mipi_dsi_device *dsi)
 		return ret;
 	}
 
-	drm_panel_init(&ctx->panel);
-	ctx->panel.dev = dev;
-	ctx->panel.funcs = &jh057n_drm_funcs;
+	drm_panel_init(&ctx->panel, dev, &jh057n_drm_funcs);
 
 	drm_panel_add(&ctx->panel);
 
diff --git a/drivers/gpu/drm/panel/panel-ronbo-rb070d30.c b/drivers/gpu/drm/panel/panel-ronbo-rb070d30.c
index 3c15764f0c039..8708fbbe76376 100644
--- a/drivers/gpu/drm/panel/panel-ronbo-rb070d30.c
+++ b/drivers/gpu/drm/panel/panel-ronbo-rb070d30.c
@@ -173,9 +173,7 @@ static int rb070d30_panel_dsi_probe(struct mipi_dsi_device *dsi)
 	mipi_dsi_set_drvdata(dsi, ctx);
 	ctx->dsi = dsi;
 
-	drm_panel_init(&ctx->panel);
-	ctx->panel.dev = &dsi->dev;
-	ctx->panel.funcs = &rb070d30_panel_funcs;
+	drm_panel_init(&ctx->panel, &dsi->dev, &rb070d30_panel_funcs);
 
 	ctx->gpios.reset = devm_gpiod_get(&dsi->dev, "reset", GPIOD_OUT_LOW);
 	if (IS_ERR(ctx->gpios.reset)) {
diff --git a/drivers/gpu/drm/panel/panel-samsung-ld9040.c b/drivers/gpu/drm/panel/panel-samsung-ld9040.c
index 3be902dcedc02..71a292dbec478 100644
--- a/drivers/gpu/drm/panel/panel-samsung-ld9040.c
+++ b/drivers/gpu/drm/panel/panel-samsung-ld9040.c
@@ -351,9 +351,7 @@ static int ld9040_probe(struct spi_device *spi)
 		return ret;
 	}
 
-	drm_panel_init(&ctx->panel);
-	ctx->panel.dev = dev;
-	ctx->panel.funcs = &ld9040_drm_funcs;
+	drm_panel_init(&ctx->panel, dev, &ld9040_drm_funcs);
 
 	return drm_panel_add(&ctx->panel);
 }
diff --git a/drivers/gpu/drm/panel/panel-samsung-s6d16d0.c b/drivers/gpu/drm/panel/panel-samsung-s6d16d0.c
index f75bef24e0504..4d25c96e842cf 100644
--- a/drivers/gpu/drm/panel/panel-samsung-s6d16d0.c
+++ b/drivers/gpu/drm/panel/panel-samsung-s6d16d0.c
@@ -215,9 +215,7 @@ static int s6d16d0_probe(struct mipi_dsi_device *dsi)
 		return ret;
 	}
 
-	drm_panel_init(&s6->panel);
-	s6->panel.dev = dev;
-	s6->panel.funcs = &s6d16d0_drm_funcs;
+	drm_panel_init(&s6->panel, dev, &s6d16d0_drm_funcs);
 
 	ret = drm_panel_add(&s6->panel);
 	if (ret < 0)
diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e3ha2.c b/drivers/gpu/drm/panel/panel-samsung-s6e3ha2.c
index b923de23ed654..42a3aaab49eb4 100644
--- a/drivers/gpu/drm/panel/panel-samsung-s6e3ha2.c
+++ b/drivers/gpu/drm/panel/panel-samsung-s6e3ha2.c
@@ -732,9 +732,7 @@ static int s6e3ha2_probe(struct mipi_dsi_device *dsi)
 	ctx->bl_dev->props.brightness = S6E3HA2_DEFAULT_BRIGHTNESS;
 	ctx->bl_dev->props.power = FB_BLANK_POWERDOWN;
 
-	drm_panel_init(&ctx->panel);
-	ctx->panel.dev = dev;
-	ctx->panel.funcs = &s6e3ha2_drm_funcs;
+	drm_panel_init(&ctx->panel, dev, &s6e3ha2_drm_funcs);
 
 	ret = drm_panel_add(&ctx->panel);
 	if (ret < 0)
diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e63j0x03.c b/drivers/gpu/drm/panel/panel-samsung-s6e63j0x03.c
index cd90fa700c493..b4d879bf4d03d 100644
--- a/drivers/gpu/drm/panel/panel-samsung-s6e63j0x03.c
+++ b/drivers/gpu/drm/panel/panel-samsung-s6e63j0x03.c
@@ -466,9 +466,7 @@ static int s6e63j0x03_probe(struct mipi_dsi_device *dsi)
 		return PTR_ERR(ctx->reset_gpio);
 	}
 
-	drm_panel_init(&ctx->panel);
-	ctx->panel.dev = dev;
-	ctx->panel.funcs = &s6e63j0x03_funcs;
+	drm_panel_init(&ctx->panel, dev, &s6e63j0x03_funcs);
 
 	ctx->bl_dev = backlight_device_register("s6e63j0x03", dev, ctx,
 						&s6e63j0x03_bl_ops, NULL);
diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e63m0.c b/drivers/gpu/drm/panel/panel-samsung-s6e63m0.c
index 142d395ea5129..61259c2833ab8 100644
--- a/drivers/gpu/drm/panel/panel-samsung-s6e63m0.c
+++ b/drivers/gpu/drm/panel/panel-samsung-s6e63m0.c
@@ -473,9 +473,7 @@ static int s6e63m0_probe(struct spi_device *spi)
 		return ret;
 	}
 
-	drm_panel_init(&ctx->panel);
-	ctx->panel.dev = dev;
-	ctx->panel.funcs = &s6e63m0_drm_funcs;
+	drm_panel_init(&ctx->panel, dev, &s6e63m0_drm_funcs);
 
 	ret = s6e63m0_backlight_register(ctx);
 	if (ret < 0)
diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e8aa0.c b/drivers/gpu/drm/panel/panel-samsung-s6e8aa0.c
index 81858267723ad..35dbffabd5267 100644
--- a/drivers/gpu/drm/panel/panel-samsung-s6e8aa0.c
+++ b/drivers/gpu/drm/panel/panel-samsung-s6e8aa0.c
@@ -1017,9 +1017,7 @@ static int s6e8aa0_probe(struct mipi_dsi_device *dsi)
 
 	ctx->brightness = GAMMA_LEVEL_NUM - 1;
 
-	drm_panel_init(&ctx->panel);
-	ctx->panel.dev = dev;
-	ctx->panel.funcs = &s6e8aa0_drm_funcs;
+	drm_panel_init(&ctx->panel, dev, &s6e8aa0_drm_funcs);
 
 	ret = drm_panel_add(&ctx->panel);
 	if (ret < 0)
diff --git a/drivers/gpu/drm/panel/panel-seiko-43wvf1g.c b/drivers/gpu/drm/panel/panel-seiko-43wvf1g.c
index 18b22b1294fbc..0833d0c03adc9 100644
--- a/drivers/gpu/drm/panel/panel-seiko-43wvf1g.c
+++ b/drivers/gpu/drm/panel/panel-seiko-43wvf1g.c
@@ -274,9 +274,7 @@ static int seiko_panel_probe(struct device *dev,
 			return -EPROBE_DEFER;
 	}
 
-	drm_panel_init(&panel->base);
-	panel->base.dev = dev;
-	panel->base.funcs = &seiko_panel_funcs;
+	drm_panel_init(&panel->base, dev, &seiko_panel_funcs);
 
 	err = drm_panel_add(&panel->base);
 	if (err < 0)
diff --git a/drivers/gpu/drm/panel/panel-sharp-lq101r1sx01.c b/drivers/gpu/drm/panel/panel-sharp-lq101r1sx01.c
index e910b4ad13104..87a58cb4d9455 100644
--- a/drivers/gpu/drm/panel/panel-sharp-lq101r1sx01.c
+++ b/drivers/gpu/drm/panel/panel-sharp-lq101r1sx01.c
@@ -329,9 +329,7 @@ static int sharp_panel_add(struct sharp_panel *sharp)
 	if (IS_ERR(sharp->backlight))
 		return PTR_ERR(sharp->backlight);
 
-	drm_panel_init(&sharp->base);
-	sharp->base.funcs = &sharp_panel_funcs;
-	sharp->base.dev = &sharp->link1->dev;
+	drm_panel_init(&sharp->base, &sharp->link1->dev, &sharp_panel_funcs);
 
 	return drm_panel_add(&sharp->base);
 }
diff --git a/drivers/gpu/drm/panel/panel-sharp-ls037v7dw01.c b/drivers/gpu/drm/panel/panel-sharp-ls037v7dw01.c
index 46cd9a2501298..96e3deb0e305c 100644
--- a/drivers/gpu/drm/panel/panel-sharp-ls037v7dw01.c
+++ b/drivers/gpu/drm/panel/panel-sharp-ls037v7dw01.c
@@ -185,9 +185,7 @@ static int ls037v7dw01_probe(struct platform_device *pdev)
 		return PTR_ERR(lcd->ud_gpio);
 	}
 
-	drm_panel_init(&lcd->panel);
-	lcd->panel.dev = &pdev->dev;
-	lcd->panel.funcs = &ls037v7dw01_funcs;
+	drm_panel_init(&lcd->panel, &pdev->dev, &ls037v7dw01_funcs);
 
 	return drm_panel_add(&lcd->panel);
 }
diff --git a/drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c b/drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c
index c39abde9f9f10..ffa844ee82ad4 100644
--- a/drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c
+++ b/drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c
@@ -264,9 +264,8 @@ static int sharp_nt_panel_add(struct sharp_nt_panel *sharp_nt)
 	if (IS_ERR(sharp_nt->backlight))
 		return PTR_ERR(sharp_nt->backlight);
 
-	drm_panel_init(&sharp_nt->base);
-	sharp_nt->base.funcs = &sharp_nt_panel_funcs;
-	sharp_nt->base.dev = &sharp_nt->dsi->dev;
+	drm_panel_init(&sharp_nt->base, &sharp_nt->dsi->dev,
+		       &sharp_nt_panel_funcs);
 
 	return drm_panel_add(&sharp_nt->base);
 }
diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index ec0085e664365..156bd4d551dc3 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -464,9 +464,7 @@ static int panel_simple_probe(struct device *dev, const struct panel_desc *desc)
 	if (!of_get_display_timing(dev->of_node, "panel-timing", &dt))
 		panel_simple_parse_panel_timing_node(dev, panel, &dt);
 
-	drm_panel_init(&panel->base);
-	panel->base.dev = dev;
-	panel->base.funcs = &panel_simple_funcs;
+	drm_panel_init(&panel->base, dev, &panel_simple_funcs);
 
 	err = drm_panel_add(&panel->base);
 	if (err < 0)
diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7701.c b/drivers/gpu/drm/panel/panel-sitronix-st7701.c
index 638f605acb2db..77a3f6b9aec1d 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7701.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7701.c
@@ -369,7 +369,7 @@ static int st7701_dsi_probe(struct mipi_dsi_device *dsi)
 	if (IS_ERR(st7701->backlight))
 		return PTR_ERR(st7701->backlight);
 
-	drm_panel_init(&st7701->panel);
+	drm_panel_init(&st7701->panel, &dsi->dev, &st7701_funcs);
 
 	/**
 	 * Once sleep out has been issued, ST7701 IC required to wait 120ms
@@ -381,8 +381,6 @@ static int st7701_dsi_probe(struct mipi_dsi_device *dsi)
 	 * ts8550b and there is no valid documentation for that.
 	 */
 	st7701->sleep_delay = 120 + desc->panel_sleep_delay;
-	st7701->panel.funcs = &st7701_funcs;
-	st7701->panel.dev = &dsi->dev;
 
 	ret = drm_panel_add(&st7701->panel);
 	if (ret < 0)
diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
index 3b2612ae931e8..2eeaeee0dd7f3 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
@@ -381,9 +381,7 @@ static int st7789v_probe(struct spi_device *spi)
 	spi_set_drvdata(spi, ctx);
 	ctx->spi = spi;
 
-	drm_panel_init(&ctx->panel);
-	ctx->panel.dev = &spi->dev;
-	ctx->panel.funcs = &st7789v_drm_funcs;
+	drm_panel_init(&ctx->panel, &spi->dev, &st7789v_drm_funcs);
 
 	ctx->power = devm_regulator_get(&spi->dev, "power");
 	if (IS_ERR(ctx->power))
diff --git a/drivers/gpu/drm/panel/panel-sony-acx565akm.c b/drivers/gpu/drm/panel/panel-sony-acx565akm.c
index 3d5b9c4f68d98..1e39067387a61 100644
--- a/drivers/gpu/drm/panel/panel-sony-acx565akm.c
+++ b/drivers/gpu/drm/panel/panel-sony-acx565akm.c
@@ -648,9 +648,7 @@ static int acx565akm_probe(struct spi_device *spi)
 			return ret;
 	}
 
-	drm_panel_init(&lcd->panel);
-	lcd->panel.dev = &lcd->spi->dev;
-	lcd->panel.funcs = &acx565akm_funcs;
+	drm_panel_init(&lcd->panel, &lcd->spi->dev, &acx565akm_funcs);
 
 	ret = drm_panel_add(&lcd->panel);
 	if (ret < 0) {
diff --git a/drivers/gpu/drm/panel/panel-tpo-td028ttec1.c b/drivers/gpu/drm/panel/panel-tpo-td028ttec1.c
index f2baff827f507..76cfca89c3c78 100644
--- a/drivers/gpu/drm/panel/panel-tpo-td028ttec1.c
+++ b/drivers/gpu/drm/panel/panel-tpo-td028ttec1.c
@@ -347,9 +347,7 @@ static int td028ttec1_probe(struct spi_device *spi)
 		return ret;
 	}
 
-	drm_panel_init(&lcd->panel);
-	lcd->panel.dev = &lcd->spi->dev;
-	lcd->panel.funcs = &td028ttec1_funcs;
+	drm_panel_init(&lcd->panel, &lcd->spi->dev, &td028ttec1_funcs);
 
 	return drm_panel_add(&lcd->panel);
 }
diff --git a/drivers/gpu/drm/panel/panel-tpo-td043mtea1.c b/drivers/gpu/drm/panel/panel-tpo-td043mtea1.c
index ba163c779084c..afd7c5ed53c45 100644
--- a/drivers/gpu/drm/panel/panel-tpo-td043mtea1.c
+++ b/drivers/gpu/drm/panel/panel-tpo-td043mtea1.c
@@ -458,9 +458,7 @@ static int td043mtea1_probe(struct spi_device *spi)
 		return ret;
 	}
 
-	drm_panel_init(&lcd->panel);
-	lcd->panel.dev = &lcd->spi->dev;
-	lcd->panel.funcs = &td043mtea1_funcs;
+	drm_panel_init(&lcd->panel, &lcd->spi->dev, &td043mtea1_funcs);
 
 	ret = drm_panel_add(&lcd->panel);
 	if (ret < 0) {
diff --git a/drivers/gpu/drm/panel/panel-tpo-tpg110.c b/drivers/gpu/drm/panel/panel-tpo-tpg110.c
index 71591e5f59383..25524c26b241b 100644
--- a/drivers/gpu/drm/panel/panel-tpo-tpg110.c
+++ b/drivers/gpu/drm/panel/panel-tpo-tpg110.c
@@ -457,9 +457,7 @@ static int tpg110_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	drm_panel_init(&tpg->panel);
-	tpg->panel.dev = dev;
-	tpg->panel.funcs = &tpg110_drm_funcs;
+	drm_panel_init(&tpg->panel, dev, &tpg110_drm_funcs);
 	spi_set_drvdata(spi, tpg);
 
 	return drm_panel_add(&tpg->panel);
diff --git a/drivers/gpu/drm/panel/panel-truly-nt35597.c b/drivers/gpu/drm/panel/panel-truly-nt35597.c
index 77e1311b7c692..c3714be788375 100644
--- a/drivers/gpu/drm/panel/panel-truly-nt35597.c
+++ b/drivers/gpu/drm/panel/panel-truly-nt35597.c
@@ -518,9 +518,7 @@ static int truly_nt35597_panel_add(struct truly_nt35597 *ctx)
 	/* dual port */
 	gpiod_set_value(ctx->mode_gpio, 0);
 
-	drm_panel_init(&ctx->panel);
-	ctx->panel.dev = dev;
-	ctx->panel.funcs = &truly_nt35597_drm_funcs;
+	drm_panel_init(&ctx->panel, dev, &truly_nt35597_drm_funcs);
 	drm_panel_add(&ctx->panel);
 
 	return 0;
diff --git a/include/drm/drm_panel.h b/include/drm/drm_panel.h
index 624bd15ecfab6..4b9c656dc15e3 100644
--- a/include/drm/drm_panel.h
+++ b/include/drm/drm_panel.h
@@ -147,7 +147,8 @@ struct drm_panel {
 	struct list_head list;
 };
 
-void drm_panel_init(struct drm_panel *panel);
+void drm_panel_init(struct drm_panel *panel, struct device *dev,
+		    const struct drm_panel_funcs *funcs);
 
 int drm_panel_add(struct drm_panel *panel);
 void drm_panel_remove(struct drm_panel *panel);
-- 
2.39.2



