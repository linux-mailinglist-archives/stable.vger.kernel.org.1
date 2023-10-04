Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2287B88C7
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233867AbjJDST1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233912AbjJDST1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:19:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6A8A7
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:19:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35F12C433C8;
        Wed,  4 Oct 2023 18:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443562;
        bh=xWlRcGie54UdRHcD9T2q7E1SAnOktMLp7AoXvKkaDIY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AiVTF6Sno12f2lyUb/XFby2PJeRl+PV+nZTF+5jrVn/R7gdii+65sJPtWaojLYu/1
         zYxB64aRj77UjceBVq5u5Eo2ro0e3uwatZ6+sm53HoOj5VbMKSNZIs4HiUigZo9Yeo
         PAu+J467lT5lB0ACAnY3YSNascnwJCNNYb+jHJEw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 201/259] nvme-pci: factor out a nvme_pci_alloc_dev helper
Date:   Wed,  4 Oct 2023 19:56:14 +0200
Message-ID: <20231004175226.493656790@linuxfoundation.org>
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

[ Upstream commit 2e87570be9d2746e7c4e7ab1cc18fd3ca7de2768 ]

Add a helper that allocates the nvme_dev structure up to the point where
we can call nvme_init_ctrl.  This pairs with the free_ctrl method and can
thus be used to cleanup the teardown path and make it more symmetric.

Note that this now calls nvme_init_ctrl a lot earlier during probing,
which also means the per-controller character device shows up earlier.
Due to the controller state no commnds can be send on it, but it might
make sense to delay the cdev registration until nvme_init_ctrl_finish.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Tested-by Gerd Bayer <gbayer@linxu.ibm.com>
Stable-dep-of: dad651b2a44e ("nvme-pci: do not set the NUMA node of device if it has none")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 81 +++++++++++++++++++++++------------------
 1 file changed, 46 insertions(+), 35 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6ab532ca77223..42e85b1bf6591 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2790,6 +2790,7 @@ static void nvme_free_tagset(struct nvme_dev *dev)
 	dev->ctrl.tagset = NULL;
 }
 
+/* pairs with nvme_pci_alloc_dev */
 static void nvme_pci_free_ctrl(struct nvme_ctrl *ctrl)
 {
 	struct nvme_dev *dev = to_nvme_dev(ctrl);
@@ -3106,19 +3107,23 @@ static void nvme_async_probe(void *data, async_cookie_t cookie)
 	nvme_put_ctrl(&dev->ctrl);
 }
 
-static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
+		const struct pci_device_id *id)
 {
-	int node, result = -ENOMEM;
-	struct nvme_dev *dev;
 	unsigned long quirks = id->driver_data;
+	int node = dev_to_node(&pdev->dev);
+	struct nvme_dev *dev;
+	int ret = -ENOMEM;
 
-	node = dev_to_node(&pdev->dev);
 	if (node == NUMA_NO_NODE)
 		set_dev_node(&pdev->dev, first_memory_node);
 
 	dev = kzalloc_node(sizeof(*dev), GFP_KERNEL, node);
 	if (!dev)
-		return -ENOMEM;
+		return NULL;
+	INIT_WORK(&dev->ctrl.reset_work, nvme_reset_work);
+	INIT_WORK(&dev->remove_work, nvme_remove_dead_ctrl_work);
+	mutex_init(&dev->shutdown_lock);
 
 	dev->nr_write_queues = write_queues;
 	dev->nr_poll_queues = poll_queues;
@@ -3126,25 +3131,11 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	dev->queues = kcalloc_node(dev->nr_allocated_queues,
 			sizeof(struct nvme_queue), GFP_KERNEL, node);
 	if (!dev->queues)
-		goto free;
+		goto out_free_dev;
 
 	dev->dev = get_device(&pdev->dev);
-	pci_set_drvdata(pdev, dev);
-
-	result = nvme_dev_map(dev);
-	if (result)
-		goto put_pci;
-
-	INIT_WORK(&dev->ctrl.reset_work, nvme_reset_work);
-	INIT_WORK(&dev->remove_work, nvme_remove_dead_ctrl_work);
-	mutex_init(&dev->shutdown_lock);
-
-	result = nvme_setup_prp_pools(dev);
-	if (result)
-		goto unmap;
 
 	quirks |= check_vendor_combination_bug(pdev);
-
 	if (!noacpi && acpi_storage_d3(&pdev->dev)) {
 		/*
 		 * Some systems use a bios work around to ask for D3 on
@@ -3154,34 +3145,54 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 			 "platform quirk: setting simple suspend\n");
 		quirks |= NVME_QUIRK_SIMPLE_SUSPEND;
 	}
+	ret = nvme_init_ctrl(&dev->ctrl, &pdev->dev, &nvme_pci_ctrl_ops,
+			     quirks);
+	if (ret)
+		goto out_put_device;
+	return dev;
 
-	result = nvme_pci_alloc_iod_mempool(dev);
+out_put_device:
+	put_device(dev->dev);
+	kfree(dev->queues);
+out_free_dev:
+	kfree(dev);
+	return ERR_PTR(ret);
+}
+
+static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	struct nvme_dev *dev;
+	int result = -ENOMEM;
+
+	dev = nvme_pci_alloc_dev(pdev, id);
+	if (!dev)
+		return -ENOMEM;
+
+	result = nvme_dev_map(dev);
 	if (result)
-		goto release_pools;
+		goto out_uninit_ctrl;
 
-	result = nvme_init_ctrl(&dev->ctrl, &pdev->dev, &nvme_pci_ctrl_ops,
-			quirks);
+	result = nvme_setup_prp_pools(dev);
+	if (result)
+		goto out_dev_unmap;
+
+	result = nvme_pci_alloc_iod_mempool(dev);
 	if (result)
-		goto release_mempool;
+		goto out_release_prp_pools;
 
 	dev_info(dev->ctrl.device, "pci function %s\n", dev_name(&pdev->dev));
+	pci_set_drvdata(pdev, dev);
 
 	nvme_reset_ctrl(&dev->ctrl);
 	async_schedule(nvme_async_probe, dev);
-
 	return 0;
 
- release_mempool:
-	mempool_destroy(dev->iod_mempool);
- release_pools:
+out_release_prp_pools:
 	nvme_release_prp_pools(dev);
- unmap:
+out_dev_unmap:
 	nvme_dev_unmap(dev);
- put_pci:
-	put_device(dev->dev);
- free:
-	kfree(dev->queues);
-	kfree(dev);
+out_uninit_ctrl:
+	nvme_uninit_ctrl(&dev->ctrl);
 	return result;
 }
 
-- 
2.40.1



