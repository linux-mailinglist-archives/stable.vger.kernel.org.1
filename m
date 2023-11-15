Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB2B7ECE55
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234992AbjKOTmZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:42:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234980AbjKOTmY (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:42:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9A2B9
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:42:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27858C433C9;
        Wed, 15 Nov 2023 19:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077341;
        bh=Egbyh1psw/HLx7PZD28pHJLUui8WM6+/gjaR4N40Hhc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HIFcOIBnuAWwIbj0KR3vUfCdpQ4MUPGlWG2aI26fRywX/sL2ObN4uGE23qLaMPnaO
         nx6u/JrmUL3ydtys7k/uv95N04Y76SRd7g/euVsfHzk0a9j2IX3mFGviKIeNisZDUg
         kMOkMeAuna0B4hrl5QHpNeIZk8tDZ5yZDo+CtJPo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Robert Foss <rfoss@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        Maxim Schwalm <maxim.schwalm@gmail.com>
Subject: [PATCH 6.6 235/603] drm/bridge: tc358768: Print logical values, not raw register values
Date:   Wed, 15 Nov 2023 14:13:00 -0500
Message-ID: <20231115191629.460891849@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

[ Upstream commit 013ea98cdfccef3b7c38b087c1f629488d2ef683 ]

The driver debug prints DSI related timings as raw register values in
hex. It is much more useful to see the "logical" value of the timing,
not the register value.

Change the prints to print the values separately, in case a single
register contains multiple values, and use %u to have it in a more human
consumable form.

Reviewed-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
Tested-by: Maxim Schwalm <maxim.schwalm@gmail.com> # Asus TF700T
Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Signed-off-by: Robert Foss <rfoss@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20230906-tc358768-v4-7-31725f008a50@ideasonboard.com
Stable-dep-of: f1dabbe64506 ("drm/bridge: tc358768: Fix tc358768_ns_to_cnt()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/tc358768.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/tc358768.c
index e42b5259ea344..163477ec91a9c 100644
--- a/drivers/gpu/drm/bridge/tc358768.c
+++ b/drivers/gpu/drm/bridge/tc358768.c
@@ -739,57 +739,59 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
 
 	/* LP11 > 100us for D-PHY Rx Init */
 	val = tc358768_ns_to_cnt(100 * 1000, dsibclk_nsk) - 1;
-	dev_dbg(priv->dev, "LINEINITCNT: 0x%x\n", val);
+	dev_dbg(priv->dev, "LINEINITCNT: %u\n", val);
 	tc358768_write(priv, TC358768_LINEINITCNT, val);
 
 	/* LPTimeCnt > 50ns */
 	val = tc358768_ns_to_cnt(50, dsibclk_nsk) - 1;
 	lptxcnt = val;
-	dev_dbg(priv->dev, "LPTXTIMECNT: 0x%x\n", val);
+	dev_dbg(priv->dev, "LPTXTIMECNT: %u\n", val);
 	tc358768_write(priv, TC358768_LPTXTIMECNT, val);
 
 	/* 38ns < TCLK_PREPARE < 95ns */
 	val = tc358768_ns_to_cnt(65, dsibclk_nsk) - 1;
+	dev_dbg(priv->dev, "TCLK_PREPARECNT %u\n", val);
 	/* TCLK_PREPARE + TCLK_ZERO > 300ns */
 	val2 = tc358768_ns_to_cnt(300 - tc358768_to_ns(2 * ui_nsk),
 				  dsibclk_nsk) - 2;
+	dev_dbg(priv->dev, "TCLK_ZEROCNT %u\n", val2);
 	val |= val2 << 8;
-	dev_dbg(priv->dev, "TCLK_HEADERCNT: 0x%x\n", val);
 	tc358768_write(priv, TC358768_TCLK_HEADERCNT, val);
 
 	/* TCLK_TRAIL > 60ns AND TEOT <= 105 ns + 12*UI */
 	raw_val = tc358768_ns_to_cnt(60 + tc358768_to_ns(2 * ui_nsk), dsibclk_nsk) - 5;
 	val = clamp(raw_val, 0, 127);
-	dev_dbg(priv->dev, "TCLK_TRAILCNT: 0x%x\n", val);
+	dev_dbg(priv->dev, "TCLK_TRAILCNT: %u\n", val);
 	tc358768_write(priv, TC358768_TCLK_TRAILCNT, val);
 
 	/* 40ns + 4*UI < THS_PREPARE < 85ns + 6*UI */
 	val = 50 + tc358768_to_ns(4 * ui_nsk);
 	val = tc358768_ns_to_cnt(val, dsibclk_nsk) - 1;
+	dev_dbg(priv->dev, "THS_PREPARECNT %u\n", val);
 	/* THS_PREPARE + THS_ZERO > 145ns + 10*UI */
 	raw_val = tc358768_ns_to_cnt(145 - tc358768_to_ns(3 * ui_nsk), dsibclk_nsk) - 10;
 	val2 = clamp(raw_val, 0, 127);
+	dev_dbg(priv->dev, "THS_ZEROCNT %u\n", val2);
 	val |= val2 << 8;
-	dev_dbg(priv->dev, "THS_HEADERCNT: 0x%x\n", val);
 	tc358768_write(priv, TC358768_THS_HEADERCNT, val);
 
 	/* TWAKEUP > 1ms in lptxcnt steps */
 	val = tc358768_ns_to_cnt(1020000, dsibclk_nsk);
 	val = val / (lptxcnt + 1) - 1;
-	dev_dbg(priv->dev, "TWAKEUP: 0x%x\n", val);
+	dev_dbg(priv->dev, "TWAKEUP: %u\n", val);
 	tc358768_write(priv, TC358768_TWAKEUP, val);
 
 	/* TCLK_POSTCNT > 60ns + 52*UI */
 	val = tc358768_ns_to_cnt(60 + tc358768_to_ns(52 * ui_nsk),
 				 dsibclk_nsk) - 3;
-	dev_dbg(priv->dev, "TCLK_POSTCNT: 0x%x\n", val);
+	dev_dbg(priv->dev, "TCLK_POSTCNT: %u\n", val);
 	tc358768_write(priv, TC358768_TCLK_POSTCNT, val);
 
 	/* max(60ns + 4*UI, 8*UI) < THS_TRAILCNT < 105ns + 12*UI */
 	raw_val = tc358768_ns_to_cnt(60 + tc358768_to_ns(18 * ui_nsk),
 				     dsibclk_nsk) - 4;
 	val = clamp(raw_val, 0, 15);
-	dev_dbg(priv->dev, "THS_TRAILCNT: 0x%x\n", val);
+	dev_dbg(priv->dev, "THS_TRAILCNT: %u\n", val);
 	tc358768_write(priv, TC358768_THS_TRAILCNT, val);
 
 	val = BIT(0);
@@ -803,10 +805,11 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
 	/* TXTAGOCNT[26:16] RXTASURECNT[10:0] */
 	val = tc358768_to_ns((lptxcnt + 1) * dsibclk_nsk * 4);
 	val = tc358768_ns_to_cnt(val, dsibclk_nsk) / 4 - 1;
+	dev_dbg(priv->dev, "TXTAGOCNT: %u\n", val);
 	val2 = tc358768_ns_to_cnt(tc358768_to_ns((lptxcnt + 1) * dsibclk_nsk),
 				  dsibclk_nsk) - 2;
+	dev_dbg(priv->dev, "RXTASURECNT: %u\n", val2);
 	val = val << 16 | val2;
-	dev_dbg(priv->dev, "BTACNTRL1: 0x%x\n", val);
 	tc358768_write(priv, TC358768_BTACNTRL1, val);
 
 	/* START[0] */
-- 
2.42.0



