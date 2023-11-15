Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89A5A7ED2BB
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233551AbjKOUnG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:43:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343670AbjKOTzm (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:55:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E086010D5
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:55:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 508D2C433C8;
        Wed, 15 Nov 2023 19:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700078137;
        bh=36nyno2fMIJ5klbHb+82qjJf69vulXcazr1JXIEUHlY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v3GvxynjAOhwNd6m9W5WsCu0ARllYW2LYgm/mVIH29PKVWtby/qgiF8B7krZ9nOls
         IYk0UxsqSPdOH+arjKkhGN5ZUjAwI9iE2WKKdALMwxEw+g8AWQSBH1GQglXTB1TObB
         /58Vli72fKwJ0dhlg/ZVz67GvHrdt+3RIjpXZWJE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Robert Foss <rfoss@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        Maxim Schwalm <maxim.schwalm@gmail.com>
Subject: [PATCH 6.1 132/379] drm/bridge: tc358768: Rename dsibclk to hsbyteclk
Date:   Wed, 15 Nov 2023 14:23:27 -0500
Message-ID: <20231115192652.934395434@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115192645.143643130@linuxfoundation.org>
References: <20231115192645.143643130@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

[ Upstream commit 699cf62a7d4550759f4a50e614b1952f93de4783 ]

The Toshiba documentation talks about HSByteClk when referring to the
DSI HS byte clock, whereas the driver uses 'dsibclk' name. Also, in a
few places the driver calculates the byte clock from the DSI clock, even
if the byte clock is already available in a variable.

To align the driver with the documentation, change the 'dsibclk'
variable to 'hsbyteclk'. This also make it easier to visually separate
'dsibclk' and 'dsiclk' variables.

Reviewed-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
Tested-by: Maxim Schwalm <maxim.schwalm@gmail.com> # Asus TF700T
Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Signed-off-by: Robert Foss <rfoss@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20230906-tc358768-v4-9-31725f008a50@ideasonboard.com
Stable-dep-of: f1dabbe64506 ("drm/bridge: tc358768: Fix tc358768_ns_to_cnt()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/tc358768.c | 48 +++++++++++++++----------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/tc358768.c
index 130b807926017..27d57c02f3f6a 100644
--- a/drivers/gpu/drm/bridge/tc358768.c
+++ b/drivers/gpu/drm/bridge/tc358768.c
@@ -605,7 +605,7 @@ static int tc358768_setup_pll(struct tc358768_priv *priv,
 
 	dev_dbg(priv->dev, "PLL: refclk %lu, fbd %u, prd %u, frs %u\n",
 		clk_get_rate(priv->refclk), fbd, prd, frs);
-	dev_dbg(priv->dev, "PLL: pll_clk: %u, DSIClk %u, DSIByteClk %u\n",
+	dev_dbg(priv->dev, "PLL: pll_clk: %u, DSIClk %u, HSByteClk %u\n",
 		priv->dsiclk * 2, priv->dsiclk, priv->dsiclk / 4);
 	dev_dbg(priv->dev, "PLL: pclk %u (panel: %u)\n",
 		tc358768_pll_to_pclk(priv, priv->dsiclk * 2),
@@ -647,8 +647,8 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
 	u32 val, val2, lptxcnt, hact, data_type;
 	s32 raw_val;
 	const struct drm_display_mode *mode;
-	u32 dsibclk_nsk, dsiclk_nsk, ui_nsk;
-	u32 dsiclk, dsibclk, video_start;
+	u32 hsbyteclk_nsk, dsiclk_nsk, ui_nsk;
+	u32 dsiclk, hsbyteclk, video_start;
 	const u32 internal_delay = 40;
 	int ret, i;
 	struct videomode vm;
@@ -679,7 +679,7 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
 	drm_display_mode_to_videomode(mode, &vm);
 
 	dsiclk = priv->dsiclk;
-	dsibclk = dsiclk / 4;
+	hsbyteclk = dsiclk / 4;
 
 	/* Data Format Control Register */
 	val = BIT(2) | BIT(1) | BIT(0); /* rdswap_en | dsitx_en | txdt_en */
@@ -731,67 +731,67 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
 		tc358768_write(priv, TC358768_D0W_CNTRL + i * 4, 0x0000);
 
 	/* DSI Timings */
-	dsibclk_nsk = (u32)div_u64((u64)1000000000 * TC358768_PRECISION,
-				  dsibclk);
+	hsbyteclk_nsk = (u32)div_u64((u64)1000000000 * TC358768_PRECISION,
+				  hsbyteclk);
 	dsiclk_nsk = (u32)div_u64((u64)1000000000 * TC358768_PRECISION, dsiclk);
 	ui_nsk = dsiclk_nsk / 2;
 	dev_dbg(dev, "dsiclk_nsk: %u\n", dsiclk_nsk);
 	dev_dbg(dev, "ui_nsk: %u\n", ui_nsk);
-	dev_dbg(dev, "dsibclk_nsk: %u\n", dsibclk_nsk);
+	dev_dbg(dev, "hsbyteclk_nsk: %u\n", hsbyteclk_nsk);
 
 	/* LP11 > 100us for D-PHY Rx Init */
-	val = tc358768_ns_to_cnt(100 * 1000, dsibclk_nsk) - 1;
+	val = tc358768_ns_to_cnt(100 * 1000, hsbyteclk_nsk) - 1;
 	dev_dbg(dev, "LINEINITCNT: %u\n", val);
 	tc358768_write(priv, TC358768_LINEINITCNT, val);
 
 	/* LPTimeCnt > 50ns */
-	val = tc358768_ns_to_cnt(50, dsibclk_nsk) - 1;
+	val = tc358768_ns_to_cnt(50, hsbyteclk_nsk) - 1;
 	lptxcnt = val;
 	dev_dbg(dev, "LPTXTIMECNT: %u\n", val);
 	tc358768_write(priv, TC358768_LPTXTIMECNT, val);
 
 	/* 38ns < TCLK_PREPARE < 95ns */
-	val = tc358768_ns_to_cnt(65, dsibclk_nsk) - 1;
+	val = tc358768_ns_to_cnt(65, hsbyteclk_nsk) - 1;
 	dev_dbg(dev, "TCLK_PREPARECNT %u\n", val);
 	/* TCLK_PREPARE + TCLK_ZERO > 300ns */
 	val2 = tc358768_ns_to_cnt(300 - tc358768_to_ns(2 * ui_nsk),
-				  dsibclk_nsk) - 2;
+				  hsbyteclk_nsk) - 2;
 	dev_dbg(dev, "TCLK_ZEROCNT %u\n", val2);
 	val |= val2 << 8;
 	tc358768_write(priv, TC358768_TCLK_HEADERCNT, val);
 
 	/* TCLK_TRAIL > 60ns AND TEOT <= 105 ns + 12*UI */
-	raw_val = tc358768_ns_to_cnt(60 + tc358768_to_ns(2 * ui_nsk), dsibclk_nsk) - 5;
+	raw_val = tc358768_ns_to_cnt(60 + tc358768_to_ns(2 * ui_nsk), hsbyteclk_nsk) - 5;
 	val = clamp(raw_val, 0, 127);
 	dev_dbg(dev, "TCLK_TRAILCNT: %u\n", val);
 	tc358768_write(priv, TC358768_TCLK_TRAILCNT, val);
 
 	/* 40ns + 4*UI < THS_PREPARE < 85ns + 6*UI */
 	val = 50 + tc358768_to_ns(4 * ui_nsk);
-	val = tc358768_ns_to_cnt(val, dsibclk_nsk) - 1;
+	val = tc358768_ns_to_cnt(val, hsbyteclk_nsk) - 1;
 	dev_dbg(dev, "THS_PREPARECNT %u\n", val);
 	/* THS_PREPARE + THS_ZERO > 145ns + 10*UI */
-	raw_val = tc358768_ns_to_cnt(145 - tc358768_to_ns(3 * ui_nsk), dsibclk_nsk) - 10;
+	raw_val = tc358768_ns_to_cnt(145 - tc358768_to_ns(3 * ui_nsk), hsbyteclk_nsk) - 10;
 	val2 = clamp(raw_val, 0, 127);
 	dev_dbg(dev, "THS_ZEROCNT %u\n", val2);
 	val |= val2 << 8;
 	tc358768_write(priv, TC358768_THS_HEADERCNT, val);
 
 	/* TWAKEUP > 1ms in lptxcnt steps */
-	val = tc358768_ns_to_cnt(1020000, dsibclk_nsk);
+	val = tc358768_ns_to_cnt(1020000, hsbyteclk_nsk);
 	val = val / (lptxcnt + 1) - 1;
 	dev_dbg(dev, "TWAKEUP: %u\n", val);
 	tc358768_write(priv, TC358768_TWAKEUP, val);
 
 	/* TCLK_POSTCNT > 60ns + 52*UI */
 	val = tc358768_ns_to_cnt(60 + tc358768_to_ns(52 * ui_nsk),
-				 dsibclk_nsk) - 3;
+				 hsbyteclk_nsk) - 3;
 	dev_dbg(dev, "TCLK_POSTCNT: %u\n", val);
 	tc358768_write(priv, TC358768_TCLK_POSTCNT, val);
 
 	/* max(60ns + 4*UI, 8*UI) < THS_TRAILCNT < 105ns + 12*UI */
 	raw_val = tc358768_ns_to_cnt(60 + tc358768_to_ns(18 * ui_nsk),
-				     dsibclk_nsk) - 4;
+				     hsbyteclk_nsk) - 4;
 	val = clamp(raw_val, 0, 15);
 	dev_dbg(dev, "THS_TRAILCNT: %u\n", val);
 	tc358768_write(priv, TC358768_THS_TRAILCNT, val);
@@ -805,11 +805,11 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
 		       (mode_flags & MIPI_DSI_CLOCK_NON_CONTINUOUS) ? 0 : BIT(0));
 
 	/* TXTAGOCNT[26:16] RXTASURECNT[10:0] */
-	val = tc358768_to_ns((lptxcnt + 1) * dsibclk_nsk * 4);
-	val = tc358768_ns_to_cnt(val, dsibclk_nsk) / 4 - 1;
+	val = tc358768_to_ns((lptxcnt + 1) * hsbyteclk_nsk * 4);
+	val = tc358768_ns_to_cnt(val, hsbyteclk_nsk) / 4 - 1;
 	dev_dbg(dev, "TXTAGOCNT: %u\n", val);
-	val2 = tc358768_ns_to_cnt(tc358768_to_ns((lptxcnt + 1) * dsibclk_nsk),
-				  dsibclk_nsk) - 2;
+	val2 = tc358768_ns_to_cnt(tc358768_to_ns((lptxcnt + 1) * hsbyteclk_nsk),
+				  hsbyteclk_nsk) - 2;
 	dev_dbg(dev, "RXTASURECNT: %u\n", val2);
 	val = val << 16 | val2;
 	tc358768_write(priv, TC358768_BTACNTRL1, val);
@@ -832,13 +832,13 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
 
 		/* hsw * byteclk * ndl / pclk */
 		val = (u32)div_u64(vm.hsync_len *
-				   ((u64)priv->dsiclk / 4) * priv->dsi_lanes,
+				   (u64)hsbyteclk * priv->dsi_lanes,
 				   vm.pixelclock);
 		tc358768_write(priv, TC358768_DSI_HSW, val);
 
 		/* hbp * byteclk * ndl / pclk */
 		val = (u32)div_u64(vm.hback_porch *
-				   ((u64)priv->dsiclk / 4) * priv->dsi_lanes,
+				   (u64)hsbyteclk * priv->dsi_lanes,
 				   vm.pixelclock);
 		tc358768_write(priv, TC358768_DSI_HBPR, val);
 	} else {
@@ -857,7 +857,7 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
 
 		/* (hsw + hbp) * byteclk * ndl / pclk */
 		val = (u32)div_u64((vm.hsync_len + vm.hback_porch) *
-				   ((u64)priv->dsiclk / 4) * priv->dsi_lanes,
+				   (u64)hsbyteclk * priv->dsi_lanes,
 				   vm.pixelclock);
 		tc358768_write(priv, TC358768_DSI_HSW, val);
 
-- 
2.42.0



