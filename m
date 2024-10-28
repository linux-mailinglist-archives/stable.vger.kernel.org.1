Return-Path: <stable+bounces-88580-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 831199B2697
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 07:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC341B20A93
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 06:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F3518E374;
	Mon, 28 Oct 2024 06:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HSSe8uKJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67BD189BAF;
	Mon, 28 Oct 2024 06:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730097653; cv=none; b=u8sRuebyQHkCQFJgesl2E0KdOoveo9oh+ksfwMr1IQsxUnGbEj4LqLl6ag9XASSrHeYpBAZwtq/wT8YkpjI7JbrwIGC75yc2irk9RE/osmNxfa/Bbwk3S89G5z5abU/06e1FsU0U5SqefRMtJH5SG4d/X5pXvFbO8WDzyOOPSh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730097653; c=relaxed/simple;
	bh=fsXKBYOXQVVMhUcn1ZjmeVDt0ykyj97QAAHiVdjcU34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tLiXYTYhfvyt6dDkbhkrrG2KI+U7oIVj/1yqdSdOYDOSgFCyRezWbrJZgJMYeaxd0gZ2yMFKbioJ8D2Q4XNoapNpectGtysm3tu5s+HU5JRXQwhALU3ToWpOTA9Isp6rAMOGXvwcDpkdL41uQ9sK71HIn9BgvoZc6PfVpnyJFeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HSSe8uKJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F04EC4CEC3;
	Mon, 28 Oct 2024 06:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730097653;
	bh=fsXKBYOXQVVMhUcn1ZjmeVDt0ykyj97QAAHiVdjcU34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HSSe8uKJMx4Wzwj091CsfzcRwKYZ8L7JMhAFzMnVWQHsj6ape4oJSIbA6fRw+tOBK
	 1+TwYOfdQl8T8ZgeCHfO/7qcdWSdhNsRcGxmwQiO6Ry2yD8D/39Ktb4DOIKtshT+6b
	 wl+wBS16GAQptLE2LANveeEM9wYqTBIihbJ4u7Co=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yi Zhang <yi.zhang@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Maurizio Lombardi <mlombard@redhat.com>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 088/208] nvme-pci: fix race condition between reset and nvme_dev_disable()
Date: Mon, 28 Oct 2024 07:24:28 +0100
Message-ID: <20241028062308.817644636@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028062306.649733554@linuxfoundation.org>
References: <20241028062306.649733554@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maurizio Lombardi <mlombard@redhat.com>

[ Upstream commit 26bc0a81f64ce00fc4342c38eeb2eddaad084dd2 ]

nvme_dev_disable() modifies the dev->online_queues field, therefore
nvme_pci_update_nr_queues() should avoid racing against it, otherwise
we could end up passing invalid values to blk_mq_update_nr_hw_queues().

 WARNING: CPU: 39 PID: 61303 at drivers/pci/msi/api.c:347
          pci_irq_get_affinity+0x187/0x210
 Workqueue: nvme-reset-wq nvme_reset_work [nvme]
 RIP: 0010:pci_irq_get_affinity+0x187/0x210
 Call Trace:
  <TASK>
  ? blk_mq_pci_map_queues+0x87/0x3c0
  ? pci_irq_get_affinity+0x187/0x210
  blk_mq_pci_map_queues+0x87/0x3c0
  nvme_pci_map_queues+0x189/0x460 [nvme]
  blk_mq_update_nr_hw_queues+0x2a/0x40
  nvme_reset_work+0x1be/0x2a0 [nvme]

Fix the bug by locking the shutdown_lock mutex before using
dev->online_queues. Give up if nvme_dev_disable() is running or if
it has been executed already.

Fixes: 949928c1c731 ("NVMe: Fix possible queue use after freed")
Tested-by: Yi Zhang <yi.zhang@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 61c9b175e035f..b701969cf1c2a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2469,17 +2469,29 @@ static unsigned int nvme_pci_nr_maps(struct nvme_dev *dev)
 	return 1;
 }
 
-static void nvme_pci_update_nr_queues(struct nvme_dev *dev)
+static bool nvme_pci_update_nr_queues(struct nvme_dev *dev)
 {
 	if (!dev->ctrl.tagset) {
 		nvme_alloc_io_tag_set(&dev->ctrl, &dev->tagset, &nvme_mq_ops,
 				nvme_pci_nr_maps(dev), sizeof(struct nvme_iod));
-		return;
+		return true;
+	}
+
+	/* Give up if we are racing with nvme_dev_disable() */
+	if (!mutex_trylock(&dev->shutdown_lock))
+		return false;
+
+	/* Check if nvme_dev_disable() has been executed already */
+	if (!dev->online_queues) {
+		mutex_unlock(&dev->shutdown_lock);
+		return false;
 	}
 
 	blk_mq_update_nr_hw_queues(&dev->tagset, dev->online_queues - 1);
 	/* free previously allocated queues that are no longer usable */
 	nvme_free_queues(dev, dev->online_queues);
+	mutex_unlock(&dev->shutdown_lock);
+	return true;
 }
 
 static int nvme_pci_enable(struct nvme_dev *dev)
@@ -2760,7 +2772,8 @@ static void nvme_reset_work(struct work_struct *work)
 		nvme_dbbuf_set(dev);
 		nvme_unquiesce_io_queues(&dev->ctrl);
 		nvme_wait_freeze(&dev->ctrl);
-		nvme_pci_update_nr_queues(dev);
+		if (!nvme_pci_update_nr_queues(dev))
+			goto out;
 		nvme_unfreeze(&dev->ctrl);
 	} else {
 		dev_warn(dev->ctrl.device, "IO queues lost\n");
-- 
2.43.0




