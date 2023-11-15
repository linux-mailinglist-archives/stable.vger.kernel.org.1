Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D38577ED4E7
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344703AbjKOU7e (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:59:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344799AbjKOU6I (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:58:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAAC41FD0
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:57:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2605C4AF70;
        Wed, 15 Nov 2023 20:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081406;
        bh=oiympBFyV5XAORQV+eYBcmZsjK6TZV1jYfpSuc6v2/4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q3BTgZcBckmMudlSm2hC9WHLywXvonT2qWGg/VhQfCd0H1ut5r1UmSNwB6ha0YH4a
         EO16fygoayUULY3vaMhIHt0A1GjlrShsninmQDVFbGEgeTxa40Ch4eG0w1qLBkLnUI
         lL+6HAo5+h1XeV1kC2kkBsGBuJYiul8ueIgeW8ss=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Michael Walle <mwalle@kernel.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 109/244] drm: mediatek: mtk_dsi: Fix NO_EOT_PACKET settings/handling
Date:   Wed, 15 Nov 2023 15:35:01 -0500
Message-ID: <20231115203554.886538311@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115203548.387164783@linuxfoundation.org>
References: <20231115203548.387164783@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

[ Upstream commit 5855d422a6f250f3518f43b49092c8e87a5e42be ]

Due to the initial confusion about MIPI_DSI_MODE_EOT_PACKET, properly
renamed to MIPI_DSI_MODE_NO_EOT_PACKET, reflecting its actual meaning,
both the DSI_TXRX_CON register setting for bit (HSTX_)DIS_EOT and the
later calculation for horizontal sync-active (HSA), back (HBP) and
front (HFP) porches got incorrect due to the logic being inverted.

This means that a number of settings were wrong because....:
 - DSI_TXRX_CON register setting: bit (HSTX_)DIS_EOT should be
   set in order to disable the End of Transmission packet;
 - Horizontal Sync and Back/Front porches: The delta used to
   calculate all of HSA, HBP and HFP should account for the
   additional EOT packet.

Before this change...
 - Bit (HSTX_)DIS_EOT was being set when EOT packet was enabled;
 - For HSA/HBP/HFP delta... all three were wrong, as words were
   added when EOT disabled, instead of when EOT packet enabled!

Invert the logic around flag MIPI_DSI_MODE_NO_EOT_PACKET in the
MediaTek DSI driver to fix the aforementioned issues.

Fixes: 8b2b99fd7931 ("drm/mediatek: dsi: Fine tune the line time caused by EOTp")
Fixes: c87d1c4b5b9a ("drm/mediatek: dsi: Use symbolized register definition")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
Tested-by: Michael Walle <mwalle@kernel.org>
Link: https://patchwork.kernel.org/project/dri-devel/patch/20230523104234.7849-1-angelogioacchino.delregno@collabora.com/
Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/mediatek/mtk_dsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index 98b1204c92906..57eaf111b6a8a 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -406,7 +406,7 @@ static void mtk_dsi_rxtx_control(struct mtk_dsi *dsi)
 	if (dsi->mode_flags & MIPI_DSI_CLOCK_NON_CONTINUOUS)
 		tmp_reg |= HSTX_CKLP_EN;
 
-	if (!(dsi->mode_flags & MIPI_DSI_MODE_NO_EOT_PACKET))
+	if (dsi->mode_flags & MIPI_DSI_MODE_NO_EOT_PACKET)
 		tmp_reg |= DIS_EOT;
 
 	writel(tmp_reg, dsi->regs + DSI_TXRX_CTRL);
@@ -483,7 +483,7 @@ static void mtk_dsi_config_vdo_timing(struct mtk_dsi *dsi)
 			  timing->da_hs_zero + timing->da_hs_exit + 3;
 
 	delta = dsi->mode_flags & MIPI_DSI_MODE_VIDEO_BURST ? 18 : 12;
-	delta += dsi->mode_flags & MIPI_DSI_MODE_NO_EOT_PACKET ? 2 : 0;
+	delta += dsi->mode_flags & MIPI_DSI_MODE_NO_EOT_PACKET ? 0 : 2;
 
 	horizontal_frontporch_byte = vm->hfront_porch * dsi_tmp_buf_bpp;
 	horizontal_front_back_byte = horizontal_frontporch_byte + horizontal_backporch_byte;
-- 
2.42.0



