Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 855DA7ECBFD
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233626AbjKOT0P (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:26:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233786AbjKOT0B (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:26:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F711A3
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:25:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A31AC433C8;
        Wed, 15 Nov 2023 19:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076357;
        bh=Sw1lvA3EmbaSOvEb20JsLx+gZlA0JsHCR3zB8vPAHjg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UyxwFVg5H8ZHud8LCuXUN3jIvUw0I9EezC0qw8sMN0GltjS6Ql+du8JmM8StzrG9E
         JNEumi2NSA/tDnFZgJv8a5K58iNLcMlG7NiG/oOxkoNZTPhdOdp4U1pSIaA78LTytE
         RGaQA70aa6V3W20ZbCyzjAsA45PkHrJDrXLc4mjQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Robert Foss <rfoss@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        Maxim Schwalm <maxim.schwalm@gmail.com>
Subject: [PATCH 6.5 223/550] drm/bridge: tc358768: Clean up clock period code
Date:   Wed, 15 Nov 2023 14:13:27 -0500
Message-ID: <20231115191616.215926296@linuxfoundation.org>
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

[ Upstream commit b3aa7b34924a9ed64cf96899cac4d8ea08cd829e ]

The driver defines TC358768_PRECISION as 1000, and uses "nsk" to refer
to clock periods. The original author does not remember where all this
came from. Effectively the driver is using picoseconds as the unit for
clock periods, yet referring to them by "nsk".

Clean this up by just saying the periods are in picoseconds.

Reviewed-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
Tested-by: Maxim Schwalm <maxim.schwalm@gmail.com> # Asus TF700T
Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Signed-off-by: Robert Foss <rfoss@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20230906-tc358768-v4-10-31725f008a50@ideasonboard.com
Stable-dep-of: f1dabbe64506 ("drm/bridge: tc358768: Fix tc358768_ns_to_cnt()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/tc358768.c | 60 +++++++++++++++----------------
 1 file changed, 29 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/tc358768.c
index 0388093f703cc..d1000d1f69f4e 100644
--- a/drivers/gpu/drm/bridge/tc358768.c
+++ b/drivers/gpu/drm/bridge/tc358768.c
@@ -15,6 +15,7 @@
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
+#include <linux/units.h>
 
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_drv.h>
@@ -627,15 +628,14 @@ static int tc358768_setup_pll(struct tc358768_priv *priv,
 	return tc358768_clear_error(priv);
 }
 
-#define TC358768_PRECISION	1000
-static u32 tc358768_ns_to_cnt(u32 ns, u32 period_nsk)
+static u32 tc358768_ns_to_cnt(u32 ns, u32 period_ps)
 {
-	return (ns * TC358768_PRECISION + period_nsk) / period_nsk;
+	return (ns * 1000 + period_ps) / period_ps;
 }
 
-static u32 tc358768_to_ns(u32 nsk)
+static u32 tc358768_ps_to_ns(u32 ps)
 {
-	return (nsk / TC358768_PRECISION);
+	return ps / 1000;
 }
 
 static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
@@ -646,7 +646,7 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
 	u32 val, val2, lptxcnt, hact, data_type;
 	s32 raw_val;
 	const struct drm_display_mode *mode;
-	u32 hsbyteclk_nsk, dsiclk_nsk, ui_nsk;
+	u32 hsbyteclk_ps, dsiclk_ps, ui_ps;
 	u32 dsiclk, hsbyteclk, video_start;
 	const u32 internal_delay = 40;
 	int ret, i;
@@ -730,67 +730,65 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
 		tc358768_write(priv, TC358768_D0W_CNTRL + i * 4, 0x0000);
 
 	/* DSI Timings */
-	hsbyteclk_nsk = (u32)div_u64((u64)1000000000 * TC358768_PRECISION,
-				  hsbyteclk);
-	dsiclk_nsk = (u32)div_u64((u64)1000000000 * TC358768_PRECISION, dsiclk);
-	ui_nsk = dsiclk_nsk / 2;
-	dev_dbg(dev, "dsiclk_nsk: %u\n", dsiclk_nsk);
-	dev_dbg(dev, "ui_nsk: %u\n", ui_nsk);
-	dev_dbg(dev, "hsbyteclk_nsk: %u\n", hsbyteclk_nsk);
+	hsbyteclk_ps = (u32)div_u64(PICO, hsbyteclk);
+	dsiclk_ps = (u32)div_u64(PICO, dsiclk);
+	ui_ps = dsiclk_ps / 2;
+	dev_dbg(dev, "dsiclk: %u ps, ui %u ps, hsbyteclk %u ps\n", dsiclk_ps,
+		ui_ps, hsbyteclk_ps);
 
 	/* LP11 > 100us for D-PHY Rx Init */
-	val = tc358768_ns_to_cnt(100 * 1000, hsbyteclk_nsk) - 1;
+	val = tc358768_ns_to_cnt(100 * 1000, hsbyteclk_ps) - 1;
 	dev_dbg(dev, "LINEINITCNT: %u\n", val);
 	tc358768_write(priv, TC358768_LINEINITCNT, val);
 
 	/* LPTimeCnt > 50ns */
-	val = tc358768_ns_to_cnt(50, hsbyteclk_nsk) - 1;
+	val = tc358768_ns_to_cnt(50, hsbyteclk_ps) - 1;
 	lptxcnt = val;
 	dev_dbg(dev, "LPTXTIMECNT: %u\n", val);
 	tc358768_write(priv, TC358768_LPTXTIMECNT, val);
 
 	/* 38ns < TCLK_PREPARE < 95ns */
-	val = tc358768_ns_to_cnt(65, hsbyteclk_nsk) - 1;
+	val = tc358768_ns_to_cnt(65, hsbyteclk_ps) - 1;
 	dev_dbg(dev, "TCLK_PREPARECNT %u\n", val);
 	/* TCLK_PREPARE + TCLK_ZERO > 300ns */
-	val2 = tc358768_ns_to_cnt(300 - tc358768_to_ns(2 * ui_nsk),
-				  hsbyteclk_nsk) - 2;
+	val2 = tc358768_ns_to_cnt(300 - tc358768_ps_to_ns(2 * ui_ps),
+				  hsbyteclk_ps) - 2;
 	dev_dbg(dev, "TCLK_ZEROCNT %u\n", val2);
 	val |= val2 << 8;
 	tc358768_write(priv, TC358768_TCLK_HEADERCNT, val);
 
 	/* TCLK_TRAIL > 60ns AND TEOT <= 105 ns + 12*UI */
-	raw_val = tc358768_ns_to_cnt(60 + tc358768_to_ns(2 * ui_nsk), hsbyteclk_nsk) - 5;
+	raw_val = tc358768_ns_to_cnt(60 + tc358768_ps_to_ns(2 * ui_ps), hsbyteclk_ps) - 5;
 	val = clamp(raw_val, 0, 127);
 	dev_dbg(dev, "TCLK_TRAILCNT: %u\n", val);
 	tc358768_write(priv, TC358768_TCLK_TRAILCNT, val);
 
 	/* 40ns + 4*UI < THS_PREPARE < 85ns + 6*UI */
-	val = 50 + tc358768_to_ns(4 * ui_nsk);
-	val = tc358768_ns_to_cnt(val, hsbyteclk_nsk) - 1;
+	val = 50 + tc358768_ps_to_ns(4 * ui_ps);
+	val = tc358768_ns_to_cnt(val, hsbyteclk_ps) - 1;
 	dev_dbg(dev, "THS_PREPARECNT %u\n", val);
 	/* THS_PREPARE + THS_ZERO > 145ns + 10*UI */
-	raw_val = tc358768_ns_to_cnt(145 - tc358768_to_ns(3 * ui_nsk), hsbyteclk_nsk) - 10;
+	raw_val = tc358768_ns_to_cnt(145 - tc358768_ps_to_ns(3 * ui_ps), hsbyteclk_ps) - 10;
 	val2 = clamp(raw_val, 0, 127);
 	dev_dbg(dev, "THS_ZEROCNT %u\n", val2);
 	val |= val2 << 8;
 	tc358768_write(priv, TC358768_THS_HEADERCNT, val);
 
 	/* TWAKEUP > 1ms in lptxcnt steps */
-	val = tc358768_ns_to_cnt(1020000, hsbyteclk_nsk);
+	val = tc358768_ns_to_cnt(1020000, hsbyteclk_ps);
 	val = val / (lptxcnt + 1) - 1;
 	dev_dbg(dev, "TWAKEUP: %u\n", val);
 	tc358768_write(priv, TC358768_TWAKEUP, val);
 
 	/* TCLK_POSTCNT > 60ns + 52*UI */
-	val = tc358768_ns_to_cnt(60 + tc358768_to_ns(52 * ui_nsk),
-				 hsbyteclk_nsk) - 3;
+	val = tc358768_ns_to_cnt(60 + tc358768_ps_to_ns(52 * ui_ps),
+				 hsbyteclk_ps) - 3;
 	dev_dbg(dev, "TCLK_POSTCNT: %u\n", val);
 	tc358768_write(priv, TC358768_TCLK_POSTCNT, val);
 
 	/* max(60ns + 4*UI, 8*UI) < THS_TRAILCNT < 105ns + 12*UI */
-	raw_val = tc358768_ns_to_cnt(60 + tc358768_to_ns(18 * ui_nsk),
-				     hsbyteclk_nsk) - 4;
+	raw_val = tc358768_ns_to_cnt(60 + tc358768_ps_to_ns(18 * ui_ps),
+				     hsbyteclk_ps) - 4;
 	val = clamp(raw_val, 0, 15);
 	dev_dbg(dev, "THS_TRAILCNT: %u\n", val);
 	tc358768_write(priv, TC358768_THS_TRAILCNT, val);
@@ -804,11 +802,11 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
 		       (mode_flags & MIPI_DSI_CLOCK_NON_CONTINUOUS) ? 0 : BIT(0));
 
 	/* TXTAGOCNT[26:16] RXTASURECNT[10:0] */
-	val = tc358768_to_ns((lptxcnt + 1) * hsbyteclk_nsk * 4);
-	val = tc358768_ns_to_cnt(val, hsbyteclk_nsk) / 4 - 1;
+	val = tc358768_ps_to_ns((lptxcnt + 1) * hsbyteclk_ps * 4);
+	val = tc358768_ns_to_cnt(val, hsbyteclk_ps) / 4 - 1;
 	dev_dbg(dev, "TXTAGOCNT: %u\n", val);
-	val2 = tc358768_ns_to_cnt(tc358768_to_ns((lptxcnt + 1) * hsbyteclk_nsk),
-				  hsbyteclk_nsk) - 2;
+	val2 = tc358768_ns_to_cnt(tc358768_ps_to_ns((lptxcnt + 1) * hsbyteclk_ps),
+				  hsbyteclk_ps) - 2;
 	dev_dbg(dev, "RXTASURECNT: %u\n", val2);
 	val = val << 16 | val2;
 	tc358768_write(priv, TC358768_BTACNTRL1, val);
-- 
2.42.0



