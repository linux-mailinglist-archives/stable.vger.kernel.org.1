Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 477B179B8A4
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359588AbjIKWSC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241816AbjIKPPS (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:15:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDE7FA
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:15:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DC47C433C7;
        Mon, 11 Sep 2023 15:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694445313;
        bh=L8raixZjgo4XDuaf0pfw9J87nYP3WdTBsqgZdIGJW/E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2K5784qj1CDuIggsLBve7R/vEb3G2WZKEA/siQR1UlIxA4BmRikuVH/jr5XhRDKBi
         aJZI4fEurc3pH6AL+n/ThQyGvsH/pzMB6zWG5AJV0RfMd3sZZv0OrBis7V6DQdmzKo
         Q0vnsvhgwLhxnHFTvYYjgrkALzgcRSyaqegImMrs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        CK Hu <ck.hu@mediatek.com>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 304/600] drm/mediatek: Remove freeing not dynamic allocated memory
Date:   Mon, 11 Sep 2023 15:45:37 +0200
Message-ID: <20230911134642.595283901@linuxfoundation.org>
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

From: Jason-JH.Lin <jason-jh.lin@mediatek.com>

[ Upstream commit 27b9e2ea3f2757da26bb8280e46f7fdbb1acb219 ]

Fixing the coverity issue of:
mtk_drm_cmdq_pkt_destroy frees address of mtk_crtc->cmdq_handle

So remove the free function.

Fixes: 7627122fd1c0 ("drm/mediatek: Add cmdq_handle in mtk_crtc")
Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
Link: https://patchwork.kernel.org/project/dri-devel/patch/20230714094908.13087-2-jason-jh.lin@mediatek.com/
Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
index 5071f1263216b..14ddfe3a6be77 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
@@ -115,10 +115,9 @@ static int mtk_drm_cmdq_pkt_create(struct cmdq_client *client, struct cmdq_pkt *
 	dma_addr_t dma_addr;
 
 	pkt->va_base = kzalloc(size, GFP_KERNEL);
-	if (!pkt->va_base) {
-		kfree(pkt);
+	if (!pkt->va_base)
 		return -ENOMEM;
-	}
+
 	pkt->buf_size = size;
 	pkt->cl = (void *)client;
 
@@ -128,7 +127,6 @@ static int mtk_drm_cmdq_pkt_create(struct cmdq_client *client, struct cmdq_pkt *
 	if (dma_mapping_error(dev, dma_addr)) {
 		dev_err(dev, "dma map failed, size=%u\n", (u32)(u64)size);
 		kfree(pkt->va_base);
-		kfree(pkt);
 		return -ENOMEM;
 	}
 
@@ -144,7 +142,6 @@ static void mtk_drm_cmdq_pkt_destroy(struct cmdq_pkt *pkt)
 	dma_unmap_single(client->chan->mbox->dev, pkt->pa_base, pkt->buf_size,
 			 DMA_TO_DEVICE);
 	kfree(pkt->va_base);
-	kfree(pkt);
 }
 #endif
 
-- 
2.40.1



