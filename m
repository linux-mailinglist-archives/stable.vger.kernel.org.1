Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B09D75D239
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 20:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbjGUS5Z (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 14:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbjGUS5S (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 14:57:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC8A359D
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 11:57:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 964CB61D82
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 18:57:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7AD0C433C8;
        Fri, 21 Jul 2023 18:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689965828;
        bh=jmcsLx1QGCAPTBwRlTQxpVNUSD5hgI7ORPj2oXnEBXY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HQkjpflnQQjewQtK2/MyFMitgFMjP8bciaCrRn3a8EgO4twTVOFS+0Q4uBr7g+DK9
         DUNaC54jER4fZz/sAc6TZOzef75NWMUaRekUBqVbSEH/M/j60glVICWUhxtFcFCGjS
         KWvf45fRZOEKDz+vYm5YWUf7MV4ya2FVeuAC5H7Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Robert Foss <rfoss@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 101/532] drm/bridge: tc358768: fix PLL target frequency
Date:   Fri, 21 Jul 2023 18:00:05 +0200
Message-ID: <20230721160620.051468065@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Francesco Dolcini <francesco.dolcini@toradex.com>

[ Upstream commit ffd2e4bbea626d565b9817312b0fcfb382fecb88 ]

Correctly compute the PLL target frequency, the current formula works
correctly only when the input bus width is 24bit, actually to properly
compute the PLL target frequency what is relevant is the bits-per-pixel
on the DSI link.

No regression expected since the DSI format is currently hard-coded as
MIPI_DSI_FMT_RGB888.

Fixes: ff1ca6397b1d ("drm/bridge: Add tc358768 driver")
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Reviewed-by: Robert Foss <rfoss@kernel.org>
Signed-off-by: Robert Foss <rfoss@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20230427142934.55435-4-francesco@dolcini.it
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/tc358768.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/tc358768.c
index e09e007a2749c..e302310d4acec 100644
--- a/drivers/gpu/drm/bridge/tc358768.c
+++ b/drivers/gpu/drm/bridge/tc358768.c
@@ -147,6 +147,7 @@ struct tc358768_priv {
 
 	u32 pd_lines; /* number of Parallel Port Input Data Lines */
 	u32 dsi_lanes; /* number of DSI Lanes */
+	u32 dsi_bpp; /* number of Bits Per Pixel over DSI */
 
 	/* Parameters for PLL programming */
 	u32 fbd;	/* PLL feedback divider */
@@ -279,12 +280,12 @@ static void tc358768_hw_disable(struct tc358768_priv *priv)
 
 static u32 tc358768_pll_to_pclk(struct tc358768_priv *priv, u32 pll_clk)
 {
-	return (u32)div_u64((u64)pll_clk * priv->dsi_lanes, priv->pd_lines);
+	return (u32)div_u64((u64)pll_clk * priv->dsi_lanes, priv->dsi_bpp);
 }
 
 static u32 tc358768_pclk_to_pll(struct tc358768_priv *priv, u32 pclk)
 {
-	return (u32)div_u64((u64)pclk * priv->pd_lines, priv->dsi_lanes);
+	return (u32)div_u64((u64)pclk * priv->dsi_bpp, priv->dsi_lanes);
 }
 
 static int tc358768_calc_pll(struct tc358768_priv *priv,
@@ -421,6 +422,7 @@ static int tc358768_dsi_host_attach(struct mipi_dsi_host *host,
 	priv->output.panel = panel;
 
 	priv->dsi_lanes = dev->lanes;
+	priv->dsi_bpp = mipi_dsi_pixel_format_to_bpp(dev->format);
 
 	/* get input ep (port0/endpoint0) */
 	ret = -EINVAL;
@@ -432,7 +434,7 @@ static int tc358768_dsi_host_attach(struct mipi_dsi_host *host,
 	}
 
 	if (ret)
-		priv->pd_lines = mipi_dsi_pixel_format_to_bpp(dev->format);
+		priv->pd_lines = priv->dsi_bpp;
 
 	drm_bridge_add(&priv->bridge);
 
-- 
2.39.2



