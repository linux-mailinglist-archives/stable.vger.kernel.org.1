Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2027755231
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbjGPUE4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbjGPUEz (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:04:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69CA1B4
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:04:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7271560DD4
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:04:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86A83C433C8;
        Sun, 16 Jul 2023 20:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537893;
        bh=ZrTO2D649V22guiTiFjgN8XIFXokbdp1orrBK6M/tvU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zb/+v1VCO8RCQ3RLusCnXZQ2rgUfY+4DubTytuPkQwVPbuNtUf/antLlII+4ztNsc
         RSOCy1c0VyfkloirdUVVDY9BxkwtwS0QOtU7GkIGFHJoi3X0OCSj94uIHqdOGLsk5O
         /JyZIwiRW1lYRFveKdeGwTDmLLhxPDEsAXWDEzw8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Robert Foss <rfoss@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 241/800] drm/bridge: tc358768: fix THS_ZEROCNT computation
Date:   Sun, 16 Jul 2023 21:41:34 +0200
Message-ID: <20230716194954.700009797@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Francesco Dolcini <francesco.dolcini@toradex.com>

[ Upstream commit 77a089328da791118af9692543a5eedc79eb5fd4 ]

Correct computation of THS_ZEROCNT register.

This register must be set to a value that ensure that
THS_PREPARE + THS_ZERO > 145ns + 10*UI

with the actual value of (THS_PREPARE + THS_ZERO) being

((1 to 2) + 1 + (TCLK_ZEROCNT + 1) + (3 to 4)) x ByteClk cycle +
  + HSByteClk x (2 + (1 to 2)) + (PHY delay)

with PHY delay being about

(8 + (5 to 6)) x MIPIBitClk cycle in the BitClk conversion.

Fixes: ff1ca6397b1d ("drm/bridge: Add tc358768 driver")
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Reviewed-by: Robert Foss <rfoss@kernel.org>
Signed-off-by: Robert Foss <rfoss@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20230427142934.55435-7-francesco@dolcini.it
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/tc358768.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/tc358768.c
index 4cb46a3e6be8c..e3f456bfb90c1 100644
--- a/drivers/gpu/drm/bridge/tc358768.c
+++ b/drivers/gpu/drm/bridge/tc358768.c
@@ -761,9 +761,10 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
 	/* 40ns + 4*UI < THS_PREPARE < 85ns + 6*UI */
 	val = 50 + tc358768_to_ns(4 * ui_nsk);
 	val = tc358768_ns_to_cnt(val, dsibclk_nsk) - 1;
-	/* THS_ZERO > 145ns + 10*UI */
-	val2 = tc358768_ns_to_cnt(145 - tc358768_to_ns(ui_nsk), dsibclk_nsk);
-	val |= (val2 - tc358768_to_ns(phy_delay_nsk)) << 8;
+	/* THS_PREPARE + THS_ZERO > 145ns + 10*UI */
+	raw_val = tc358768_ns_to_cnt(145 - tc358768_to_ns(3 * ui_nsk), dsibclk_nsk) - 10;
+	val2 = clamp(raw_val, 0, 127);
+	val |= val2 << 8;
 	dev_dbg(priv->dev, "THS_HEADERCNT: 0x%x\n", val);
 	tc358768_write(priv, TC358768_THS_HEADERCNT, val);
 
-- 
2.39.2



