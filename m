Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D53D17B88C6
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233840AbjJDSTY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233867AbjJDSTX (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:19:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D41BD7
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:19:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 512AAC433CD;
        Wed,  4 Oct 2023 18:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443559;
        bh=ZDTKGticWc3y6XrZC3qNqITGVf8DAOzA3IC5e+pMQnI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zL97vv2M+QD0Q3CpppAJqsx6HUZI0+6IDIrhl2NMFGjQ+SX9h/6XdHqC80yiF1Zfv
         XqRFQSwNc9C7LIOAnkUdq56ZVijBBQePmmuSYVV6VXZEtBNBbMvyWlR4iYTBdGD8fn
         +8RZmur9HZms/BBxlGSGUl94vIb1J6ejTIQvLieY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 200/259] nvme-pci: factor the iod mempool creation into a helper
Date:   Wed,  4 Oct 2023 19:56:13 +0200
Message-ID: <20231004175226.458499850@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175217.404851126@linuxfoundation.org>
References: <20231004175217.404851126@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 081a7d958ce4b65f9aab6e70e65b0b2e0b92297c ]

Add a helper to create the iod mempool.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Tested-by Gerd Bayer <gbayer@linxu.ibm.com>
Stable-dep-of: dad651b2a44e ("nvme-pci: do not set the NUMA node of device if it has none")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 41 ++++++++++++++++++-----------------------
 1 file changed, 18 insertions(+), 23 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b30269f5e68fb..6ab532ca77223 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -392,14 +392,6 @@ static int nvme_pci_npages_sgl(void)
 			NVME_CTRL_PAGE_SIZE);
 }
 
-static size_t nvme_pci_iod_alloc_size(void)
-{
-	size_t npages = max(nvme_pci_npages_prp(), nvme_pci_npages_sgl());
-
-	return sizeof(__le64 *) * npages +
-		sizeof(struct scatterlist) * NVME_MAX_SEGS;
-}
-
 static int nvme_admin_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
 				unsigned int hctx_idx)
 {
@@ -2775,6 +2767,22 @@ static void nvme_release_prp_pools(struct nvme_dev *dev)
 	dma_pool_destroy(dev->prp_small_pool);
 }
 
+static int nvme_pci_alloc_iod_mempool(struct nvme_dev *dev)
+{
+	size_t npages = max(nvme_pci_npages_prp(), nvme_pci_npages_sgl());
+	size_t alloc_size = sizeof(__le64 *) * npages +
+			    sizeof(struct scatterlist) * NVME_MAX_SEGS;
+
+	WARN_ON_ONCE(alloc_size > PAGE_SIZE);
+	dev->iod_mempool = mempool_create_node(1,
+			mempool_kmalloc, mempool_kfree,
+			(void *)alloc_size, GFP_KERNEL,
+			dev_to_node(dev->dev));
+	if (!dev->iod_mempool)
+		return -ENOMEM;
+	return 0;
+}
+
 static void nvme_free_tagset(struct nvme_dev *dev)
 {
 	if (dev->tagset.tags)
@@ -3103,7 +3111,6 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	int node, result = -ENOMEM;
 	struct nvme_dev *dev;
 	unsigned long quirks = id->driver_data;
-	size_t alloc_size;
 
 	node = dev_to_node(&pdev->dev);
 	if (node == NUMA_NO_NODE)
@@ -3148,21 +3155,9 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		quirks |= NVME_QUIRK_SIMPLE_SUSPEND;
 	}
 
-	/*
-	 * Double check that our mempool alloc size will cover the biggest
-	 * command we support.
-	 */
-	alloc_size = nvme_pci_iod_alloc_size();
-	WARN_ON_ONCE(alloc_size > PAGE_SIZE);
-
-	dev->iod_mempool = mempool_create_node(1, mempool_kmalloc,
-						mempool_kfree,
-						(void *) alloc_size,
-						GFP_KERNEL, node);
-	if (!dev->iod_mempool) {
-		result = -ENOMEM;
+	result = nvme_pci_alloc_iod_mempool(dev);
+	if (result)
 		goto release_pools;
-	}
 
 	result = nvme_init_ctrl(&dev->ctrl, &pdev->dev, &nvme_pci_ctrl_ops,
 			quirks);
-- 
2.40.1



