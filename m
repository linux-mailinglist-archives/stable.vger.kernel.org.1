Return-Path: <stable+bounces-110836-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34841A1D2BC
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 09:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E5F33A8087
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 08:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D131FCF55;
	Mon, 27 Jan 2025 08:58:21 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28351FC11E;
	Mon, 27 Jan 2025 08:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737968300; cv=none; b=Qp4NMYtoR6UWNbCmKm6iwhsYKOO0Kj5idSIALzIEXpX8ZYEianPznU56ZD4nIzRYC7RNgNFunuRqGUpmFwF9nUmq4oRQ/GdnJg+uyyP8NhpCUBjQNbOAjI8BqzwulpXDfLkXkYeRPQH4ehqE7ONS2XCTzf0OdeVJqUH+b0nlp9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737968300; c=relaxed/simple;
	bh=P+uCVUy09YKWOrNy1GBTqFFjsuQfghM4T4zyRzBy3H8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xq6nF/l0vW9uLw2W7+1h0QnrnbZbTJCxIoRYSKt3YebWvJmct09/KkUFWgTpk/hrD+Rc4R6oEAW9DmPbU0oIlcWu0nA99xudTT00kjDAtEilZ2QmerEKxNu2jYspRIBMqlRkDI8L1I4dAY+Yk3s+cyAasuOgxNuUC4M9979HzZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YhMkq2fGGz4f3kFl;
	Mon, 27 Jan 2025 16:57:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 2EC5E1A1445;
	Mon, 27 Jan 2025 16:58:16 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAXe1+mSpdnShB+CA--.53281S5;
	Mon, 27 Jan 2025 16:58:16 +0800 (CST)
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
Subject: [PATCH 6.12 1/5] md/md-bitmap: factor behind write counters out from bitmap_{start/end}write()
Date: Mon, 27 Jan 2025 16:52:10 +0800
Message-Id: <20250127085214.3197761-2-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250127085214.3197761-1-yukuai1@huaweicloud.com>
References: <20250127085214.3197761-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXe1+mSpdnShB+CA--.53281S5
X-Coremail-Antispam: 1UD129KBjvJXoW3Jw4kCFW8Ar48JF48KFWDXFb_yoWfur4kpa
	9FqFy3CrW5trW3Xw1DAFyDuF1Fvw1ktr9rtrWfW3sYg3Wqyr90gF4rWFWrKwn8AFy3ZFW3
	Zan8trWUCrW2qFUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBC14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVW8ZVWrXw
	CF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j
	6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64
	vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42
	IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRuGQ6DUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

commit 08c50142a128dcb2d7060aa3b4c5db8837f7a46a upstream.

behind_write is only used in raid1, prepare to refactor
bitmap_{start/end}write(), there are no functional changes.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Xiao Ni <xni@redhat.com>
Link: https://lore.kernel.org/r/20250109015145.158868-2-yukuai1@huaweicloud.com
Signed-off-by: Song Liu <song@kernel.org>
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
index 6c9d24203f39..94d50ee8d9b9 100644
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
 
@@ -1611,9 +1612,10 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
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
index 862b1fb71d86..80873bd65851 100644
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
 
@@ -1493,8 +1492,7 @@ static void raid10_write_request(struct mddev *mddev, struct bio *bio,
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
index 2fa1f270fb1d..d08d64ae7bc0 100644
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
@@ -5788,7 +5787,7 @@ static void make_discard_request(struct mddev *mddev, struct bio *bi)
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


