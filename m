Return-Path: <stable+bounces-107438-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E49FCA02BEB
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 16:48:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 436FF1620AD
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 15:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E04C149C7B;
	Mon,  6 Jan 2025 15:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1+ZXP0WL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094C242040;
	Mon,  6 Jan 2025 15:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736178463; cv=none; b=SoqgfuiFMeIJzP47ZwmrTekFABBhNsLrTR8m+ODNyK7wqG8DvuBhIN/pF7NDh+h0NlKdz2m5F4M9fkELFr498DUrqDzCcK1s9pmObP83vaZH2EK7xzl7cRHrReNHcVdVYVpByIZoqQy8ClUXU9O9fy9p+ajW6I6T+txrDG6bhQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736178463; c=relaxed/simple;
	bh=0lJNERQVA8Ne8I31etI0XB4d9BVK2yMFBzVtMe6+hX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JIx9ZY0OQ3CHdo+mhN8xFKJgfpd51+9bLhlNXNS2R/o+xc+S/0tQaXPAnB0GtMjWarCCUsuLQEiUkFjIIoJzAenaRcqX9etkZVhWynu1xSw1olwUDZTFI8B7BuxCWeG93CtkQtxZCfiz/iMR0c7saU9jaktQWhXKxP+OiBk+l4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1+ZXP0WL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CE93C4CED2;
	Mon,  6 Jan 2025 15:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736178462;
	bh=0lJNERQVA8Ne8I31etI0XB4d9BVK2yMFBzVtMe6+hX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1+ZXP0WL/kzUGIqrOxTAszJlsFOYQv/pP3hK/ICYaIkmZPTReZ11ZRVrmv5trXiy6
	 rECUspV6cuk6hkglDS626Tr89g2/6QeOf4461HzS1tMlKSqu+huE/eNj/wnhM5EjnZ
	 zBq6jzYGyrWmzoGJTsTyqWFrvEZ5r/gTQnm3dFwI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>,
	Petr Vorel <pvorel@suse.cz>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 095/138] block: remove the update_bdev parameter to set_capacity_revalidate_and_notify
Date: Mon,  6 Jan 2025 16:16:59 +0100
Message-ID: <20250106151136.828437447@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106151133.209718681@linuxfoundation.org>
References: <20250106151133.209718681@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 449f4ec9892ebc2f37a7eae6d97db2cf7c65e09a ]

The update_bdev argument is always set to true, so remove it.  Also
rename the function to the slighly less verbose set_capacity_and_notify,
as propagating the disk size to the block device isn't really
revalidation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: 74363ec674cb ("zram: fix uninitialized ZRAM not releasing backing device")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/genhd.c                | 13 +++++--------
 drivers/block/loop.c         |  2 +-
 drivers/block/virtio_blk.c   |  2 +-
 drivers/block/xen-blkfront.c |  2 +-
 drivers/nvme/host/core.c     |  2 +-
 drivers/scsi/sd.c            |  5 ++---
 include/linux/genhd.h        |  3 +--
 7 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 796baf761202..768a49460bf1 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -46,17 +46,15 @@ static void disk_del_events(struct gendisk *disk);
 static void disk_release_events(struct gendisk *disk);
 
 /*
- * Set disk capacity and notify if the size is not currently
- * zero and will not be set to zero
+ * Set disk capacity and notify if the size is not currently zero and will not
+ * be set to zero.  Returns true if a uevent was sent, otherwise false.
  */
-bool set_capacity_revalidate_and_notify(struct gendisk *disk, sector_t size,
-					bool update_bdev)
+bool set_capacity_and_notify(struct gendisk *disk, sector_t size)
 {
 	sector_t capacity = get_capacity(disk);
 
 	set_capacity(disk, size);
-	if (update_bdev)
-		revalidate_disk_size(disk, true);
+	revalidate_disk_size(disk, true);
 
 	if (capacity != size && capacity != 0 && size != 0) {
 		char *envp[] = { "RESIZE=1", NULL };
@@ -67,8 +65,7 @@ bool set_capacity_revalidate_and_notify(struct gendisk *disk, sector_t size,
 
 	return false;
 }
-
-EXPORT_SYMBOL_GPL(set_capacity_revalidate_and_notify);
+EXPORT_SYMBOL_GPL(set_capacity_and_notify);
 
 /*
  * Format the device name of the indicated disk into the supplied buffer and
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 198f7ce3234b..b30f4d525bc8 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -238,7 +238,7 @@ static void __loop_update_dio(struct loop_device *lo, bool dio)
  */
 static void loop_set_size(struct loop_device *lo, loff_t size)
 {
-	if (!set_capacity_revalidate_and_notify(lo->lo_disk, size, true))
+	if (!set_capacity_and_notify(lo->lo_disk, size))
 		kobject_uevent(&disk_to_dev(lo->lo_disk)->kobj, KOBJ_CHANGE);
 }
 
diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 28ea9b511fd0..c87c6a4eb3b3 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -470,7 +470,7 @@ static void virtblk_update_capacity(struct virtio_blk *vblk, bool resize)
 		   cap_str_10,
 		   cap_str_2);
 
-	set_capacity_revalidate_and_notify(vblk->disk, capacity, true);
+	set_capacity_and_notify(vblk->disk, capacity);
 }
 
 static void virtblk_config_changed_work(struct work_struct *work)
diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index d68a8ca2161f..19ddbf977d28 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -2443,7 +2443,7 @@ static void blkfront_connect(struct blkfront_info *info)
 			return;
 		printk(KERN_INFO "Setting capacity to %Lu\n",
 		       sectors);
-		set_capacity_revalidate_and_notify(info->gd, sectors, true);
+		set_capacity_and_notify(info->gd, sectors);
 
 		return;
 	case BLKIF_STATE_SUSPENDED:
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c8e64a1e2fc0..c739ac1761ba 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2132,7 +2132,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
 			capacity = 0;
 	}
 
-	set_capacity_revalidate_and_notify(disk, capacity, true);
+	set_capacity_and_notify(disk, capacity);
 
 	nvme_config_discard(disk, ns);
 	nvme_config_write_zeroes(disk->queue, ns->ctrl);
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 355d38cab862..da6df9809b0c 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3292,8 +3292,7 @@ static int sd_revalidate_disk(struct gendisk *disk)
 
 	sdkp->first_scan = 0;
 
-	set_capacity_revalidate_and_notify(disk,
-		logical_to_sectors(sdp, sdkp->capacity), true);
+	set_capacity_and_notify(disk, logical_to_sectors(sdp, sdkp->capacity));
 	sd_config_write_same(sdkp);
 	kfree(buffer);
 
@@ -3303,7 +3302,7 @@ static int sd_revalidate_disk(struct gendisk *disk)
 	 * capacity to 0.
 	 */
 	if (sd_zbc_revalidate_zones(sdkp))
-		set_capacity_revalidate_and_notify(disk, 0, true);
+		set_capacity_and_notify(disk, 0);
 
  out:
 	return 0;
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 03da3f603d30..4b22bfd9336e 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -315,8 +315,7 @@ static inline int get_disk_ro(struct gendisk *disk)
 extern void disk_block_events(struct gendisk *disk);
 extern void disk_unblock_events(struct gendisk *disk);
 extern void disk_flush_events(struct gendisk *disk, unsigned int mask);
-bool set_capacity_revalidate_and_notify(struct gendisk *disk, sector_t size,
-		bool update_bdev);
+bool set_capacity_and_notify(struct gendisk *disk, sector_t size);
 
 /* drivers/char/random.c */
 extern void add_disk_randomness(struct gendisk *disk) __latent_entropy;
-- 
2.39.5




