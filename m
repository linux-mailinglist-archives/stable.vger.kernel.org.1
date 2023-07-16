Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B96F075521A
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbjGPUDz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbjGPUDw (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:03:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93BF3E5B
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:03:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1DFA060EAA
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:03:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CE39C433C8;
        Sun, 16 Jul 2023 20:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537829;
        bh=6qyyaegGkGWE6V1kul3bPPP8WAjdXDUHG4mlW82KDw4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wh1gYUcd7bYq4flBAjXPQrfWbiOJ6fHgcBPU3DYJK36caLX8rwOgr0qUk3kHwNH7F
         UvX4f4yjxD2a3RLxNYWIPTQJefcs0VSedmHVmayaBQ1Jtc+9ImbI8uo+FIx9Q6+j/l
         ABE2DaqeaJYZYA3et5wVlVMJ9R1i6PQchvOJqWX4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Robert Foss <rfoss@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 235/800] drm/bridge: tc358768: always enable HS video mode
Date:   Sun, 16 Jul 2023 21:41:28 +0200
Message-ID: <20230716194954.547954435@linuxfoundation.org>
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

[ Upstream commit 75a8aeac2573ab258c53676eba9b3796ea691988 ]

Always enable HS video mode setting the TXMD bit, without this change no
video output is present with DSI sinks that are setting
MIPI_DSI_MODE_LPM flag (tested with LT8912B DSI-HDMI bridge).

Previously the driver was enabling HS mode only when the DSI sink was
not explicitly setting the MIPI_DSI_MODE_LPM, however this is not
correct.

The MIPI_DSI_MODE_LPM is supposed to indicate that the sink is willing
to receive data in low power mode, however clearing the
TC358768_DSI_CONTROL_TXMD bit will make the TC358768 send video in
LP mode that is not the intended behavior.

Fixes: ff1ca6397b1d ("drm/bridge: Add tc358768 driver")
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Reviewed-by: Robert Foss <rfoss@kernel.org>
Signed-off-by: Robert Foss <rfoss@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20230427142934.55435-2-francesco@dolcini.it
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/tc358768.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/tc358768.c
index 7c0cbe84611b9..8f349bf4fc32f 100644
--- a/drivers/gpu/drm/bridge/tc358768.c
+++ b/drivers/gpu/drm/bridge/tc358768.c
@@ -866,8 +866,7 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
 	val = TC358768_DSI_CONFW_MODE_SET | TC358768_DSI_CONFW_ADDR_DSI_CONTROL;
 	val |= (dsi_dev->lanes - 1) << 1;
 
-	if (!(dsi_dev->mode_flags & MIPI_DSI_MODE_LPM))
-		val |= TC358768_DSI_CONTROL_TXMD;
+	val |= TC358768_DSI_CONTROL_TXMD;
 
 	if (!(mode_flags & MIPI_DSI_CLOCK_NON_CONTINUOUS))
 		val |= TC358768_DSI_CONTROL_HSCKMD;
-- 
2.39.2



