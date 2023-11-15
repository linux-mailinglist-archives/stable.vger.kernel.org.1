Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6052A7ECC24
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233523AbjKOT1M (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:27:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233790AbjKOT1A (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:27:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170FED4E
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:26:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27EA9C433C9;
        Wed, 15 Nov 2023 19:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076416;
        bh=6QEKGr/u2/DZ4e4CgM6QBXX4sQeSZBm1FDRSiRUxeWw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l3V6Uv6LQZFyegeKhu6zb66WVcGseigTfXTBmt3incAp4IYCmEdcX9LYbhyKdQ2e7
         d9kQ/5ls6k8XXEhJeDzlYdxfpB+kHt5thYAdorxaozA7pEltAg9wGohFu6Y/irivBr
         gvwUjs3QdgG/qye/tdmPw9/d+SH3mGFcDZPwe+WY=
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
Subject: [PATCH 6.5 254/550] drm: mediatek: mtk_dsi: Fix NO_EOT_PACKET settings/handling
Date:   Wed, 15 Nov 2023 14:13:58 -0500
Message-ID: <20231115191618.297931122@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

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
index 7d52503511936..b0ab38e59db9d 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -407,7 +407,7 @@ static void mtk_dsi_rxtx_control(struct mtk_dsi *dsi)
 	if (dsi->mode_flags & MIPI_DSI_CLOCK_NON_CONTINUOUS)
 		tmp_reg |= HSTX_CKLP_EN;
 
-	if (!(dsi->mode_flags & MIPI_DSI_MODE_NO_EOT_PACKET))
+	if (dsi->mode_flags & MIPI_DSI_MODE_NO_EOT_PACKET)
 		tmp_reg |= DIS_EOT;
 
 	writel(tmp_reg, dsi->regs + DSI_TXRX_CTRL);
@@ -484,7 +484,7 @@ static void mtk_dsi_config_vdo_timing(struct mtk_dsi *dsi)
 			  timing->da_hs_zero + timing->da_hs_exit + 3;
 
 	delta = dsi->mode_flags & MIPI_DSI_MODE_VIDEO_BURST ? 18 : 12;
-	delta += dsi->mode_flags & MIPI_DSI_MODE_NO_EOT_PACKET ? 2 : 0;
+	delta += dsi->mode_flags & MIPI_DSI_MODE_NO_EOT_PACKET ? 0 : 2;
 
 	horizontal_frontporch_byte = vm->hfront_porch * dsi_tmp_buf_bpp;
 	horizontal_front_back_byte = horizontal_frontporch_byte + horizontal_backporch_byte;
-- 
2.42.0



