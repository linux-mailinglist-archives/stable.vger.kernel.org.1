Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DEEB7ECC0C
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233508AbjKOT0l (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:26:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233887AbjKOT0Z (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:26:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055F5D49
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:26:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B7B8C433CA;
        Wed, 15 Nov 2023 19:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076380;
        bh=NMjxLhbHOjoqaOg+3Jc1vbtP0QthJXl5YxpCZtqrQ10=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0CWyjxURFkyu/oFWvhxBNn8ABnJB8J4VJBPijBaHmuoTAD2hkjMYq7T06zMDn3l5v
         V6ebReQuPHta43KH6PtO8R7ikbWXqvpDh4wwAk6FXAUoSP/5rLNNajIsmHacY8XLmt
         NMjAB5Q5dVGh2b9pYTcEimymOsutpzKsrVIkPyMw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Robert Foss <rfoss@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        Maxim Schwalm <maxim.schwalm@gmail.com>
Subject: [PATCH 6.5 221/550] drm/bridge: tc358768: Use dev for dbg prints, not priv->dev
Date:   Wed, 15 Nov 2023 14:13:25 -0500
Message-ID: <20231115191616.066745207@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

[ Upstream commit 89cfd50e13f1bead4350998a3a77422bef1ee0a5 ]

Simplify the code by capturing the priv->dev value to dev variable, and
use it.

Reviewed-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
Tested-by: Maxim Schwalm <maxim.schwalm@gmail.com> # Asus TF700T
Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Signed-off-by: Robert Foss <rfoss@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20230906-tc358768-v4-8-31725f008a50@ideasonboard.com
Stable-dep-of: f1dabbe64506 ("drm/bridge: tc358768: Fix tc358768_ns_to_cnt()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/tc358768.c | 41 ++++++++++++++++---------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/tc358768.c
index 163477ec91a9c..d909590ab31b8 100644
--- a/drivers/gpu/drm/bridge/tc358768.c
+++ b/drivers/gpu/drm/bridge/tc358768.c
@@ -651,9 +651,10 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
 	const u32 internal_delay = 40;
 	int ret, i;
 	struct videomode vm;
+	struct device *dev = priv->dev;
 
 	if (mode_flags & MIPI_DSI_CLOCK_NON_CONTINUOUS) {
-		dev_warn_once(priv->dev, "Non-continuous mode unimplemented, falling back to continuous\n");
+		dev_warn_once(dev, "Non-continuous mode unimplemented, falling back to continuous\n");
 		mode_flags &= ~MIPI_DSI_CLOCK_NON_CONTINUOUS;
 	}
 
@@ -661,7 +662,7 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
 
 	ret = tc358768_sw_reset(priv);
 	if (ret) {
-		dev_err(priv->dev, "Software reset failed: %d\n", ret);
+		dev_err(dev, "Software reset failed: %d\n", ret);
 		tc358768_hw_disable(priv);
 		return;
 	}
@@ -669,7 +670,7 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
 	mode = &bridge->encoder->crtc->state->adjusted_mode;
 	ret = tc358768_setup_pll(priv, mode);
 	if (ret) {
-		dev_err(priv->dev, "PLL setup failed: %d\n", ret);
+		dev_err(dev, "PLL setup failed: %d\n", ret);
 		tc358768_hw_disable(priv);
 		return;
 	}
@@ -709,7 +710,7 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
 		data_type = MIPI_DSI_PACKED_PIXEL_STREAM_16;
 		break;
 	default:
-		dev_err(priv->dev, "Invalid data format (%u)\n",
+		dev_err(dev, "Invalid data format (%u)\n",
 			dsi_dev->format);
 		tc358768_hw_disable(priv);
 		return;
@@ -733,65 +734,65 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
 				  dsibclk);
 	dsiclk_nsk = (u32)div_u64((u64)1000000000 * TC358768_PRECISION, dsiclk);
 	ui_nsk = dsiclk_nsk / 2;
-	dev_dbg(priv->dev, "dsiclk_nsk: %u\n", dsiclk_nsk);
-	dev_dbg(priv->dev, "ui_nsk: %u\n", ui_nsk);
-	dev_dbg(priv->dev, "dsibclk_nsk: %u\n", dsibclk_nsk);
+	dev_dbg(dev, "dsiclk_nsk: %u\n", dsiclk_nsk);
+	dev_dbg(dev, "ui_nsk: %u\n", ui_nsk);
+	dev_dbg(dev, "dsibclk_nsk: %u\n", dsibclk_nsk);
 
 	/* LP11 > 100us for D-PHY Rx Init */
 	val = tc358768_ns_to_cnt(100 * 1000, dsibclk_nsk) - 1;
-	dev_dbg(priv->dev, "LINEINITCNT: %u\n", val);
+	dev_dbg(dev, "LINEINITCNT: %u\n", val);
 	tc358768_write(priv, TC358768_LINEINITCNT, val);
 
 	/* LPTimeCnt > 50ns */
 	val = tc358768_ns_to_cnt(50, dsibclk_nsk) - 1;
 	lptxcnt = val;
-	dev_dbg(priv->dev, "LPTXTIMECNT: %u\n", val);
+	dev_dbg(dev, "LPTXTIMECNT: %u\n", val);
 	tc358768_write(priv, TC358768_LPTXTIMECNT, val);
 
 	/* 38ns < TCLK_PREPARE < 95ns */
 	val = tc358768_ns_to_cnt(65, dsibclk_nsk) - 1;
-	dev_dbg(priv->dev, "TCLK_PREPARECNT %u\n", val);
+	dev_dbg(dev, "TCLK_PREPARECNT %u\n", val);
 	/* TCLK_PREPARE + TCLK_ZERO > 300ns */
 	val2 = tc358768_ns_to_cnt(300 - tc358768_to_ns(2 * ui_nsk),
 				  dsibclk_nsk) - 2;
-	dev_dbg(priv->dev, "TCLK_ZEROCNT %u\n", val2);
+	dev_dbg(dev, "TCLK_ZEROCNT %u\n", val2);
 	val |= val2 << 8;
 	tc358768_write(priv, TC358768_TCLK_HEADERCNT, val);
 
 	/* TCLK_TRAIL > 60ns AND TEOT <= 105 ns + 12*UI */
 	raw_val = tc358768_ns_to_cnt(60 + tc358768_to_ns(2 * ui_nsk), dsibclk_nsk) - 5;
 	val = clamp(raw_val, 0, 127);
-	dev_dbg(priv->dev, "TCLK_TRAILCNT: %u\n", val);
+	dev_dbg(dev, "TCLK_TRAILCNT: %u\n", val);
 	tc358768_write(priv, TC358768_TCLK_TRAILCNT, val);
 
 	/* 40ns + 4*UI < THS_PREPARE < 85ns + 6*UI */
 	val = 50 + tc358768_to_ns(4 * ui_nsk);
 	val = tc358768_ns_to_cnt(val, dsibclk_nsk) - 1;
-	dev_dbg(priv->dev, "THS_PREPARECNT %u\n", val);
+	dev_dbg(dev, "THS_PREPARECNT %u\n", val);
 	/* THS_PREPARE + THS_ZERO > 145ns + 10*UI */
 	raw_val = tc358768_ns_to_cnt(145 - tc358768_to_ns(3 * ui_nsk), dsibclk_nsk) - 10;
 	val2 = clamp(raw_val, 0, 127);
-	dev_dbg(priv->dev, "THS_ZEROCNT %u\n", val2);
+	dev_dbg(dev, "THS_ZEROCNT %u\n", val2);
 	val |= val2 << 8;
 	tc358768_write(priv, TC358768_THS_HEADERCNT, val);
 
 	/* TWAKEUP > 1ms in lptxcnt steps */
 	val = tc358768_ns_to_cnt(1020000, dsibclk_nsk);
 	val = val / (lptxcnt + 1) - 1;
-	dev_dbg(priv->dev, "TWAKEUP: %u\n", val);
+	dev_dbg(dev, "TWAKEUP: %u\n", val);
 	tc358768_write(priv, TC358768_TWAKEUP, val);
 
 	/* TCLK_POSTCNT > 60ns + 52*UI */
 	val = tc358768_ns_to_cnt(60 + tc358768_to_ns(52 * ui_nsk),
 				 dsibclk_nsk) - 3;
-	dev_dbg(priv->dev, "TCLK_POSTCNT: %u\n", val);
+	dev_dbg(dev, "TCLK_POSTCNT: %u\n", val);
 	tc358768_write(priv, TC358768_TCLK_POSTCNT, val);
 
 	/* max(60ns + 4*UI, 8*UI) < THS_TRAILCNT < 105ns + 12*UI */
 	raw_val = tc358768_ns_to_cnt(60 + tc358768_to_ns(18 * ui_nsk),
 				     dsibclk_nsk) - 4;
 	val = clamp(raw_val, 0, 15);
-	dev_dbg(priv->dev, "THS_TRAILCNT: %u\n", val);
+	dev_dbg(dev, "THS_TRAILCNT: %u\n", val);
 	tc358768_write(priv, TC358768_THS_TRAILCNT, val);
 
 	val = BIT(0);
@@ -805,10 +806,10 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
 	/* TXTAGOCNT[26:16] RXTASURECNT[10:0] */
 	val = tc358768_to_ns((lptxcnt + 1) * dsibclk_nsk * 4);
 	val = tc358768_ns_to_cnt(val, dsibclk_nsk) / 4 - 1;
-	dev_dbg(priv->dev, "TXTAGOCNT: %u\n", val);
+	dev_dbg(dev, "TXTAGOCNT: %u\n", val);
 	val2 = tc358768_ns_to_cnt(tc358768_to_ns((lptxcnt + 1) * dsibclk_nsk),
 				  dsibclk_nsk) - 2;
-	dev_dbg(priv->dev, "RXTASURECNT: %u\n", val2);
+	dev_dbg(dev, "RXTASURECNT: %u\n", val2);
 	val = val << 16 | val2;
 	tc358768_write(priv, TC358768_BTACNTRL1, val);
 
@@ -902,7 +903,7 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
 
 	ret = tc358768_clear_error(priv);
 	if (ret) {
-		dev_err(priv->dev, "Bridge pre_enable failed: %d\n", ret);
+		dev_err(dev, "Bridge pre_enable failed: %d\n", ret);
 		tc358768_bridge_disable(bridge);
 		tc358768_bridge_post_disable(bridge);
 	}
-- 
2.42.0



