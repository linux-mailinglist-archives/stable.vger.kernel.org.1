Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB848713856
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 09:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbjE1H3Z (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 03:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjE1H3Z (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 03:29:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 823CED9
        for <stable@vger.kernel.org>; Sun, 28 May 2023 00:29:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CFCD60E9E
        for <stable@vger.kernel.org>; Sun, 28 May 2023 07:29:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CDD8C433D2;
        Sun, 28 May 2023 07:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685258962;
        bh=M4CMb6QTmV+sAlTDvSnjXA0yCfWesl08WdZPDn3Po08=;
        h=Subject:To:Cc:From:Date:From;
        b=kKOgIDrYUfWpxP6LWnkQqzyHn30iG/9ZIb1PR0BvcGMhAMtCldMBJ88LLxYg0eYC5
         ZSBxXW8VDWiWq3RoTtIxGsoA0smkJr/Z9ZWCnhLP79RKmimcvToeYh3CJtvGXOdqvL
         7gpEU6vCO+5b7xAHQ1vGsGlY+TEJ5f5C+kPc+ot0=
Subject: FAILED: patch "[PATCH] drm/pl111: Fix FB depth on IMPD-1 framebuffer" failed to apply to 6.3-stable tree
To:     linus.walleij@linaro.org, emma@anholt.net, tzimmermann@suse.de
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 28 May 2023 08:29:20 +0100
Message-ID: <2023052820-survive-contented-549b@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.3.y
git checkout FETCH_HEAD
git cherry-pick -x 140809738d969376f26f13264b16669703956f6c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023052820-survive-contented-549b@gregkh' --subject-prefix 'PATCH 6.3.y' HEAD^..

Possible dependencies:

140809738d96 ("drm/pl111: Fix FB depth on IMPD-1 framebuffer")
a66172fa7859 ("drm/pl111: Use GEM DMA fbdev emulation")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 140809738d969376f26f13264b16669703956f6c Mon Sep 17 00:00:00 2001
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 15 May 2023 11:29:43 +0200
Subject: [PATCH] drm/pl111: Fix FB depth on IMPD-1 framebuffer

The last argument to the function drm_fbdev_dma_setup() was
changed from desired BPP to desired depth.

In our case the desired depth was 15 but BPP was 16, so we
specified 16 as BPP and we relied on the FB emulation core to
select a format with a suitable depth for the limited bandwidth
and end up with e.g. XRGB1555 like in the past:

[drm] Initialized pl111 1.0.0 20170317 for c1000000.display on minor 0
drm-clcd-pl111 c1000000.display: [drm] requested bpp 16, scaled depth down to 15
drm-clcd-pl111 c1000000.display: enable IM-PD1 CLCD connectors
Console: switching to colour frame buffer device 80x30
drm-clcd-pl111 c1000000.display: [drm] fb0: pl111drmfb frame buffer device

However the current code will fail at that:

[drm] Initialized pl111 1.0.0 20170317 for c1000000.display on minor 0
drm-clcd-pl111 c1000000.display: [drm] bpp/depth value of 16/16 not supported
drm-clcd-pl111 c1000000.display: [drm] No compatible format found
drm-clcd-pl111 c1000000.display: [drm] *ERROR* fbdev: Failed to setup generic emulation (ret=-12)

Fix this by passing the desired depth of 15 for the IM/PD-1 display
instead of 16 to drm_fbdev_dma_setup().

The desired depth is however in turn used for bandwidth limiting
calculations and that was done with a simple / integer division,
whereas we now have to modify that to use DIV_ROUND_UP() so that
we get DIV_ROUND_UP(15, 2) = 2 not 15/2 = 1.

After this the display works again on the Integrator/AP IM/PD-1.

Cc: Emma Anholt <emma@anholt.net>
Cc: stable@vger.kernel.org
Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: 37c90d589dc0 ("drm/fb-helper: Fix single-probe color-format selection")
Link: https://lore.kernel.org/dri-devel/20230102112927.26565-1-tzimmermann@suse.de/
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20230515092943.1401558-1-linus.walleij@linaro.org

diff --git a/drivers/gpu/drm/pl111/pl111_display.c b/drivers/gpu/drm/pl111/pl111_display.c
index 6afdf260a4e2..b9fe926a49e8 100644
--- a/drivers/gpu/drm/pl111/pl111_display.c
+++ b/drivers/gpu/drm/pl111/pl111_display.c
@@ -53,7 +53,7 @@ pl111_mode_valid(struct drm_simple_display_pipe *pipe,
 {
 	struct drm_device *drm = pipe->crtc.dev;
 	struct pl111_drm_dev_private *priv = drm->dev_private;
-	u32 cpp = priv->variant->fb_bpp / 8;
+	u32 cpp = DIV_ROUND_UP(priv->variant->fb_depth, 8);
 	u64 bw;
 
 	/*
diff --git a/drivers/gpu/drm/pl111/pl111_drm.h b/drivers/gpu/drm/pl111/pl111_drm.h
index 2a46b5bd8576..d1fe756444ee 100644
--- a/drivers/gpu/drm/pl111/pl111_drm.h
+++ b/drivers/gpu/drm/pl111/pl111_drm.h
@@ -114,7 +114,7 @@ struct drm_minor;
  *	extensions to the control register
  * @formats: array of supported pixel formats on this variant
  * @nformats: the length of the array of supported pixel formats
- * @fb_bpp: desired bits per pixel on the default framebuffer
+ * @fb_depth: desired depth per pixel on the default framebuffer
  */
 struct pl111_variant_data {
 	const char *name;
@@ -126,7 +126,7 @@ struct pl111_variant_data {
 	bool st_bitmux_control;
 	const u32 *formats;
 	unsigned int nformats;
-	unsigned int fb_bpp;
+	unsigned int fb_depth;
 };
 
 struct pl111_drm_dev_private {
diff --git a/drivers/gpu/drm/pl111/pl111_drv.c b/drivers/gpu/drm/pl111/pl111_drv.c
index 4b2a9e9753f6..43049c8028b2 100644
--- a/drivers/gpu/drm/pl111/pl111_drv.c
+++ b/drivers/gpu/drm/pl111/pl111_drv.c
@@ -308,7 +308,7 @@ static int pl111_amba_probe(struct amba_device *amba_dev,
 	if (ret < 0)
 		goto dev_put;
 
-	drm_fbdev_dma_setup(drm, priv->variant->fb_bpp);
+	drm_fbdev_dma_setup(drm, priv->variant->fb_depth);
 
 	return 0;
 
@@ -351,7 +351,7 @@ static const struct pl111_variant_data pl110_variant = {
 	.is_pl110 = true,
 	.formats = pl110_pixel_formats,
 	.nformats = ARRAY_SIZE(pl110_pixel_formats),
-	.fb_bpp = 16,
+	.fb_depth = 16,
 };
 
 /* RealView, Versatile Express etc use this modern variant */
@@ -376,7 +376,7 @@ static const struct pl111_variant_data pl111_variant = {
 	.name = "PL111",
 	.formats = pl111_pixel_formats,
 	.nformats = ARRAY_SIZE(pl111_pixel_formats),
-	.fb_bpp = 32,
+	.fb_depth = 32,
 };
 
 static const u32 pl110_nomadik_pixel_formats[] = {
@@ -405,7 +405,7 @@ static const struct pl111_variant_data pl110_nomadik_variant = {
 	.is_lcdc = true,
 	.st_bitmux_control = true,
 	.broken_vblank = true,
-	.fb_bpp = 16,
+	.fb_depth = 16,
 };
 
 static const struct amba_id pl111_id_table[] = {
diff --git a/drivers/gpu/drm/pl111/pl111_versatile.c b/drivers/gpu/drm/pl111/pl111_versatile.c
index 1b436b75fd39..00c3ebd32359 100644
--- a/drivers/gpu/drm/pl111/pl111_versatile.c
+++ b/drivers/gpu/drm/pl111/pl111_versatile.c
@@ -316,7 +316,7 @@ static const struct pl111_variant_data pl110_integrator = {
 	.broken_vblank = true,
 	.formats = pl110_integrator_pixel_formats,
 	.nformats = ARRAY_SIZE(pl110_integrator_pixel_formats),
-	.fb_bpp = 16,
+	.fb_depth = 16,
 };
 
 /*
@@ -330,7 +330,7 @@ static const struct pl111_variant_data pl110_impd1 = {
 	.broken_vblank = true,
 	.formats = pl110_integrator_pixel_formats,
 	.nformats = ARRAY_SIZE(pl110_integrator_pixel_formats),
-	.fb_bpp = 16,
+	.fb_depth = 15,
 };
 
 /*
@@ -343,7 +343,7 @@ static const struct pl111_variant_data pl110_versatile = {
 	.external_bgr = true,
 	.formats = pl110_versatile_pixel_formats,
 	.nformats = ARRAY_SIZE(pl110_versatile_pixel_formats),
-	.fb_bpp = 16,
+	.fb_depth = 16,
 };
 
 /*
@@ -355,7 +355,7 @@ static const struct pl111_variant_data pl111_realview = {
 	.name = "PL111 RealView",
 	.formats = pl111_realview_pixel_formats,
 	.nformats = ARRAY_SIZE(pl111_realview_pixel_formats),
-	.fb_bpp = 16,
+	.fb_depth = 16,
 };
 
 /*
@@ -367,7 +367,7 @@ static const struct pl111_variant_data pl111_vexpress = {
 	.name = "PL111 Versatile Express",
 	.formats = pl111_realview_pixel_formats,
 	.nformats = ARRAY_SIZE(pl111_realview_pixel_formats),
-	.fb_bpp = 16,
+	.fb_depth = 16,
 	.broken_clockdivider = true,
 };
 

