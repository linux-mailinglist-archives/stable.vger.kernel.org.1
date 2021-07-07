Return-Path: <stable+bounces-116475-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6F1A36BAB
	for <lists+stable@lfdr.de>; Sat, 15 Feb 2025 04:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CCC8169F4A
	for <lists+stable@lfdr.de>; Sat, 15 Feb 2025 03:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B5C6BB5B;
	Sat, 15 Feb 2025 03:33:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA86748D
	for <stable@vger.kernel.org>; Sat, 15 Feb 2025 03:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739590390; cv=none; b=Zy8Ov1wxYjYltX7MAZWht8tjajjo9+kbVw4cYsvxZknPr+QPEyJR0X8TFj8Exb/jBqyA4O2ScY5OO/ZvRAaT6PKPowoGSoqEGCniXXqjntuJYv+Um70Bjj/K2bTlzMNmC0QUzVBNlQgLZR76GfBNqp6NH/lpw4SOhz38KLjdhqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739590390; c=relaxed/simple;
	bh=jrfDV439+PBxi7vphNJyj+/dqvueeIoqO/Oyb0oVB5E=;
	h=From:Date:Subject:To:Message-Id; b=XEJKi36PZW7KbZyLm10URT7COvNNuHbjmb+uuYONk3hgsR8VDQfxKvAMi3lbw+v3tGw3PiQbq6qQJGBS2H6MS1QpA7LViXvox0i//jkFaCqO+5j43fykXaVXHkNN2cCKEAruzSuYrO/eRNtwhXKUKc7XMKuAKuz/1AUiDLV0e24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=purestorage.com; spf=none smtp.mailfrom=debian.org; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <noahm@debian.org>)
	id 1tj8vR-00A1OX-Le
	for stable@vger.kernel.org; Sat, 15 Feb 2025 03:33:05 +0000
Received: from [fd00:80db:0:4::7766] (helo=lore)
	by minas.morgul.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <noahm@debian.org>)
	id 1tj8vP-002owa-0Z
	for stable@vger.kernel.org;
	Fri, 14 Feb 2025 22:33:03 -0500
Received: from noahm by lore with local (Exim 4.96)
	(envelope-from <noahm@debian.org>)
	id 1tj8vO-00471h-2H
	for stable@vger.kernel.org;
	Fri, 14 Feb 2025 22:33:02 -0500
From: Casey Chen <cachen@purestorage.com>
Date: Wed, 7 Jul 2021 14:14:31 -0700
Subject: [PATCH 5.10] nvme-pci: fix multiple races in nvme_setup_io_queues
To: stable@vger.kernel.org
Message-Id: <E1tj8vO-00471h-2H@lore>
X-Debian-User: noahm
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

commit e4b9852a0f4afe40604afb442e3af4452722050a upstream.

Below two paths could overlap each other if we power off a drive quickly
after powering it on. There are multiple races in nvme_setup_io_queues()
because of shutdown_lock missing and improper use of NVMEQ_ENABLED bit.

nvme_reset_work()                                nvme_remove()
  nvme_setup_io_queues()                           nvme_dev_disable()
  ...                                              ...
A1  clear NVMEQ_ENABLED bit for admin queue          lock
    retry:                                       B1  nvme_suspend_io_queues()
A2    pci_free_irq() admin queue                 B2  nvme_suspend_queue() admin queue
A3    pci_free_irq_vectors()                         nvme_pci_disable()
A4    nvme_setup_irqs();                         B3    pci_free_irq_vectors()
      ...                                            unlock
A5    queue_request_irq() for admin queue
      set NVMEQ_ENABLED bit
      ...
      nvme_create_io_queues()
A6      result = queue_request_irq();
        set NVMEQ_ENABLED bit
      ...
      fail to allocate enough IO queues:
A7      nvme_suspend_io_queues()
        goto retry

If B3 runs in between A1 and A2, it will crash if irqaction haven't
been freed by A2. B2 is supposed to free admin queue IRQ but it simply
can't fulfill the job as A1 has cleared NVMEQ_ENABLED bit.

Fix: combine A1 A2 so IRQ get freed as soon as the NVMEQ_ENABLED bit
gets cleared.

After solved #1, A2 could race with B3 if A2 is freeing IRQ while B3
is checking irqaction. A3 also could race with B2 if B2 is freeing
IRQ while A3 is checking irqaction.

Fix: A2 and A3 take lock for mutual exclusion.

A3 could race with B3 since they could run free_msi_irqs() in parallel.

Fix: A3 takes lock for mutual exclusion.

A4 could fail to allocate all needed IRQ vectors if A3 and A4 are
interrupted by B3.

Fix: A4 takes lock for mutual exclusion.

If A5/A6 happened after B2/B1, B3 will crash since irqaction is not NULL.
They are just allocated by A5/A6.

Fix: Lock queue_request_irq() and setting of NVMEQ_ENABLED bit.

A7 could get chance to pci_free_irq() for certain IO queue while B3 is
checking irqaction.

Fix: A7 takes lock.

nvme_dev->online_queues need to be protected by shutdown_lock. Since it
is not atomic, both paths could modify it using its own copy.

Co-developed-by: Yuanyuan Zhong <yzhong@purestorage.com>
Signed-off-by: Casey Chen <cachen@purestorage.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
[noahm@debian.org: backported to 5.10]
Link: https://lore.kernel.org/linux-nvme/20210707211432.29536-1-cachen@purestorage.com/
Signed-off-by: Noah Meyerhans <noahm@debian.org>
---
 drivers/nvme/host/pci.c | 66 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 58 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 875ebef6adc7..ae04bdce560a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1563,6 +1563,28 @@ static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
 	wmb(); /* ensure the first interrupt sees the initialization */
 }
 
+/*
+ * Try getting shutdown_lock while setting up IO queues.
+ */
+static int nvme_setup_io_queues_trylock(struct nvme_dev *dev)
+{
+	/*
+	 * Give up if the lock is being held by nvme_dev_disable.
+	 */
+	if (!mutex_trylock(&dev->shutdown_lock))
+		return -ENODEV;
+
+	/*
+	 * Controller is in wrong state, fail early.
+	 */
+	if (dev->ctrl.state != NVME_CTRL_CONNECTING) {
+		mutex_unlock(&dev->shutdown_lock);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
 static int nvme_create_queue(struct nvme_queue *nvmeq, int qid, bool polled)
 {
 	struct nvme_dev *dev = nvmeq->dev;
@@ -1591,8 +1613,11 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid, bool polled)
 		goto release_cq;
 
 	nvmeq->cq_vector = vector;
-	nvme_init_queue(nvmeq, qid);
 
+	result = nvme_setup_io_queues_trylock(dev);
+	if (result)
+		return result;
+	nvme_init_queue(nvmeq, qid);
 	if (!polled) {
 		result = queue_request_irq(nvmeq);
 		if (result < 0)
@@ -1600,10 +1625,12 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid, bool polled)
 	}
 
 	set_bit(NVMEQ_ENABLED, &nvmeq->flags);
+	mutex_unlock(&dev->shutdown_lock);
 	return result;
 
 release_sq:
 	dev->online_queues--;
+	mutex_unlock(&dev->shutdown_lock);
 	adapter_delete_sq(dev, qid);
 release_cq:
 	adapter_delete_cq(dev, qid);
@@ -2182,7 +2209,18 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	if (nr_io_queues == 0)
 		return 0;
 	
-	clear_bit(NVMEQ_ENABLED, &adminq->flags);
+	/*
+	 * Free IRQ resources as soon as NVMEQ_ENABLED bit transitions
+	 * from set to unset. If there is a window to it is truely freed,
+	 * pci_free_irq_vectors() jumping into this window will crash.
+	 * And take lock to avoid racing with pci_free_irq_vectors() in
+	 * nvme_dev_disable() path.
+	 */
+	result = nvme_setup_io_queues_trylock(dev);
+	if (result)
+		return result;
+	if (test_and_clear_bit(NVMEQ_ENABLED, &adminq->flags))
+		pci_free_irq(pdev, 0, adminq);
 
 	if (dev->cmb_use_sqes) {
 		result = nvme_cmb_qdepth(dev, nr_io_queues,
@@ -2198,14 +2236,17 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 		result = nvme_remap_bar(dev, size);
 		if (!result)
 			break;
-		if (!--nr_io_queues)
-			return -ENOMEM;
+		if (!--nr_io_queues) {
+			result = -ENOMEM;
+			goto out_unlock;
+		}
 	} while (1);
 	adminq->q_db = dev->dbs;
 
  retry:
 	/* Deregister the admin queue's interrupt */
-	pci_free_irq(pdev, 0, adminq);
+	if (test_and_clear_bit(NVMEQ_ENABLED, &adminq->flags))
+		pci_free_irq(pdev, 0, adminq);
 
 	/*
 	 * If we enable msix early due to not intx, disable it again before
@@ -2214,8 +2255,10 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	pci_free_irq_vectors(pdev);
 
 	result = nvme_setup_irqs(dev, nr_io_queues);
-	if (result <= 0)
-		return -EIO;
+	if (result <= 0) {
+		result = -EIO;
+		goto out_unlock;
+	}
 
 	dev->num_vecs = result;
 	result = max(result - 1, 1);
@@ -2229,8 +2272,9 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	 */
 	result = queue_request_irq(adminq);
 	if (result)
-		return result;
+		goto out_unlock;
 	set_bit(NVMEQ_ENABLED, &adminq->flags);
+	mutex_unlock(&dev->shutdown_lock);
 
 	result = nvme_create_io_queues(dev);
 	if (result || dev->online_queues < 2)
@@ -2239,6 +2283,9 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	if (dev->online_queues - 1 < dev->max_qid) {
 		nr_io_queues = dev->online_queues - 1;
 		nvme_disable_io_queues(dev);
+		result = nvme_setup_io_queues_trylock(dev);
+		if (result)
+			return result;
 		nvme_suspend_io_queues(dev);
 		goto retry;
 	}
@@ -2247,6 +2294,9 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 					dev->io_queues[HCTX_TYPE_READ],
 					dev->io_queues[HCTX_TYPE_POLL]);
 	return 0;
+out_unlock:
+	mutex_unlock(&dev->shutdown_lock);
+	return result;
 }
 
 static void nvme_del_queue_end(struct request *req, blk_status_t error)
-- 
2.39.5


