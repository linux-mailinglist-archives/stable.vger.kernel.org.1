Return-Path: <stable+bounces-87883-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6619ACCDF
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 16:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A068B24AA6
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 14:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BAAD204033;
	Wed, 23 Oct 2024 14:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ue9atXbp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A3C20400A;
	Wed, 23 Oct 2024 14:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729693906; cv=none; b=DwGCvSpCcwqgxCy8R6UOc6YW2+aBCMvbXY8YlW7qSSGSx9mbaMmUw1VU6ypoMaxJnUSmbg4hNZrYPPXFYnQEAlEA0ftgWNzehyCvZoUp7bniHDBqYtTFOSvX+mugfyPP6rnTV589eQfeSzGmcclVDDEIjKLz00F6vIJyUympmSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729693906; c=relaxed/simple;
	bh=M95oN5BJW2ED7DYuRHRVyRxqpANuvn7SqeCMgOM4kyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aDg2R5kZv9Ix2/0EzkK5RZoPGepw2TuXEqR4s43IIIi2n7BDXbz7Qh6pHLJ+rnlLXsO+w6h6g9EqvhL+xs+9sziBLrDGI4n4SpBky9uwnPMKV0c0PWaQ/YPgTlDmSiYkftYr/Ynvk9dAXnLrZC0wLRLEVhGGKLvpbrA8J00Jhbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ue9atXbp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 199C7C4CEEE;
	Wed, 23 Oct 2024 14:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729693906;
	bh=M95oN5BJW2ED7DYuRHRVyRxqpANuvn7SqeCMgOM4kyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ue9atXbpmUgJdILdqypU1R+Ep6n8bSfDc2ivKrtp9WHVCYG2KhqA2z7QzgsHLW+0z
	 XQyuMCHbkPat6dkar73ummzMa3VgICSMJYUCFLAZgpYehYh3OIQeZ+Wld03hWi9n0Z
	 IYI9CmdjuHPYPNFPtFQ4fjROg98J+s6tlHNW8HM8J7x0+RdfvkfwwCeyDu8VpHik3l
	 aj0OZG/RI2BsOtzy4zXXFPxfNOPsCFYNh0HPhdk89cr/yAEREzJ2lRJw9DYlv4sW9v
	 VJ5k4SMgYHsEJmtD1ESK3GwVZnmyxus21KPPRsmMtRCwLkIfEY7GBytzhsYCqq5oxa
	 hb0FluwIfZ9JA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 18/23] nvme-multipath: defer partition scanning
Date: Wed, 23 Oct 2024 10:31:02 -0400
Message-ID: <20241023143116.2981369-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023143116.2981369-1-sashal@kernel.org>
References: <20241023143116.2981369-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.58
Content-Transfer-Encoding: 8bit

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
index 37ea0fa421da8..ede2a14dad8be 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -499,6 +499,20 @@ static int nvme_add_ns_head_cdev(struct nvme_ns_head *head)
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
@@ -525,6 +539,7 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 	bio_list_init(&head->requeue_list);
 	spin_lock_init(&head->requeue_lock);
 	INIT_WORK(&head->requeue_work, nvme_requeue_work);
+	INIT_WORK(&head->partition_scan_work, nvme_partition_scan_work);
 
 	/*
 	 * Add a multipath node if the subsystems supports multiple controllers.
@@ -540,6 +555,16 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 		return -ENOMEM;
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
 
@@ -589,6 +614,7 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
 			return;
 		}
 		nvme_add_ns_head_cdev(head);
+		kblockd_schedule_work(&head->partition_scan_work);
 	}
 
 	mutex_lock(&head->lock);
@@ -889,6 +915,12 @@ void nvme_mpath_shutdown_disk(struct nvme_ns_head *head)
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
@@ -900,6 +932,7 @@ void nvme_mpath_remove_disk(struct nvme_ns_head *head)
 	/* make sure all pending bios are cleaned up */
 	kblockd_schedule_work(&head->requeue_work);
 	flush_work(&head->requeue_work);
+	flush_work(&head->partition_scan_work);
 	put_disk(head->disk);
 }
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 799f8a2bb0b4f..14a867245c29f 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -476,6 +476,7 @@ struct nvme_ns_head {
 	struct bio_list		requeue_list;
 	spinlock_t		requeue_lock;
 	struct work_struct	requeue_work;
+	struct work_struct	partition_scan_work;
 	struct mutex		lock;
 	unsigned long		flags;
 #define NVME_NSHEAD_DISK_LIVE	0
-- 
2.43.0


