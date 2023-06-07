Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71822726B77
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233207AbjFGUZf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233251AbjFGUZa (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:25:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F8026BA
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:25:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4F5464419
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:25:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D48BAC4339C;
        Wed,  7 Jun 2023 20:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169501;
        bh=NQKC4SN9UM8KchLda/8RBvpPfihMAde48nkwj0DacwU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SOSYHVQ+QtrSiufc/JC6CvU9lQASIPc38AsHpppXyJizijVT9ftypWAZVXtwrXqV1
         iNgvroKBsNFoU+FU6N7oqDLgbhNHxTU9AYW09SKebtylA/q0lIrsX9yJD/acX546yO
         Lg6esKTwb7W/cmxs9fY7SNYwYNE8vaTl5cN2eQDo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chen-Yu Tsai <wenst@chromium.org>,
        Yong Wu <yong.wu@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Joerg Roedel <jroedel@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 065/286] iommu/mediatek: Flush IOTLB completely only if domain has been attached
Date:   Wed,  7 Jun 2023 22:12:44 +0200
Message-ID: <20230607200925.190540763@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200922.978677727@linuxfoundation.org>
References: <20230607200922.978677727@linuxfoundation.org>
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

From: Chen-Yu Tsai <wenst@chromium.org>

[ Upstream commit b3fc95709c54ffbe80f16801e0a792a4d2b3d55e ]

If an IOMMU domain was never attached, it lacks any linkage to the
actual IOMMU hardware. Attempting to do flush_iotlb_all() on it will
result in a NULL pointer dereference. This seems to happen after the
recent IOMMU core rework in v6.4-rc1.

    Unable to handle kernel read from unreadable memory at virtual address 0000000000000018
    Call trace:
     mtk_iommu_flush_iotlb_all+0x20/0x80
     iommu_create_device_direct_mappings.part.0+0x13c/0x230
     iommu_setup_default_domain+0x29c/0x4d0
     iommu_probe_device+0x12c/0x190
     of_iommu_configure+0x140/0x208
     of_dma_configure_id+0x19c/0x3c0
     platform_dma_configure+0x38/0x88
     really_probe+0x78/0x2c0

Check if the "bank" field has been filled in before actually attempting
the IOTLB flush to avoid it. The IOTLB is also flushed when the device
comes out of runtime suspend, so it should have a clean initial state.

Fixes: 08500c43d4f7 ("iommu/mediatek: Adjust the structure")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://lore.kernel.org/r/20230526085402.394239-1-wenst@chromium.org
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/mtk_iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 6a00ce208dc2b..248b8c2bc4071 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -738,7 +738,8 @@ static void mtk_iommu_flush_iotlb_all(struct iommu_domain *domain)
 {
 	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
 
-	mtk_iommu_tlb_flush_all(dom->bank->parent_data);
+	if (dom->bank)
+		mtk_iommu_tlb_flush_all(dom->bank->parent_data);
 }
 
 static void mtk_iommu_iotlb_sync(struct iommu_domain *domain,
-- 
2.39.2



