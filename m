Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11C1279B968
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353810AbjIKV7Z (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241812AbjIKPPM (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:15:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40BA4FA
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:15:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86744C433C8;
        Mon, 11 Sep 2023 15:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694445307;
        bh=tWrv344rMd5hKSZ5byvwWtG9g/xzBss5S0GJcWfjevo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jv7ARtV7Lyf31OE98mesD39oYx+jreVzk33otODGS5RPFEesJFK8gvyN/961Ud7B4
         lmIsDvsAPRE4ObUWV7KA06faNtFT/2+nOkCEVYNbW4ib1VaJ5wvBd4tP62xF5I5ibN
         Zxb/BG84VdWWbnMSV60qLeRx3tpYokqG6ZNu4bQ0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        CK Hu <ck.hu@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 302/600] drm/mediatek: dp: Add missing error checks in mtk_dp_parse_capabilities
Date:   Mon, 11 Sep 2023 15:45:35 +0200
Message-ID: <20230911134642.528786085@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

[ Upstream commit cfc146137a9f12e883ba64bc496b6da4d23f26d5 ]

If reading the RX capabilities fails the training pattern will be set
wrongly: add error checking for drm_dp_read_dpcd_caps() and return if
anything went wrong with it.

While at it, also add a less critical error check when writing to
clear the ESI0 IRQ vector.

Fixes: f70ac097a2cf ("drm/mediatek: Add MT8195 Embedded DisplayPort driver")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
Link: https://patchwork.kernel.org/project/dri-devel/patch/20230725073234.55892-2-angelogioacchino.delregno@collabora.com/
Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/mediatek/mtk_dp.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
index 007af69e5026f..4c249939a6c3b 100644
--- a/drivers/gpu/drm/mediatek/mtk_dp.c
+++ b/drivers/gpu/drm/mediatek/mtk_dp.c
@@ -1588,7 +1588,9 @@ static int mtk_dp_parse_capabilities(struct mtk_dp *mtk_dp)
 	u8 val;
 	ssize_t ret;
 
-	drm_dp_read_dpcd_caps(&mtk_dp->aux, mtk_dp->rx_cap);
+	ret = drm_dp_read_dpcd_caps(&mtk_dp->aux, mtk_dp->rx_cap);
+	if (ret < 0)
+		return ret;
 
 	if (drm_dp_tps4_supported(mtk_dp->rx_cap))
 		mtk_dp->train_info.channel_eq_pattern = DP_TRAINING_PATTERN_4;
@@ -1615,10 +1617,13 @@ static int mtk_dp_parse_capabilities(struct mtk_dp *mtk_dp)
 			return ret == 0 ? -EIO : ret;
 		}
 
-		if (val)
-			drm_dp_dpcd_writeb(&mtk_dp->aux,
-					   DP_DEVICE_SERVICE_IRQ_VECTOR_ESI0,
-					   val);
+		if (val) {
+			ret = drm_dp_dpcd_writeb(&mtk_dp->aux,
+						 DP_DEVICE_SERVICE_IRQ_VECTOR_ESI0,
+						 val);
+			if (ret < 0)
+				return ret;
+		}
 	}
 
 	return 0;
-- 
2.40.1



