Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5627832FF
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjHUTzj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 15:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjHUTzi (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 15:55:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076E6D3
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 12:55:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55F5564230
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 19:55:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 645A6C433C9;
        Mon, 21 Aug 2023 19:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692647728;
        bh=I0H5T/uzRtpGVd6pfft/OCqyjXzU7rIyj5KdwwbLv7A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Om/NwOXRau0VTGoQvtnrj2ZwWjM0oJ5qeylMelqWPefBZDzyvWfFhxHRP+1tD7pdy
         DEYP19qP9XboXeTTOIJYy4LFOLYdUDIZhD/MzIIS8pm1YyILecfITfkkfXGkNGujw5
         OQg2kzml5/DdM5Nqgfz9q5pOTrvuESs+Cp5bp6f4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 117/194] drm/panel: simple: Fix AUO G121EAN01 panel timings according to the docs
Date:   Mon, 21 Aug 2023 21:41:36 +0200
Message-ID: <20230821194127.842291565@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194122.695845670@linuxfoundation.org>
References: <20230821194122.695845670@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Luca Ceresoli <luca.ceresoli@bootlin.com>

[ Upstream commit e8470c0a7bcaa82f78ad34282d662dd7bd9630c2 ]

Commit 03e909acd95a ("drm/panel: simple: Add support for AUO G121EAN01.4
panel") added support for this panel model, but the timings it implements
are very different from what the datasheet describes. I checked both the
G121EAN01.0 datasheet from [0] and the G121EAN01.4 one from [1] and they
all have the same timings: for example the LVDS clock typical value is 74.4
MHz, not 66.7 MHz as implemented.

Replace the timings with the ones from the documentation. These timings
have been tested and the clock frequencies verified with an oscilloscope to
ensure they are correct.

Also use struct display_timing instead of struct drm_display_mode in order
to also specify the minimum and maximum values.

[0] https://embedded.avnet.com/product/g121ean01-0/
[1] https://embedded.avnet.com/product/g121ean01-4/

Fixes: 03e909acd95a ("drm/panel: simple: Add support for AUO G121EAN01.4 panel")
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20230804151239.835216-1-luca.ceresoli@bootlin.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/panel/panel-simple.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index f851aaf2c5917..5e067ba7e5fba 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -969,21 +969,21 @@ static const struct panel_desc auo_g104sn02 = {
 	.connector_type = DRM_MODE_CONNECTOR_LVDS,
 };
 
-static const struct drm_display_mode auo_g121ean01_mode = {
-	.clock = 66700,
-	.hdisplay = 1280,
-	.hsync_start = 1280 + 58,
-	.hsync_end = 1280 + 58 + 8,
-	.htotal = 1280 + 58 + 8 + 70,
-	.vdisplay = 800,
-	.vsync_start = 800 + 6,
-	.vsync_end = 800 + 6 + 4,
-	.vtotal = 800 + 6 + 4 + 10,
+static const struct display_timing auo_g121ean01_timing = {
+	.pixelclock = { 60000000, 74400000, 90000000 },
+	.hactive = { 1280, 1280, 1280 },
+	.hfront_porch = { 20, 50, 100 },
+	.hback_porch = { 20, 50, 100 },
+	.hsync_len = { 30, 100, 200 },
+	.vactive = { 800, 800, 800 },
+	.vfront_porch = { 2, 10, 25 },
+	.vback_porch = { 2, 10, 25 },
+	.vsync_len = { 4, 18, 50 },
 };
 
 static const struct panel_desc auo_g121ean01 = {
-	.modes = &auo_g121ean01_mode,
-	.num_modes = 1,
+	.timings = &auo_g121ean01_timing,
+	.num_timings = 1,
 	.bpc = 8,
 	.size = {
 		.width = 261,
-- 
2.40.1



