Return-Path: <stable+bounces-93240-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA389CD81E
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 07:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 938EF282382
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 06:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646B2188CA9;
	Fri, 15 Nov 2024 06:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EiULxjFZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2317518873F;
	Fri, 15 Nov 2024 06:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731653259; cv=none; b=SK/LstqrILjvnyEiDOGiETtX4EyAJ/YcG74qtcIFmRGutxO1A7CDwsTw9QhHisK/C3FrHDOh5ZIcL8KzYXAz1Po0JnG/XmasCHtcg10Ywh27TA4EFwphEvHKkm7/5I6UPZ+hP0gfjAKGvpg2CELABe+E6voMQPrTmL+wh6Wu0RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731653259; c=relaxed/simple;
	bh=uCZ01Gt2GpCsZBve1uJcBDRDMAVGZdSlDlbunAJrOGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iZ/774us7plJTTxZJpLG1t1BKyRdwsZq/IcqaRnygVQOfQ3IevckhPXahC9Ts/OUTJvTox9wFHycSvfv4D53u8jT8e8aNO1mcRfcFQyTcO+7Aq9EzXqfnxSatlFzJ+RC3jIuKrBfcsXrGMXpQQEMl2yzKka3K7o4rwzQ4wiJwqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EiULxjFZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E218C4CECF;
	Fri, 15 Nov 2024 06:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731653259;
	bh=uCZ01Gt2GpCsZBve1uJcBDRDMAVGZdSlDlbunAJrOGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EiULxjFZqijoq3KEQ1XFIKzCvgBJ6CdWZ2dhSXcBoJDnmCLARPwRA/QL1kwycJMz/
	 qlXVZL8ByN24m0w3m9aWRzfv8aLg0N5sv31ymm8ClQzHRVkz65m1z+Lxlf2dReAQHA
	 uSL04fJNPPf9ctyCWWAPzF+rl3SAO+iCfWoJHs+I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 26/63] nvme-multipath: defer partition scanning
Date: Fri, 15 Nov 2024 07:37:49 +0100
Message-ID: <20241115063726.863481790@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241115063725.892410236@linuxfoundation.org>
References: <20241115063725.892410236@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Keith Busch <kbusch@kernel.org>

[ Upstream commit 1f021341eef41e77a633186e9be5223de2ce5d48 ]

We need to suppress the partition scan from occuring within the
controller's scan_work context. If a path error occurs here, the IO will
wait until a path becomes available or all paths are torn down, but that
action also occurs within scan_work, so it would deadlock. Defer the
partion scan to a different context that does not block scan_work.

Reported-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/multipath.c | 33 +++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h      |  1 +
 2 files changed, 34 insertions(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 6d97058cde7a1..a43982aaa40d7 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -577,6 +577,20 @@ static int nvme_add_ns_head_cdev(struct nvme_ns_head *head)
 	return ret;
 }
 
+static void nvme_partition_scan_work(struct work_struct *work)
+{
+	struct nvme_ns_head *head =
+		container_of(work, struct nvme_ns_head, partition_scan_work);
+
+	if (WARN_ON_ONCE(!test_and_clear_bit(GD_SUPPRESS_PART_SCAN,
+					     &head->disk->state)))
+		return;
+
+	mutex_lock(&head->disk->open_mutex);
+	bdev_disk_changed(head->disk, false);
+	mutex_unlock(&head->disk->open_mutex);
+}
+
 static void nvme_requeue_work(struct work_struct *work)
 {
 	struct nvme_ns_head *head =
@@ -603,6 +617,7 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 	bio_list_init(&head->requeue_list);
 	spin_lock_init(&head->requeue_lock);
 	INIT_WORK(&head->requeue_work, nvme_requeue_work);
+	INIT_WORK(&head->partition_scan_work, nvme_partition_scan_work);
 
 	/*
 	 * Add a multipath node if the subsystems supports multiple controllers.
@@ -626,6 +641,16 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 		return PTR_ERR(head->disk);
 	head->disk->fops = &nvme_ns_head_ops;
 	head->disk->private_data = head;
+
+	/*
+	 * We need to suppress the partition scan from occuring within the
+	 * controller's scan_work context. If a path error occurs here, the IO
+	 * will wait until a path becomes available or all paths are torn down,
+	 * but that action also occurs within scan_work, so it would deadlock.
+	 * Defer the partion scan to a different context that does not block
+	 * scan_work.
+	 */
+	set_bit(GD_SUPPRESS_PART_SCAN, &head->disk->state);
 	sprintf(head->disk->disk_name, "nvme%dn%d",
 			ctrl->subsys->instance, head->instance);
 	return 0;
@@ -652,6 +677,7 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
 			return;
 		}
 		nvme_add_ns_head_cdev(head);
+		kblockd_schedule_work(&head->partition_scan_work);
 	}
 
 	mutex_lock(&head->lock);
@@ -972,6 +998,12 @@ void nvme_mpath_shutdown_disk(struct nvme_ns_head *head)
 	kblockd_schedule_work(&head->requeue_work);
 	if (test_bit(NVME_NSHEAD_DISK_LIVE, &head->flags)) {
 		nvme_cdev_del(&head->cdev, &head->cdev_device);
+		/*
+		 * requeue I/O after NVME_NSHEAD_DISK_LIVE has been cleared
+		 * to allow multipath to fail all I/O.
+		 */
+		synchronize_srcu(&head->srcu);
+		kblockd_schedule_work(&head->requeue_work);
 		del_gendisk(head->disk);
 	}
 }
@@ -983,6 +1015,7 @@ void nvme_mpath_remove_disk(struct nvme_ns_head *head)
 	/* make sure all pending bios are cleaned up */
 	kblockd_schedule_work(&head->requeue_work);
 	flush_work(&head->requeue_work);
+	flush_work(&head->partition_scan_work);
 	put_disk(head->disk);
 }
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 313a4f978a2cf..093cb423f536b 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -494,6 +494,7 @@ struct nvme_ns_head {
 	struct bio_list		requeue_list;
 	spinlock_t		requeue_lock;
 	struct work_struct	requeue_work;
+	struct work_struct	partition_scan_work;
 	struct mutex		lock;
 	unsigned long		flags;
 #define NVME_NSHEAD_DISK_LIVE	0
-- 
2.43.0




