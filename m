Return-Path: <stable+bounces-203672-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E19FECE74AE
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 17:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 58C113003FE7
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 16:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F057632E748;
	Mon, 29 Dec 2025 16:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YRWlTgzT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B260332E6A8
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 16:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767024307; cv=none; b=Yfn7vl0+yJtDcWag8F/pEbB5RYqRWdqiiTRl1ZXBXsfeMiouzIlSQIKx3qarcAxY637rwJCCDJ4NR1vARTNYuQB0ugKfdSSt4i0Rsee364872aISGKUVqcZm7Z3cWcZOVSN2aMDegBj/APUIlokyeGSbiJxwjOJE06sta6l8MR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767024307; c=relaxed/simple;
	bh=7zFP790CgcYj+YfQkmLYZzdQbrsS5QQF3BdqKTcT/5o=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tENXH8pFJ/XUbDLZ0yfqX/bC/fic6wnw466XXACodtnhtLnm6Th9gNSZD4r3OQ6Cm5ir1+NcmNFykndWWQAgD9f1oNQAwAqjuTf3gBgvCXjTHC0+WkWLiAH6suSEsvtCacBdF+VbIPHqN+NJBHU1OSzaSx5TJ1a1nbsXaRWIkDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YRWlTgzT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C114BC4CEF7;
	Mon, 29 Dec 2025 16:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767024307;
	bh=7zFP790CgcYj+YfQkmLYZzdQbrsS5QQF3BdqKTcT/5o=;
	h=Subject:To:Cc:From:Date:From;
	b=YRWlTgzTUlh8ejnrzkY5ITYGGWt5AkooEq/5wj1uUEJWPj9l1j39b9wnLS9XoVwMI
	 4XMx9Vg+u83q4pVtSlRSChjhgEco7DOikmpHMp7Tv9tP9oQQZn5k0AJuVtL2fK4jIe
	 IxgMgyrddkS/aePehGhWBsJm44bB6Afvs9k7O3zo=
Subject: FAILED: patch "[PATCH] block: freeze queue when updating zone resources" failed to apply to 6.12-stable tree
To: dlemoal@kernel.org,axboe@kernel.dk,hare@suse.de,hch@lst.de,johannes.thumshirn@wdc.com,kch@nvidia.com,martin.petersen@oracle.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Dec 2025 17:01:27 +0100
Message-ID: <2025122927-untapped-stimulate-e26d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x bba4322e3f303b2d656e748be758320b567f046f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025122927-untapped-stimulate-e26d@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From bba4322e3f303b2d656e748be758320b567f046f Mon Sep 17 00:00:00 2001
From: Damien Le Moal <dlemoal@kernel.org>
Date: Wed, 5 Nov 2025 06:22:36 +0900
Subject: [PATCH] block: freeze queue when updating zone resources

Modify disk_update_zone_resources() to freeze the device queue before
updating the number of zones, zone capacity and other zone related
resources. The locking order resulting from the call to
queue_limits_commit_update_frozen() is preserved, that is, the queue
limits lock is first taken by calling queue_limits_start_update() before
freezing the queue, and the queue is unfrozen after executing
queue_limits_commit_update(), which replaces the call to
queue_limits_commit_update_frozen().

This change ensures that there are no in-flights I/Os when the zone
resources are updated due to a zone revalidation. In case of error when
the limits are applied, directly call disk_free_zone_resources() from
disk_update_zone_resources() while the disk queue is still frozen to
avoid needing to freeze & unfreeze the queue again in
blk_revalidate_disk_zones(), thus simplifying that function code a
little.

Fixes: 0b83c86b444a ("block: Prevent potential deadlock in blk_revalidate_disk_zones()")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 1621e8f78338..39381f2b2e94 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -1557,8 +1557,13 @@ static int disk_update_zone_resources(struct gendisk *disk,
 {
 	struct request_queue *q = disk->queue;
 	unsigned int nr_seq_zones, nr_conv_zones;
-	unsigned int pool_size;
+	unsigned int pool_size, memflags;
 	struct queue_limits lim;
+	int ret = 0;
+
+	lim = queue_limits_start_update(q);
+
+	memflags = blk_mq_freeze_queue(q);
 
 	disk->nr_zones = args->nr_zones;
 	disk->zone_capacity = args->zone_capacity;
@@ -1568,11 +1573,10 @@ static int disk_update_zone_resources(struct gendisk *disk,
 	if (nr_conv_zones >= disk->nr_zones) {
 		pr_warn("%s: Invalid number of conventional zones %u / %u\n",
 			disk->disk_name, nr_conv_zones, disk->nr_zones);
-		return -ENODEV;
+		ret = -ENODEV;
+		goto unfreeze;
 	}
 
-	lim = queue_limits_start_update(q);
-
 	/*
 	 * Some devices can advertize zone resource limits that are larger than
 	 * the number of sequential zones of the zoned block device, e.g. a
@@ -1609,7 +1613,15 @@ static int disk_update_zone_resources(struct gendisk *disk,
 	}
 
 commit:
-	return queue_limits_commit_update_frozen(q, &lim);
+	ret = queue_limits_commit_update(q, &lim);
+
+unfreeze:
+	if (ret)
+		disk_free_zone_resources(disk);
+
+	blk_mq_unfreeze_queue(q, memflags);
+
+	return ret;
 }
 
 static int blk_revalidate_conv_zone(struct blk_zone *zone, unsigned int idx,
@@ -1774,7 +1786,7 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
 	sector_t zone_sectors = q->limits.chunk_sectors;
 	sector_t capacity = get_capacity(disk);
 	struct blk_revalidate_zone_args args = { };
-	unsigned int noio_flag;
+	unsigned int memflags, noio_flag;
 	int ret = -ENOMEM;
 
 	if (WARN_ON_ONCE(!blk_queue_is_zoned(q)))
@@ -1824,20 +1836,14 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
 		ret = -ENODEV;
 	}
 
-	/*
-	 * Set the new disk zone parameters only once the queue is frozen and
-	 * all I/Os are completed.
-	 */
 	if (ret > 0)
-		ret = disk_update_zone_resources(disk, &args);
-	else
-		pr_warn("%s: failed to revalidate zones\n", disk->disk_name);
-	if (ret) {
-		unsigned int memflags = blk_mq_freeze_queue(q);
+		return disk_update_zone_resources(disk, &args);
 
-		disk_free_zone_resources(disk);
-		blk_mq_unfreeze_queue(q, memflags);
-	}
+	pr_warn("%s: failed to revalidate zones\n", disk->disk_name);
+
+	memflags = blk_mq_freeze_queue(q);
+	disk_free_zone_resources(disk);
+	blk_mq_unfreeze_queue(q, memflags);
 
 	return ret;
 }


