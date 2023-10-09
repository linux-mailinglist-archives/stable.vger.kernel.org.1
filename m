Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B297BDDB7
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376775AbjJINMr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376957AbjJINM0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:12:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 892741FE2
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:11:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93FB7C433D9;
        Mon,  9 Oct 2023 13:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857078;
        bh=O5upez4N4J6gxSxg4GbVls9i5WeEPA1cCNZoDlWx/5k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j2Vw2x48Es/qC4ODLPRadNJA9sz0d4Eh4yZUeuxP95P0+C/qTtKQlhWN0A+ubWffS
         DmSWI+Zk6NqJ+xEpyQUUgVDXA2DwbQq6i2Lc+Bb+Riq/MGmiMClQAz4zrl/uXJ8nDE
         uSeNDejwRIhZsKvakc9nzRJoLz13ZerM3/kW3emE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Laura Nao <laura.nao@collabora.com>,
        Yong Wu <yong.wu@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Joerg Roedel <jroedel@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 088/163] iommu/mediatek: Fix share pgtable for iova over 4GB
Date:   Mon,  9 Oct 2023 15:00:52 +0200
Message-ID: <20231009130126.469833117@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130124.021290599@linuxfoundation.org>
References: <20231009130124.021290599@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yong Wu <yong.wu@mediatek.com>

[ Upstream commit b07eba71a512eb196cbcc29765c29c8c29b11b59 ]

In mt8192/mt8186, there is only one MM IOMMU that supports 16GB iova
space, which is shared by display, vcodec and camera. These two SoC use
one pgtable and have not the flag SHARE_PGTABLE, we should also keep
share pgtable for this case.

In mtk_iommu_domain_finalise, MM IOMMU always share pgtable, thus remove
the flag SHARE_PGTABLE checking. Infra IOMMU always uses independent
pgtable.

Fixes: cf69ef46dbd9 ("iommu/mediatek: Fix two IOMMU share pagetable issue")
Reported-by: Laura Nao <laura.nao@collabora.com>
Closes: https://lore.kernel.org/linux-iommu/20230818154156.314742-1-laura.nao@collabora.com/
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: Laura Nao <laura.nao@collabora.com>
Link: https://lore.kernel.org/r/20230819081443.8333-1-yong.wu@mediatek.com
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/mtk_iommu.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index c2764891a779c..ef27f9f1e17ef 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -258,7 +258,7 @@ struct mtk_iommu_data {
 	struct device			*smicomm_dev;
 
 	struct mtk_iommu_bank_data	*bank;
-	struct mtk_iommu_domain		*share_dom; /* For 2 HWs share pgtable */
+	struct mtk_iommu_domain		*share_dom;
 
 	struct regmap			*pericfg;
 	struct mutex			mutex; /* Protect m4u_group/m4u_dom above */
@@ -625,8 +625,8 @@ static int mtk_iommu_domain_finalise(struct mtk_iommu_domain *dom,
 	struct mtk_iommu_domain	*share_dom = data->share_dom;
 	const struct mtk_iommu_iova_region *region;
 
-	/* Always use share domain in sharing pgtable case */
-	if (MTK_IOMMU_HAS_FLAG(data->plat_data, SHARE_PGTABLE) && share_dom) {
+	/* Share pgtable when 2 MM IOMMU share the pgtable or one IOMMU use multiple iova ranges */
+	if (share_dom) {
 		dom->iop = share_dom->iop;
 		dom->cfg = share_dom->cfg;
 		dom->domain.pgsize_bitmap = share_dom->cfg.pgsize_bitmap;
@@ -659,8 +659,7 @@ static int mtk_iommu_domain_finalise(struct mtk_iommu_domain *dom,
 	/* Update our support page sizes bitmap */
 	dom->domain.pgsize_bitmap = dom->cfg.pgsize_bitmap;
 
-	if (MTK_IOMMU_HAS_FLAG(data->plat_data, SHARE_PGTABLE))
-		data->share_dom = dom;
+	data->share_dom = dom;
 
 update_iova_region:
 	/* Update the iova region for this domain */
-- 
2.40.1



