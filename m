Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A26777BE090
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377354AbjJINlf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377357AbjJINle (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:41:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68043A3
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:41:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A29EC433C8;
        Mon,  9 Oct 2023 13:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858893;
        bh=4oxowPP2gpzxiSWBMiFX6FX1j0q5NXkDOI1cZogs+8w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r5lHwnL3FOMOV3g4WEdIiqSWrLeNu+402PDuH52HuhHZfSyMbpW4RseagY62Xuwfj
         9bhTZjJ1ijb/OIw79D7JPN7zOxD9iBaDitYEEZdfDcq40WnO30ay1uQIm4XpylJhRM
         T1sV7wEK1iW//54DOJHla2//0w00UvgPUlCmYsvE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 134/226] nvme-pci: factor the iod mempool creation into a helper
Date:   Mon,  9 Oct 2023 15:01:35 +0200
Message-ID: <20231009130130.256751200@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130126.697995596@linuxfoundation.org>
References: <20231009130126.697995596@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

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
index e384ade6c2cd2..48886355ce90c 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -387,14 +387,6 @@ static int nvme_pci_npages_sgl(void)
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
@@ -2557,6 +2549,22 @@ static void nvme_release_prp_pools(struct nvme_dev *dev)
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
@@ -2854,7 +2862,6 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	int node, result = -ENOMEM;
 	struct nvme_dev *dev;
 	unsigned long quirks = id->driver_data;
-	size_t alloc_size;
 
 	node = dev_to_node(&pdev->dev);
 	if (node == NUMA_NO_NODE)
@@ -2899,21 +2906,9 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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



