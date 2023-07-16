Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7E975551B
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbjGPUha (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbjGPUh3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:37:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC5AAB
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:37:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5BE560EBA
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:37:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD386C433C7;
        Sun, 16 Jul 2023 20:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539846;
        bh=DjDVurBA6rmSWngpAw4W7c7QhktxjztNTr2Dwm7SzAw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bHB62WPIo+9j/hlhZK6yCGIfVL46H9ygTRzMqaaEJdl1126+GCvlf/iYCPrety0+F
         AuuP7JLZBt35dEqwZ/wapan4sFu8jJ9EK56lAAP3mniywRAJeoZvjBx4Czj/vxYq5f
         h66mlojMh5hKUh3NPeHUvtps9Binr859x0OVb2Vw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Robert Foss <rfoss@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 152/591] drm/bridge: tc358768: fix TCLK_TRAILCNT computation
Date:   Sun, 16 Jul 2023 21:44:51 +0200
Message-ID: <20230716194927.798495956@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Francesco Dolcini <francesco.dolcini@toradex.com>

[ Upstream commit ee18698e212b1659dd0850d7e2ae0f22e16ed3d3 ]

Correct computation of TCLK_TRAILCNT register.

The driver does not implement non-continuous clock mode, so the actual
value doesn't make a practical difference yet. However this change also
ensures that the value does not write to reserved registers bits in case
of under/overflow.

This register must be set to a value that ensures that

TCLK-TRAIL > 60ns
 and
TEOT <= (105 ns + 12 x UI)

with the actual value of TCLK-TRAIL being

(TCLK_TRAILCNT + (1 to 2)) xHSByteClkCycle +
 (2 + (1 to 2)) * HSBYTECLKCycle - (PHY output delay)

with PHY output delay being about

(2 to 3) x MIPIBitClk cycle in the BitClk conversion.

Fixes: ff1ca6397b1d ("drm/bridge: Add tc358768 driver")
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Reviewed-by: Robert Foss <rfoss@kernel.org>
Signed-off-by: Robert Foss <rfoss@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20230427142934.55435-2-francesco@dolcini.it
Link: https://patchwork.freedesktop.org/patch/msgid/20230427142934.55435-3-francesco@dolcini.it
Link: https://patchwork.freedesktop.org/patch/msgid/20230427142934.55435-4-francesco@dolcini.it
Link: https://patchwork.freedesktop.org/patch/msgid/20230427142934.55435-5-francesco@dolcini.it
Link: https://patchwork.freedesktop.org/patch/msgid/20230427142934.55435-2-francesco@dolcini.it
Link: https://patchwork.freedesktop.org/patch/msgid/20230427142934.55435-3-francesco@dolcini.it
Link: https://patchwork.freedesktop.org/patch/msgid/20230427142934.55435-4-francesco@dolcini.it
Link: https://patchwork.freedesktop.org/patch/msgid/20230427142934.55435-5-francesco@dolcini.it
Link: https://patchwork.freedesktop.org/patch/msgid/20230427142934.55435-2-francesco@dolcini.it
Link: https://patchwork.freedesktop.org/patch/msgid/20230427142934.55435-3-francesco@dolcini.it
Link: https://patchwork.freedesktop.org/patch/msgid/20230427142934.55435-4-francesco@dolcini.it
Link: https://patchwork.freedesktop.org/patch/msgid/20230427142934.55435-5-francesco@dolcini.it
Link: https://patchwork.freedesktop.org/patch/msgid/20230427142934.55435-2-francesco@dolcini.it
Link: https://patchwork.freedesktop.org/patch/msgid/20230427142934.55435-3-francesco@dolcini.it
Link: https://patchwork.freedesktop.org/patch/msgid/20230427142934.55435-4-francesco@dolcini.it
Link: https://patchwork.freedesktop.org/patch/msgid/20230427142934.55435-5-francesco@dolcini.it
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/tc358768.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/tc358768.c
index 8f7efb14ebdc7..822de6e356a2c 100644
--- a/drivers/gpu/drm/bridge/tc358768.c
+++ b/drivers/gpu/drm/bridge/tc358768.c
@@ -10,6 +10,7 @@
 #include <linux/i2c.h>
 #include <linux/kernel.h>
 #include <linux/media-bus-format.h>
+#include <linux/minmax.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
@@ -640,6 +641,7 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
 	struct mipi_dsi_device *dsi_dev = priv->output.dev;
 	unsigned long mode_flags = dsi_dev->mode_flags;
 	u32 val, val2, lptxcnt, hact, data_type;
+	s32 raw_val;
 	const struct drm_display_mode *mode;
 	u32 dsibclk_nsk, dsiclk_nsk, ui_nsk, phy_delay_nsk;
 	u32 dsiclk, dsibclk, video_start;
@@ -751,9 +753,9 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
 	dev_dbg(priv->dev, "TCLK_HEADERCNT: 0x%x\n", val);
 	tc358768_write(priv, TC358768_TCLK_HEADERCNT, val);
 
-	/* TCLK_TRAIL > 60ns + 3*UI */
-	val = 60 + tc358768_to_ns(3 * ui_nsk);
-	val = tc358768_ns_to_cnt(val, dsibclk_nsk) - 5;
+	/* TCLK_TRAIL > 60ns AND TEOT <= 105 ns + 12*UI */
+	raw_val = tc358768_ns_to_cnt(60 + tc358768_to_ns(2 * ui_nsk), dsibclk_nsk) - 5;
+	val = clamp(raw_val, 0, 127);
 	dev_dbg(priv->dev, "TCLK_TRAILCNT: 0x%x\n", val);
 	tc358768_write(priv, TC358768_TCLK_TRAILCNT, val);
 
-- 
2.39.2



