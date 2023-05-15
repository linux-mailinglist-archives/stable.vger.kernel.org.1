Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05B5570289A
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 11:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240203AbjEOJai (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 05:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240887AbjEOJaT (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 05:30:19 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56DF71996
        for <stable@vger.kernel.org>; Mon, 15 May 2023 02:29:55 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f380cd1019so1563475e87.1
        for <stable@vger.kernel.org>; Mon, 15 May 2023 02:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684142993; x=1686734993;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9cHgRTt5ciQcLth2917TOaI71QUNMjPwJlxqviRQlkI=;
        b=cSqShpTOI8Qp1A4BovqjgmYBLEVspYUBWl8ze433vBCnCcZmetofZfwPc8xTP1U+WI
         hdUwuRw5Lo/kwnwaZoZy7LAIx5r4u9AalZ/cuhUqa0wmywYXt2DnfB7QQh5whmjqQE3X
         +tpokuNbiehrP1gN3igiNQNIRRRJekYbuQmHAPbniecT4qyQM5xtLoLhSBSQvt6zh7Va
         aRBJkMX3/Rt8y6mZZZDdM6p2vs5uRek5ZuCnEDu0krwylfqKuDcWziB/VctZT1BmlwCc
         itdd9AJfdWVkCTAkJuVZLfZOjFw9i7uVu0cAbVLeiJ1pRPM5WMYASk5lidOw+JstPCZB
         NhHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684142993; x=1686734993;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9cHgRTt5ciQcLth2917TOaI71QUNMjPwJlxqviRQlkI=;
        b=bqi4isjQTuQ24oTJ8QtdMJfnQlbbb2KOlTO1UqKJ7LkWLr/ndHtjMwQZB6U+9NKt0J
         fIi1lUb5TR3RtPxzQEa2M4w7MaB2fyml119Axrolr6X/z3oi40/0K4/rfLnhTJnwcI9W
         6uKH2itM1OUgOcVtdwBXmMIUhKa9UQbUKwcnIOk1hBv1okFkh3J+NKctCCZTXK91zR8h
         xBQHQ482H10lR/QtKBunr82S+LxSCcbi9VW5LcNnoQkwKDlDJ/GM4haASp66nVCwcwTL
         9eXJ/GLlv15gCUBfHY0uV6QSFgIBqHu35rGRrXTF0aDvHPyrIgI0/mXzlKwxNBaTdsHS
         ZI9g==
X-Gm-Message-State: AC+VfDyF2JKbzUUmvbMMGyQGa4UjzLOnRLoE7X0zy1s1GNQ7q0wxH37/
        7LfhM5CiQqSgK7eFOt+nJs5A+w==
X-Google-Smtp-Source: ACHHUZ7HbfNI2S8ZI6vYnnU5B4f0S/n0M0PYa+0OWdGAyOatpYbQDDz4ChTPE7d35/eCOiyR8D6dMw==
X-Received: by 2002:ac2:4ac7:0:b0:4f2:5442:511d with SMTP id m7-20020ac24ac7000000b004f25442511dmr168349lfp.29.1684142993381;
        Mon, 15 May 2023 02:29:53 -0700 (PDT)
Received: from Linus-Dell.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2-20020ac24842000000b004f134f7cff3sm2508926lfy.167.2023.05.15.02.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 02:29:53 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Emma Anholt <emma@anholt.net>, stable@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH] drm/pl111: Fix FB depth on IMPD-1 framebuffer
Date:   Mon, 15 May 2023 11:29:43 +0200
Message-Id: <20230515092943.1401558-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

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
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpu/drm/pl111/pl111_display.c   |  2 +-
 drivers/gpu/drm/pl111/pl111_drm.h       |  4 ++--
 drivers/gpu/drm/pl111/pl111_drv.c       |  8 ++++----
 drivers/gpu/drm/pl111/pl111_versatile.c | 10 +++++-----
 4 files changed, 12 insertions(+), 12 deletions(-)

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
 
-- 
2.34.1

