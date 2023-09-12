Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB3479B6C2
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239600AbjIKVEY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239135AbjIKOMt (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:12:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8A1CE5
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:12:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FBA7C433C7;
        Mon, 11 Sep 2023 14:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441564;
        bh=3ZpmjhyBBuijtLxAb0Cdrxdj4uH7R4aOLc54QE88Ulw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cq5WrpCvgB4NZLPRnYxBbmp04E5CM+QB8jtKz8N2aoDBwEq32oXBBrMecKwrrQBJ/
         IRWDqHAHzURG2Y8ZwMNLmXbIQiWUgMOVwTkTwJ/INAQnUCcOq0K2cyqWtna/xxMmf+
         /gy+5l32Vwv0blwCALYtxELVk/13HOJCWs/lsGss=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jonas Karlman <jonas@kwiboo.se>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <jroedel@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 457/739] iommu: rockchip: Fix directory table address encoding
Date:   Mon, 11 Sep 2023 15:44:16 +0200
Message-ID: <20230911134703.918893817@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jonas Karlman <jonas@kwiboo.se>

[ Upstream commit 6df63b7ebdaf5fcd75dceedf6967d0761e56eca1 ]

The physical address to the directory table is currently encoded using
the following bit layout for IOMMU v2.

 31:12 - Address bit 31:0
 11: 4 - Address bit 39:32

This is also the bit layout used by the vendor kernel.

However, testing has shown that addresses to the directory/page tables
and memory pages are all encoded using the same bit layout.

IOMMU v1:
 31:12 - Address bit 31:0

IOMMU v2:
 31:12 - Address bit 31:0
 11: 8 - Address bit 35:32
  7: 4 - Address bit 39:36

Change to use the mk_dtentries ops to encode the directory table address
correctly. The value written to DTE_ADDR may include the valid bit set,
a bit that is ignored and DTE_ADDR reg read it back as 0.

This also update the bit layout comment for the page address and the
number of nybbles that are read back for DTE_ADDR comment.

These changes render the dte_addr_phys and dma_addr_dte ops unused and
is removed.

Fixes: 227014b33f62 ("iommu: rockchip: Add internal ops to handle variants")
Fixes: c55356c534aa ("iommu: rockchip: Add support for iommu v2")
Fixes: c987b65a574f ("iommu/rockchip: Fix physical address decoding")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Link: https://lore.kernel.org/r/20230617182540.3091374-2-jonas@kwiboo.se
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/rockchip-iommu.c | 43 ++++------------------------------
 1 file changed, 5 insertions(+), 38 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 4054030c32379..ae42959bc4905 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -98,8 +98,6 @@ struct rk_iommu_ops {
 	phys_addr_t (*pt_address)(u32 dte);
 	u32 (*mk_dtentries)(dma_addr_t pt_dma);
 	u32 (*mk_ptentries)(phys_addr_t page, int prot);
-	phys_addr_t (*dte_addr_phys)(u32 addr);
-	u32 (*dma_addr_dte)(dma_addr_t dt_dma);
 	u64 dma_bit_mask;
 };
 
@@ -278,8 +276,8 @@ static u32 rk_mk_pte(phys_addr_t page, int prot)
 /*
  * In v2:
  * 31:12 - Page address bit 31:0
- *  11:9 - Page address bit 34:32
- *   8:4 - Page address bit 39:35
+ * 11: 8 - Page address bit 35:32
+ *  7: 4 - Page address bit 39:36
  *     3 - Security
  *     2 - Writable
  *     1 - Readable
@@ -506,7 +504,7 @@ static int rk_iommu_force_reset(struct rk_iommu *iommu)
 
 	/*
 	 * Check if register DTE_ADDR is working by writing DTE_ADDR_DUMMY
-	 * and verifying that upper 5 nybbles are read back.
+	 * and verifying that upper 5 (v1) or 7 (v2) nybbles are read back.
 	 */
 	for (i = 0; i < iommu->num_mmu; i++) {
 		dte_addr = rk_ops->pt_address(DTE_ADDR_DUMMY);
@@ -531,33 +529,6 @@ static int rk_iommu_force_reset(struct rk_iommu *iommu)
 	return 0;
 }
 
-static inline phys_addr_t rk_dte_addr_phys(u32 addr)
-{
-	return (phys_addr_t)addr;
-}
-
-static inline u32 rk_dma_addr_dte(dma_addr_t dt_dma)
-{
-	return dt_dma;
-}
-
-#define DT_HI_MASK GENMASK_ULL(39, 32)
-#define DTE_BASE_HI_MASK GENMASK(11, 4)
-#define DT_SHIFT   28
-
-static inline phys_addr_t rk_dte_addr_phys_v2(u32 addr)
-{
-	u64 addr64 = addr;
-	return (phys_addr_t)(addr64 & RK_DTE_PT_ADDRESS_MASK) |
-	       ((addr64 & DTE_BASE_HI_MASK) << DT_SHIFT);
-}
-
-static inline u32 rk_dma_addr_dte_v2(dma_addr_t dt_dma)
-{
-	return (dt_dma & RK_DTE_PT_ADDRESS_MASK) |
-	       ((dt_dma & DT_HI_MASK) >> DT_SHIFT);
-}
-
 static void log_iova(struct rk_iommu *iommu, int index, dma_addr_t iova)
 {
 	void __iomem *base = iommu->bases[index];
@@ -577,7 +548,7 @@ static void log_iova(struct rk_iommu *iommu, int index, dma_addr_t iova)
 	page_offset = rk_iova_page_offset(iova);
 
 	mmu_dte_addr = rk_iommu_read(base, RK_MMU_DTE_ADDR);
-	mmu_dte_addr_phys = rk_ops->dte_addr_phys(mmu_dte_addr);
+	mmu_dte_addr_phys = rk_ops->pt_address(mmu_dte_addr);
 
 	dte_addr_phys = mmu_dte_addr_phys + (4 * dte_index);
 	dte_addr = phys_to_virt(dte_addr_phys);
@@ -967,7 +938,7 @@ static int rk_iommu_enable(struct rk_iommu *iommu)
 
 	for (i = 0; i < iommu->num_mmu; i++) {
 		rk_iommu_write(iommu->bases[i], RK_MMU_DTE_ADDR,
-			       rk_ops->dma_addr_dte(rk_domain->dt_dma));
+			       rk_ops->mk_dtentries(rk_domain->dt_dma));
 		rk_iommu_base_command(iommu->bases[i], RK_MMU_CMD_ZAP_CACHE);
 		rk_iommu_write(iommu->bases[i], RK_MMU_INT_MASK, RK_MMU_IRQ_MASK);
 	}
@@ -1405,8 +1376,6 @@ static struct rk_iommu_ops iommu_data_ops_v1 = {
 	.pt_address = &rk_dte_pt_address,
 	.mk_dtentries = &rk_mk_dte,
 	.mk_ptentries = &rk_mk_pte,
-	.dte_addr_phys = &rk_dte_addr_phys,
-	.dma_addr_dte = &rk_dma_addr_dte,
 	.dma_bit_mask = DMA_BIT_MASK(32),
 };
 
@@ -1414,8 +1383,6 @@ static struct rk_iommu_ops iommu_data_ops_v2 = {
 	.pt_address = &rk_dte_pt_address_v2,
 	.mk_dtentries = &rk_mk_dte_v2,
 	.mk_ptentries = &rk_mk_pte_v2,
-	.dte_addr_phys = &rk_dte_addr_phys_v2,
-	.dma_addr_dte = &rk_dma_addr_dte_v2,
 	.dma_bit_mask = DMA_BIT_MASK(40),
 };
 
-- 
2.40.1



