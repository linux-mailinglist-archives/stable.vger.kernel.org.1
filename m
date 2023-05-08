Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9EEE6FAC5D
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233970AbjEHLXj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235638AbjEHLXi (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:23:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E2239194
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:23:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE1B362D0A
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:23:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7EA2C433EF;
        Mon,  8 May 2023 11:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683545014;
        bh=pZVt+N6axvmewFN3GR7/rsEHSCtBpr4N01uaJxT+KeA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cAmHvMcUd4l0jIxPiTmahV+CRHMPqJu5jbhxPW/LoZ0nx6BGaRFAoVZ/xv7JSJv1z
         /UQVwE4y0zr3XAiKcu/JXPY6BSJKzIt5Owpoaw+l6wsg+j6BsjFx0U1f4aTiwqeN23
         ++0KlqqGNlhii9c1vIrxjOGkpGEQLJ2hH4qxlkIc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, "Chengci.Xu" <chengci.xu@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Joerg Roedel <jroedel@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 596/694] iommu/mediatek: Set dma_mask for PGTABLE_PA_35_EN
Date:   Mon,  8 May 2023 11:47:11 +0200
Message-Id: <20230508094454.501499511@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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

From: Yong Wu <yong.wu@mediatek.com>

[ Upstream commit f045e9df6537175d02565f21616ac1a9dd59b61c ]

When we enable PGTABLE_PA_35_EN, the PA for pgtable may be 35bits.
Thus add dma_mask for it.

Fixes: 301c3ca12576 ("iommu/mediatek: Allow page table PA up to 35bit")
Signed-off-by: Chengci.Xu <chengci.xu@mediatek.com>
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://lore.kernel.org/r/20230316101445.12443-1-yong.wu@mediatek.com
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/mtk_iommu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index d5a4955910ff5..6a00ce208dc2b 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -1258,6 +1258,14 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 			return PTR_ERR(data->bclk);
 	}
 
+	if (MTK_IOMMU_HAS_FLAG(data->plat_data, PGTABLE_PA_35_EN)) {
+		ret = dma_set_mask(dev, DMA_BIT_MASK(35));
+		if (ret) {
+			dev_err(dev, "Failed to set dma_mask 35.\n");
+			return ret;
+		}
+	}
+
 	pm_runtime_enable(dev);
 
 	if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_MM)) {
-- 
2.39.2



