Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D5370C6B2
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234397AbjEVTVT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234385AbjEVTVS (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:21:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FDCDB0
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:21:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA5846282E
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:21:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4B05C433D2;
        Mon, 22 May 2023 19:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684783276;
        bh=GqYE8LeO2/beEwf+zfxz+xF/giPjMCFcZiHdFtPJg9g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WZNsMR1rXO5FA84PgCNtHdpF6zMfbW9BZNR8Su+6iJvTtlZXVNctjVGK1io7hYpUN
         38D6pI0ArM4kQjtXtcv1UuyQk5L0TJpyiF1zy0NAUQGVkxPz8tsSJfw4SLTR2iAEYc
         ByzDfVpPuKG1qmQBY8D5RmwKXlQy0t3MB6G0VX4s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Gaurav Batra <gbatra@linux.vnet.ibm.com>,
        Brian King <brking@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 5.15 196/203] powerpc/iommu: Incorrect DDW Table is referenced for SR-IOV device
Date:   Mon, 22 May 2023 20:10:20 +0100
Message-Id: <20230522190400.459785412@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190354.935300867@linuxfoundation.org>
References: <20230522190354.935300867@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Gaurav Batra <gbatra@linux.vnet.ibm.com>

commit 1f7aacc5eb9ed2cc17be7a90da5cd559effb9d59 upstream.

For an SR-IOV device, while enabling DDW, a new table is created and
added at index 1 in the group. In the below 2 scenarios, the table is
incorrectly referenced at index 0 (which is where the table is for
default DMA window).

1. When adding DDW

   This issue is exposed with "slub_debug". Error thrown out from
   dma_iommu_dma_supported()

   Warning: IOMMU offset too big for device mask
   mask: 0xffffffff, table offset: 0x800000000000000

2. During Dynamic removal of the PCI device.

   Error is from iommu_tce_table_put() since a NULL table pointer is
   passed in.

Fixes: 381ceda88c4c ("powerpc/pseries/iommu: Make use of DDW for indirect mapping")
Cc: stable@vger.kernel.org # v5.15+
Signed-off-by: Gaurav Batra <gbatra@linux.vnet.ibm.com>
Reviewed-by: Brian King <brking@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20230505184701.91613-1-gbatra@linux.vnet.ibm.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/kernel/dma-iommu.c        |    4 +++-
 arch/powerpc/platforms/pseries/iommu.c |   13 +++++++++----
 2 files changed, 12 insertions(+), 5 deletions(-)

--- a/arch/powerpc/kernel/dma-iommu.c
+++ b/arch/powerpc/kernel/dma-iommu.c
@@ -144,7 +144,7 @@ static bool dma_iommu_bypass_supported(s
 /* We support DMA to/from any memory page via the iommu */
 int dma_iommu_dma_supported(struct device *dev, u64 mask)
 {
-	struct iommu_table *tbl = get_iommu_table_base(dev);
+	struct iommu_table *tbl;
 
 	if (dev_is_pci(dev) && dma_iommu_bypass_supported(dev, mask)) {
 		/*
@@ -162,6 +162,8 @@ int dma_iommu_dma_supported(struct devic
 		return 1;
 	}
 
+	tbl = get_iommu_table_base(dev);
+
 	if (!tbl) {
 		dev_err(dev, "Warning: IOMMU dma not supported: mask 0x%08llx, table unavailable\n", mask);
 		return 0;
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -85,19 +85,24 @@ static struct iommu_table_group *iommu_p
 static void iommu_pseries_free_group(struct iommu_table_group *table_group,
 		const char *node_name)
 {
-	struct iommu_table *tbl;
-
 	if (!table_group)
 		return;
 
-	tbl = table_group->tables[0];
 #ifdef CONFIG_IOMMU_API
 	if (table_group->group) {
 		iommu_group_put(table_group->group);
 		BUG_ON(table_group->group);
 	}
 #endif
-	iommu_tce_table_put(tbl);
+
+	/* Default DMA window table is at index 0, while DDW at 1. SR-IOV
+	 * adapters only have table on index 1.
+	 */
+	if (table_group->tables[0])
+		iommu_tce_table_put(table_group->tables[0]);
+
+	if (table_group->tables[1])
+		iommu_tce_table_put(table_group->tables[1]);
 
 	kfree(table_group);
 }


