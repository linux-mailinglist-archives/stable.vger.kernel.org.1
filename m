Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8566E74C2BF
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbjGILYP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbjGILYP (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:24:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325FA186
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:24:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCFA760BD6
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:24:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAFD9C433C8;
        Sun,  9 Jul 2023 11:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688901853;
        bh=6qyyaegGkGWE6V1kul3bPPP8WAjdXDUHG4mlW82KDw4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MA1mF8O7KA/t+Y6/d9hGCq+d0bRc03YseaXeaH+lJVixOPQFmWRTTF1vodaOmoNic
         mq/2bhSHJr4atfFxL4shUHHNhqAUUgbIREp2YrZKEtiPHraCqCRYtRKnHwCVq4DxqQ
         sQs4hPpNyuN9Djt67fbct6wsjbnV55fnMHYCaMWs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Robert Foss <rfoss@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 168/431] drm/bridge: tc358768: always enable HS video mode
Date:   Sun,  9 Jul 2023 13:11:56 +0200
Message-ID: <20230709111455.111273603@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
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



