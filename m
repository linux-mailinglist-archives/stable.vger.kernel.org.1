Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D11755518
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbjGPUhU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232374AbjGPUhT (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:37:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F31103
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:37:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5335860EB0
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:37:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AE75C433C8;
        Sun, 16 Jul 2023 20:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539837;
        bh=6sI+5E3Tr18K6pGRWCmu0t2jg4B2ooFw+4mx2O9h4cc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nY+iRqtEAZveA9h0cSbcwFvC/APOeq0LUWl9GSB6jD/2I+aJmmpyXVaMnZa+ipwPm
         XplacHGXfRU9PWKoVH3k6nyF+XqmUbBR3g6UPtLfQkWS3dJgQsReIbb19sPy1/sw+K
         Bts+C8698BYe9AYn5chO8WeEvkZ4OXFJPwmZ2ss8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Robert Foss <rfoss@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 150/591] drm/bridge: tc358768: fix TCLK_ZEROCNT computation
Date:   Sun, 16 Jul 2023 21:44:49 +0200
Message-ID: <20230716194927.746929027@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
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

[ Upstream commit f9cf811374f42fca31ac34aaf59ee2ae72b89879 ]

Correct computation of TCLK_ZEROCNT register.

This register must be set to a value that ensure that
(TCLK-PREPARECNT + TCLK-ZERO) > 300ns

with the actual value of (TCLK-PREPARECNT + TCLK-ZERO) being

(1 to 2) + (TCLK_ZEROCNT + 1)) x HSByteClkCycle + (PHY output delay)

with PHY output delay being about

(2 to 3) x MIPIBitClk cycle in the BitClk conversion.

Fixes: ff1ca6397b1d ("drm/bridge: Add tc358768 driver")
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Reviewed-by: Robert Foss <rfoss@kernel.org>
Signed-off-by: Robert Foss <rfoss@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20230427142934.55435-5-francesco@dolcini.it
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/tc358768.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/tc358768.c
index 9bc726b79dd57..765bdebbd06f9 100644
--- a/drivers/gpu/drm/bridge/tc358768.c
+++ b/drivers/gpu/drm/bridge/tc358768.c
@@ -743,10 +743,10 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
 
 	/* 38ns < TCLK_PREPARE < 95ns */
 	val = tc358768_ns_to_cnt(65, dsibclk_nsk) - 1;
-	/* TCLK_PREPARE > 300ns */
-	val2 = tc358768_ns_to_cnt(300 + tc358768_to_ns(3 * ui_nsk),
-				  dsibclk_nsk);
-	val |= (val2 - tc358768_to_ns(phy_delay_nsk - dsibclk_nsk)) << 8;
+	/* TCLK_PREPARE + TCLK_ZERO > 300ns */
+	val2 = tc358768_ns_to_cnt(300 - tc358768_to_ns(2 * ui_nsk),
+				  dsibclk_nsk) - 2;
+	val |= val2 << 8;
 	dev_dbg(priv->dev, "TCLK_HEADERCNT: 0x%x\n", val);
 	tc358768_write(priv, TC358768_TCLK_HEADERCNT, val);
 
-- 
2.39.2



