Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4767ECE4C
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234974AbjKOTmL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:42:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234971AbjKOTmL (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:42:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264259E
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:42:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84F60C433C9;
        Wed, 15 Nov 2023 19:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077327;
        bh=smpZNfv/bGG8HpTkXIWIIL0gtx0Xn3898CDsYeSuzfg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QxIQ9PMgN+wQnSLXx7zw7J6NVoxn53kuEyGAWc3Umkf/X6xpidq4eVEore9DUWKHs
         nFN+SQDuVJY/wsFQzY1uGo22xe/z66itbaNYdsXLM1K7b3epiRFtgxedvo1GsuYN5H
         MLzSUG7F3FY0WD67FQ3l5zlDimvNuXnE6EiKOmuk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Robert Foss <rfoss@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        Maxim Schwalm <maxim.schwalm@gmail.com>
Subject: [PATCH 6.6 233/603] drm/bridge: tc358768: Fix bit updates
Date:   Wed, 15 Nov 2023 14:12:58 -0500
Message-ID: <20231115191629.320043916@linuxfoundation.org>
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

[ Upstream commit 66962d5c3c51377b9b90cae35b7e038950438e02 ]

The driver has a few places where it does:

if (thing_is_enabled_in_config)
	update_thing_bit_in_hw()

This means that if the thing is _not_ enabled, the bit never gets
cleared. This affects the h/vsyncs and continuous DSI clock bits.

Fix the driver to always update the bit.

Fixes: ff1ca6397b1d ("drm/bridge: Add tc358768 driver")
Reviewed-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
Tested-by: Maxim Schwalm <maxim.schwalm@gmail.com> # Asus TF700T
Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Signed-off-by: Robert Foss <rfoss@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20230906-tc358768-v4-4-31725f008a50@ideasonboard.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/tc358768.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/tc358768.c
index bc97a837955ba..b668f77673c3d 100644
--- a/drivers/gpu/drm/bridge/tc358768.c
+++ b/drivers/gpu/drm/bridge/tc358768.c
@@ -794,8 +794,8 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
 		val |= BIT(i + 1);
 	tc358768_write(priv, TC358768_HSTXVREGEN, val);
 
-	if (!(mode_flags & MIPI_DSI_CLOCK_NON_CONTINUOUS))
-		tc358768_write(priv, TC358768_TXOPTIONCNTRL, 0x1);
+	tc358768_write(priv, TC358768_TXOPTIONCNTRL,
+		       (mode_flags & MIPI_DSI_CLOCK_NON_CONTINUOUS) ? 0 : BIT(0));
 
 	/* TXTAGOCNT[26:16] RXTASURECNT[10:0] */
 	val = tc358768_to_ns((lptxcnt + 1) * dsibclk_nsk * 4);
@@ -861,11 +861,12 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
 	tc358768_write(priv, TC358768_DSI_HACT, hact);
 
 	/* VSYNC polarity */
-	if (!(mode->flags & DRM_MODE_FLAG_NVSYNC))
-		tc358768_update_bits(priv, TC358768_CONFCTL, BIT(5), BIT(5));
+	tc358768_update_bits(priv, TC358768_CONFCTL, BIT(5),
+			     (mode->flags & DRM_MODE_FLAG_PVSYNC) ? BIT(5) : 0);
+
 	/* HSYNC polarity */
-	if (mode->flags & DRM_MODE_FLAG_PHSYNC)
-		tc358768_update_bits(priv, TC358768_PP_MISC, BIT(0), BIT(0));
+	tc358768_update_bits(priv, TC358768_PP_MISC, BIT(0),
+			     (mode->flags & DRM_MODE_FLAG_PHSYNC) ? BIT(0) : 0);
 
 	/* Start DSI Tx */
 	tc358768_write(priv, TC358768_DSI_START, 0x1);
-- 
2.42.0



