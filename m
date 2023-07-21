Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF8975D240
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 20:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbjGUS5x (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 14:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbjGUS5s (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 14:57:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4BD63C06
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 11:57:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29C1961D84
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 18:57:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B778C433C8;
        Fri, 21 Jul 2023 18:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689965847;
        bh=fHDODbcfyNgIg6RebuAaesGkZuSAi3NzOlRE61p1Vq4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TQV2rlN3uMPHhbli8M+U+C0+4kBWgizckM1q7a6MHG7/naz/O+wSDnrvYCNLKbkib
         Sx5h4gz39H6FAAhWjgD0SEJuZ9JRxRyvstF4qKk9x52jhl4TaUd1oBzB3qxEie7Xao
         OIEYxpuZyECKPYI2x1ybGqYpFerye8l/EmRylc6U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Robert Foss <rfoss@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 107/532] drm/bridge: tc358768: fix THS_TRAILCNT computation
Date:   Fri, 21 Jul 2023 18:00:11 +0200
Message-ID: <20230721160620.379133634@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Francesco Dolcini <francesco.dolcini@toradex.com>

[ Upstream commit bac7842cd179572e8e0fc2d7b5254e40c6e9e057 ]

Correct computation of THS_TRAILCNT register.

This register must be set to a value that ensure that
THS_TRAIL > 60 ns + 4 x UI
 and
THS_TRAIL > 8 x UI
 and
THS_TRAIL < TEOT
 with
TEOT = 105 ns + (12 x UI)

with the actual value of THS_TRAIL being

(1 + THS_TRAILCNT) x ByteClk cycle + ((1 to 2) + 2) xHSBYTECLK cycle +
 - (PHY output delay)

with PHY output delay being about

(8 + (5 to 6)) x MIPIBitClk cycle in the BitClk conversion.

Fixes: ff1ca6397b1d ("drm/bridge: Add tc358768 driver")
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Reviewed-by: Robert Foss <rfoss@kernel.org>
Signed-off-by: Robert Foss <rfoss@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20230427142934.55435-9-francesco@dolcini.it
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/tc358768.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/tc358768.c
index c9c2e15c6f4a2..8b1bdffc5005d 100644
--- a/drivers/gpu/drm/bridge/tc358768.c
+++ b/drivers/gpu/drm/bridge/tc358768.c
@@ -763,9 +763,10 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
 	dev_dbg(priv->dev, "TCLK_POSTCNT: 0x%x\n", val);
 	tc358768_write(priv, TC358768_TCLK_POSTCNT, val);
 
-	/* 60ns + 4*UI < THS_PREPARE < 105ns + 12*UI */
-	val = tc358768_ns_to_cnt(60 + tc358768_to_ns(15 * ui_nsk),
-				 dsibclk_nsk) - 5;
+	/* max(60ns + 4*UI, 8*UI) < THS_TRAILCNT < 105ns + 12*UI */
+	raw_val = tc358768_ns_to_cnt(60 + tc358768_to_ns(18 * ui_nsk),
+				     dsibclk_nsk) - 4;
+	val = clamp(raw_val, 0, 15);
 	dev_dbg(priv->dev, "THS_TRAILCNT: 0x%x\n", val);
 	tc358768_write(priv, TC358768_THS_TRAILCNT, val);
 
-- 
2.39.2



