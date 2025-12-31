Return-Path: <stable+bounces-204401-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C47CECACD
	for <lists+stable@lfdr.de>; Thu, 01 Jan 2026 00:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98C00300FF91
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 23:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD41F309EE4;
	Wed, 31 Dec 2025 23:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/hxC/R8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A34528690
	for <stable@vger.kernel.org>; Wed, 31 Dec 2025 23:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767224411; cv=none; b=iX14M350CF1CflcALXcMK4c5kC4gLcPrKsX6dzuuJFBErub3lIzkmLZkywaa8dq98KqXggpO9dcrTWYUeUXIibJaSLNy34W+QIjPrYRX3kjomDMOAyKJqKzPIZ6R2oow1MNev/s7M7rXlFBPXMKViE2z/AuRv05vnZgkDzPfG9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767224411; c=relaxed/simple;
	bh=bTNK/NzpItlrn2L1s9RFuqABJGpnJ9zSGtLHcWNg2o0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IQm+Bd3FuJd1cEtQ8VOMsmB0eNnRIo1+Qan/7XMZ7JAKE/yZJ9q7uFYx+fCHV0ESo2l2jBjBystrdxIF5EjNgA3hjptFxW9Wd5SFmjoS9ddFUioX/8PaG1WvixIxFNOGPKIO/iKgbiI5T6ImNkJRdPRBmRDsfXn6ORXUQ2SY1Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/hxC/R8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4240BC113D0;
	Wed, 31 Dec 2025 23:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767224411;
	bh=bTNK/NzpItlrn2L1s9RFuqABJGpnJ9zSGtLHcWNg2o0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R/hxC/R8gFo6WBjfXnNM/TMJCurQT5Exh95/EWMzix+YXR6/TWTeYxUC/4fYzPq7N
	 eR48L9M0Rpsm9KzoHAmqraubzuf2a9erELUr/twl517sR9R3XtORmmdOZ4L2fsNpml
	 eAxegq9/n/PDYSBA2zuwv7q3oTyApm5Qk4MSep2N0R2ibMYyI248zanOmgtcOSC+j5
	 brcm1l4q6Ecb5ipet3XpHNpzcj/lH1Km97EqnplqZm2f/uZiQgfZOgp34m6+T3WsT0
	 vDnERHGnOSJJEwTf1Q/quZ9nUn61dpEc+rdIV50fajvyTwCQ2gwv/katuM061QTPEZ
	 Gs16OWIrEcReg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] block: freeze queue when updating zone resources
Date: Wed, 31 Dec 2025 18:40:07 -0500
Message-ID: <20251231234008.3701023-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025122927-untapped-stimulate-e26d@gregkh>
References: <2025122927-untapped-stimulate-e26d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Damien Le Moal <dlemoal@kernel.org>

[ Upstream commit bba4322e3f303b2d656e748be758320b567f046f ]

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
[ adapted blk_mq_freeze_queue/unfreeze_queue calls to single-argument void API ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-zoned.c | 39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index f1160cc2cf85..858efd19d9a6 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -1510,6 +1510,11 @@ static int disk_update_zone_resources(struct gendisk *disk,
 	unsigned int nr_seq_zones, nr_conv_zones;
 	unsigned int pool_size;
 	struct queue_limits lim;
+	int ret = 0;
+
+	lim = queue_limits_start_update(q);
+
+	blk_mq_freeze_queue(q);
 
 	disk->nr_zones = args->nr_zones;
 	disk->zone_capacity = args->zone_capacity;
@@ -1519,11 +1524,10 @@ static int disk_update_zone_resources(struct gendisk *disk,
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
@@ -1560,7 +1564,15 @@ static int disk_update_zone_resources(struct gendisk *disk,
 	}
 
 commit:
-	return queue_limits_commit_update_frozen(q, &lim);
+	ret = queue_limits_commit_update(q, &lim);
+
+unfreeze:
+	if (ret)
+		disk_free_zone_resources(disk);
+
+	blk_mq_unfreeze_queue(q);
+
+	return ret;
 }
 
 static int blk_revalidate_conv_zone(struct blk_zone *zone, unsigned int idx,
@@ -1781,19 +1793,14 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
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
-		blk_mq_freeze_queue(q);
-		disk_free_zone_resources(disk);
-		blk_mq_unfreeze_queue(q);
-	}
+		return disk_update_zone_resources(disk, &args);
+
+	pr_warn("%s: failed to revalidate zones\n", disk->disk_name);
+
+	blk_mq_freeze_queue(q);
+	disk_free_zone_resources(disk);
+	blk_mq_unfreeze_queue(q);
 
 	return ret;
 }
-- 
2.51.0


