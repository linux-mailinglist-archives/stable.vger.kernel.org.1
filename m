Return-Path: <stable+bounces-110834-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F269A1D2AB
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 09:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F00873A781B
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 08:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC1C1FCF7D;
	Mon, 27 Jan 2025 08:56:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FAB1FCF5B;
	Mon, 27 Jan 2025 08:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737968176; cv=none; b=n02E2KyRezIl88q8jXLpA/4eNHQLT9rOE/NBJJPtVqC5aO3q+HNPdKEvMXZu1Q/oD1RkCVAtBY3gTGKy3FmPtBW825RJgiBhAfB3H+exCrJK2Y1m9WfKav2lptTNKIPgRnvzBGLq+oZxXTxUDScIFmN9knCeO2hXTUowrPJBMjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737968176; c=relaxed/simple;
	bh=OdsdbWSsfdpHcnGm9OxK6Bez66RUaJXJ1xLvIBymvMU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uqDnf4Kk0kUgK+P/HA60LZrFqXd3uYRxIX7qX6TWDVSOGB0hVjsGh5JS26229yEaN+T8mPOOdwB1/UlPmM5EYyTMVyenPJ8hl/btrxhtOCjcZLDUriEQ7sGdUM+fU0rCMS2Q5t3p3TnBrwJd7jV3Vu+85gMvJGiJ+7bC4Did+CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YhMgg3BbSz4f3kFn;
	Mon, 27 Jan 2025 16:55:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 3DCEC1A0B23;
	Mon, 27 Jan 2025 16:55:32 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCnC2ABSpdnDuF9CA--.54166S5;
	Mon, 27 Jan 2025 16:55:32 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	song@kernel.org,
	yukuai3@huawei.com
Cc: linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH 6.13 1/5] md/md-bitmap: factor behind write counters out from bitmap_{start/end}write()
Date: Mon, 27 Jan 2025 16:49:24 +0800
Message-Id: <20250127084928.3197157-2-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250127084928.3197157-1-yukuai1@huaweicloud.com>
References: <20250127084928.3197157-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCnC2ABSpdnDuF9CA--.54166S5
X-Coremail-Antispam: 1UD129KBjvJXoW3Jw4kCFW8Ar48JF48KFWDXFb_yoWfuFy7pa
	9FqFyakrW5trWaqw1DAFyDuFyFvw1ktr9rtrWfW3sYg3Wqyr90gF4rWFWrKrn8AFy3ZFW3
	Zan8trWUCrW2qFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBl14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
	r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r1q6r43Mx
	AIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_
	Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwI
	xGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWx
	JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcV
	C2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbloGJUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

commit 08c50142a128dcb2d7060aa3b4c5db8837f7a46a upstream.

behind_write is only used in raid1, prepare to refactor
bitmap_{start/end}write(), there are no functional changes.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Xiao Ni <xni@redhat.com>
Link: https://lore.kernel.org/r/20250109015145.158868-2-yukuai1@huaweicloud.com
Signed-off-by: Song Liu <song@kernel.org>
Signed-off-by: Yu Kuai <yukuai1@huaweicloud.com>
---
 drivers/md/md-bitmap.c   | 57 +++++++++++++++++++++++++---------------
 drivers/md/md-bitmap.h   |  7 +++--
 drivers/md/raid1.c       | 12 +++++----
 drivers/md/raid10.c      |  6 ++---
 drivers/md/raid5-cache.c |  3 +--
 drivers/md/raid5.c       | 11 ++++----
 6 files changed, 56 insertions(+), 40 deletions(-)

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index c3a42dd66ce5..84fb4cc67d5e 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -1671,24 +1671,13 @@ __acquires(bitmap->lock)
 }
 
 static int bitmap_startwrite(struct mddev *mddev, sector_t offset,
-			     unsigned long sectors, bool behind)
+			     unsigned long sectors)
 {
 	struct bitmap *bitmap = mddev->bitmap;
 
 	if (!bitmap)
 		return 0;
 
-	if (behind) {
-		int bw;
-		atomic_inc(&bitmap->behind_writes);
-		bw = atomic_read(&bitmap->behind_writes);
-		if (bw > bitmap->behind_writes_used)
-			bitmap->behind_writes_used = bw;
-
-		pr_debug("inc write-behind count %d/%lu\n",
-			 bw, bitmap->mddev->bitmap_info.max_write_behind);
-	}
-
 	while (sectors) {
 		sector_t blocks;
 		bitmap_counter_t *bmc;
@@ -1737,21 +1726,13 @@ static int bitmap_startwrite(struct mddev *mddev, sector_t offset,
 }
 
 static void bitmap_endwrite(struct mddev *mddev, sector_t offset,
-			    unsigned long sectors, bool success, bool behind)
+			    unsigned long sectors, bool success)
 {
 	struct bitmap *bitmap = mddev->bitmap;
 
 	if (!bitmap)
 		return;
 
-	if (behind) {
-		if (atomic_dec_and_test(&bitmap->behind_writes))
-			wake_up(&bitmap->behind_wait);
-		pr_debug("dec write-behind count %d/%lu\n",
-			 atomic_read(&bitmap->behind_writes),
-			 bitmap->mddev->bitmap_info.max_write_behind);
-	}
-
 	while (sectors) {
 		sector_t blocks;
 		unsigned long flags;
@@ -2062,6 +2043,37 @@ static void md_bitmap_free(void *data)
 	kfree(bitmap);
 }
 
+static void bitmap_start_behind_write(struct mddev *mddev)
+{
+	struct bitmap *bitmap = mddev->bitmap;
+	int bw;
+
+	if (!bitmap)
+		return;
+
+	atomic_inc(&bitmap->behind_writes);
+	bw = atomic_read(&bitmap->behind_writes);
+	if (bw > bitmap->behind_writes_used)
+		bitmap->behind_writes_used = bw;
+
+	pr_debug("inc write-behind count %d/%lu\n",
+		 bw, bitmap->mddev->bitmap_info.max_write_behind);
+}
+
+static void bitmap_end_behind_write(struct mddev *mddev)
+{
+	struct bitmap *bitmap = mddev->bitmap;
+
+	if (!bitmap)
+		return;
+
+	if (atomic_dec_and_test(&bitmap->behind_writes))
+		wake_up(&bitmap->behind_wait);
+	pr_debug("dec write-behind count %d/%lu\n",
+		 atomic_read(&bitmap->behind_writes),
+		 bitmap->mddev->bitmap_info.max_write_behind);
+}
+
 static void bitmap_wait_behind_writes(struct mddev *mddev)
 {
 	struct bitmap *bitmap = mddev->bitmap;
@@ -2981,6 +2993,9 @@ static struct bitmap_operations bitmap_ops = {
 	.dirty_bits		= bitmap_dirty_bits,
 	.unplug			= bitmap_unplug,
 	.daemon_work		= bitmap_daemon_work,
+
+	.start_behind_write	= bitmap_start_behind_write,
+	.end_behind_write	= bitmap_end_behind_write,
 	.wait_behind_writes	= bitmap_wait_behind_writes,
 
 	.startwrite		= bitmap_startwrite,
diff --git a/drivers/md/md-bitmap.h b/drivers/md/md-bitmap.h
index 662e6fc141a7..e87a1f493d3c 100644
--- a/drivers/md/md-bitmap.h
+++ b/drivers/md/md-bitmap.h
@@ -84,12 +84,15 @@ struct bitmap_operations {
 			   unsigned long e);
 	void (*unplug)(struct mddev *mddev, bool sync);
 	void (*daemon_work)(struct mddev *mddev);
+
+	void (*start_behind_write)(struct mddev *mddev);
+	void (*end_behind_write)(struct mddev *mddev);
 	void (*wait_behind_writes)(struct mddev *mddev);
 
 	int (*startwrite)(struct mddev *mddev, sector_t offset,
-			  unsigned long sectors, bool behind);
+			  unsigned long sectors);
 	void (*endwrite)(struct mddev *mddev, sector_t offset,
-			 unsigned long sectors, bool success, bool behind);
+			 unsigned long sectors, bool success);
 	bool (*start_sync)(struct mddev *mddev, sector_t offset,
 			   sector_t *blocks, bool degraded);
 	void (*end_sync)(struct mddev *mddev, sector_t offset, sector_t *blocks);
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 519c56f0ee3d..15ba7a001f30 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -420,10 +420,11 @@ static void close_write(struct r1bio *r1_bio)
 		r1_bio->behind_master_bio = NULL;
 	}
 
+	if (test_bit(R1BIO_BehindIO, &r1_bio->state))
+		mddev->bitmap_ops->end_behind_write(mddev);
 	/* clear the bitmap if all writes complete successfully */
 	mddev->bitmap_ops->endwrite(mddev, r1_bio->sector, r1_bio->sectors,
-				    !test_bit(R1BIO_Degraded, &r1_bio->state),
-				    test_bit(R1BIO_BehindIO, &r1_bio->state));
+				    !test_bit(R1BIO_Degraded, &r1_bio->state));
 	md_write_end(mddev);
 }
 
@@ -1645,9 +1646,10 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 			    stats.behind_writes < max_write_behind)
 				alloc_behind_master_bio(r1_bio, bio);
 
-			mddev->bitmap_ops->startwrite(
-				mddev, r1_bio->sector, r1_bio->sectors,
-				test_bit(R1BIO_BehindIO, &r1_bio->state));
+			if (test_bit(R1BIO_BehindIO, &r1_bio->state))
+				mddev->bitmap_ops->start_behind_write(mddev);
+			mddev->bitmap_ops->startwrite(mddev, r1_bio->sector,
+						      r1_bio->sectors);
 			first_clone = 0;
 		}
 
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 7d7a8a2524dc..c3a93b2a26a6 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -430,8 +430,7 @@ static void close_write(struct r10bio *r10_bio)
 
 	/* clear the bitmap if all writes complete successfully */
 	mddev->bitmap_ops->endwrite(mddev, r10_bio->sector, r10_bio->sectors,
-				    !test_bit(R10BIO_Degraded, &r10_bio->state),
-				    false);
+				    !test_bit(R10BIO_Degraded, &r10_bio->state));
 	md_write_end(mddev);
 }
 
@@ -1519,8 +1518,7 @@ static void raid10_write_request(struct mddev *mddev, struct bio *bio,
 	md_account_bio(mddev, &bio);
 	r10_bio->master_bio = bio;
 	atomic_set(&r10_bio->remaining, 1);
-	mddev->bitmap_ops->startwrite(mddev, r10_bio->sector, r10_bio->sectors,
-				      false);
+	mddev->bitmap_ops->startwrite(mddev, r10_bio->sector, r10_bio->sectors);
 
 	for (i = 0; i < conf->copies; i++) {
 		if (r10_bio->devs[i].bio)
diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
index b4f7b79fd187..4c7ecdd5c1f3 100644
--- a/drivers/md/raid5-cache.c
+++ b/drivers/md/raid5-cache.c
@@ -315,8 +315,7 @@ void r5c_handle_cached_data_endio(struct r5conf *conf,
 			r5c_return_dev_pending_writes(conf, &sh->dev[i]);
 			conf->mddev->bitmap_ops->endwrite(conf->mddev,
 					sh->sector, RAID5_STRIPE_SECTORS(conf),
-					!test_bit(STRIPE_DEGRADED, &sh->state),
-					false);
+					!test_bit(STRIPE_DEGRADED, &sh->state));
 		}
 	}
 }
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index f09e7677ee9f..93cc7e252dd4 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -3564,7 +3564,7 @@ static void __add_stripe_bio(struct stripe_head *sh, struct bio *bi,
 		set_bit(STRIPE_BITMAP_PENDING, &sh->state);
 		spin_unlock_irq(&sh->stripe_lock);
 		conf->mddev->bitmap_ops->startwrite(conf->mddev, sh->sector,
-					RAID5_STRIPE_SECTORS(conf), false);
+					RAID5_STRIPE_SECTORS(conf));
 		spin_lock_irq(&sh->stripe_lock);
 		clear_bit(STRIPE_BITMAP_PENDING, &sh->state);
 		if (!sh->batch_head) {
@@ -3665,7 +3665,7 @@ handle_failed_stripe(struct r5conf *conf, struct stripe_head *sh,
 		if (bitmap_end)
 			conf->mddev->bitmap_ops->endwrite(conf->mddev,
 					sh->sector, RAID5_STRIPE_SECTORS(conf),
-					false, false);
+					false);
 		bitmap_end = 0;
 		/* and fail all 'written' */
 		bi = sh->dev[i].written;
@@ -3712,7 +3712,7 @@ handle_failed_stripe(struct r5conf *conf, struct stripe_head *sh,
 		if (bitmap_end)
 			conf->mddev->bitmap_ops->endwrite(conf->mddev,
 					sh->sector, RAID5_STRIPE_SECTORS(conf),
-					false, false);
+					false);
 		/* If we were in the middle of a write the parity block might
 		 * still be locked - so just clear all R5_LOCKED flags
 		 */
@@ -4063,8 +4063,7 @@ static void handle_stripe_clean_event(struct r5conf *conf,
 				}
 				conf->mddev->bitmap_ops->endwrite(conf->mddev,
 					sh->sector, RAID5_STRIPE_SECTORS(conf),
-					!test_bit(STRIPE_DEGRADED, &sh->state),
-					false);
+					!test_bit(STRIPE_DEGRADED, &sh->state));
 				if (head_sh->batch_head) {
 					sh = list_first_entry(&sh->batch_list,
 							      struct stripe_head,
@@ -5787,7 +5786,7 @@ static void make_discard_request(struct mddev *mddev, struct bio *bi)
 			for (d = 0; d < conf->raid_disks - conf->max_degraded;
 			     d++)
 				mddev->bitmap_ops->startwrite(mddev, sh->sector,
-					RAID5_STRIPE_SECTORS(conf), false);
+					RAID5_STRIPE_SECTORS(conf));
 			sh->bm_seq = conf->seq_flush + 1;
 			set_bit(STRIPE_BIT_DELAY, &sh->state);
 		}
-- 
2.39.2


