Return-Path: <stable+bounces-110833-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD651A1D29F
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 09:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0AFB1886FB1
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 08:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A00D1FCF57;
	Mon, 27 Jan 2025 08:55:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3441FC11E;
	Mon, 27 Jan 2025 08:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737968145; cv=none; b=JmSWTpRrDsVvkiDKLoGlPWUI74N7dVhnkFhsLGHhn4VIHEke3AFupml0DQtOEn5UcnYuUMCgyy/HfaTpu2gdfQ6kJwmE/aT1dUlP/sPrqrjP9FsK2twMiJSeEbFQTyoHSFMs4JXOODkaH4BEKW5INuS7JA3d14UelMafhZDXL28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737968145; c=relaxed/simple;
	bh=baw++KmU6RjznWk/5+lhUXbpkLQX0JXHwYlBUIAzu58=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZEXppHeiL+1lhhURPsM4oY5/NLK5iTanPySHtjLrQ6GqFmpDyO+00NJdKw3oLGzFtCYHwIcBkEw5R+I/2iE5wMT5deMkcKh7KXJExPpd3fQ078hE5ecp6ICKwQQBTMg4UIbuBh8bI5V6IIlnlxXTXe8+UR9MOQ6+O0qHfyPNWBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YhMgj0pW3z4f3jR6;
	Mon, 27 Jan 2025 16:55:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E11EE1A181C;
	Mon, 27 Jan 2025 16:55:33 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCnC2ABSpdnDuF9CA--.54166S9;
	Mon, 27 Jan 2025 16:55:33 +0800 (CST)
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
Subject: [PATCH 6.13 5/5] md/md-bitmap: move bitmap_{start, end}write to md upper layer
Date: Mon, 27 Jan 2025 16:49:28 +0800
Message-Id: <20250127084928.3197157-6-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250127084928.3197157-1-yukuai1@huaweicloud.com>
References: <20250127084928.3197157-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCnC2ABSpdnDuF9CA--.54166S9
X-Coremail-Antispam: 1UD129KBjvAXoW3ZrWrtr15XF48Gr4Utr4fXwb_yoW8Gr1DJo
	Z7Zry5Xrn5Gr48X34rAr45JFW3WryDJry5A345GryDXF9rXrnYqw1IkrW3Jr1jqr13XF43
	Xr17J3WUJr1UJr1Dn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUOU7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
	j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s0DM28Irc
	Ia0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l
	84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJV
	WxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE
	3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2I
	x0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8
	JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_Jw
	0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AK
	xVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrx
	kI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v2
	6F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
	1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU1zpBDUU
	UUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

commit cd5fc653381811f1e0ba65f5d169918cab61476f upstream.

There are two BUG reports that raid5 will hang at
bitmap_startwrite([1],[2]), root cause is that bitmap start write and end
write is unbalanced, it's not quite clear where, and while reviewing raid5
code, it's found that bitmap operations can be optimized. For example,
for a 4 disks raid5, with chunksize=8k, if user issue a IO (0 + 48k) to
the array:

┌────────────────────────────────────────────────────────────┐
│chunk 0                                                     │
│      ┌────────────┬─────────────┬─────────────┬────────────┼
│  sh0 │A0: 0 + 4k  │A1: 8k + 4k  │A2: 16k + 4k │A3: P       │
│      ┼────────────┼─────────────┼─────────────┼────────────┼
│  sh1 │B0: 4k + 4k │B1: 12k + 4k │B2: 20k + 4k │B3: P       │
┼──────┴────────────┴─────────────┴─────────────┴────────────┼
│chunk 1                                                     │
│      ┌────────────┬─────────────┬─────────────┬────────────┤
│  sh2 │C0: 24k + 4k│C1: 32k + 4k │C2: P        │C3: 40k + 4k│
│      ┼────────────┼─────────────┼─────────────┼────────────┼
│  sh3 │D0: 28k + 4k│D1: 36k + 4k │D2: P        │D3: 44k + 4k│
└──────┴────────────┴─────────────┴─────────────┴────────────┘

Before this patch, 4 stripe head will be used, and each sh will attach
bio for 3 disks, and each attached bio will trigger
bitmap_startwrite() once, which means total 12 times.
 - 3 times (0 + 4k), for (A0, A1 and A2)
 - 3 times (4 + 4k), for (B0, B1 and B2)
 - 3 times (8 + 4k), for (C0, C1 and C3)
 - 3 times (12 + 4k), for (D0, D1 and D3)

After this patch, md upper layer will calculate that IO range (0 + 48k)
is corresponding to the bitmap (0 + 16k), and call bitmap_startwrite()
just once.

Noted that this patch will align bitmap ranges to the chunks, for example,
if user issue a IO (0 + 4k) to array:

- Before this patch, 1 time (0 + 4k), for A0;
- After this patch, 1 time (0 + 8k) for chunk 0;

Usually, one bitmap bit will represent more than one disk chunk, and this
doesn't have any difference. And even if user really created a array
that one chunk contain multiple bits, the overhead is that more data
will be recovered after power failure.

Also remove STRIPE_BITMAP_PENDING since it's not used anymore.

[1] https://lore.kernel.org/all/CAJpMwyjmHQLvm6zg1cmQErttNNQPDAAXPKM3xgTjMhbfts986Q@mail.gmail.com/
[2] https://lore.kernel.org/all/ADF7D720-5764-4AF3-B68E-1845988737AA@flyingcircus.io/

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Link: https://lore.kernel.org/r/20250109015145.158868-6-yukuai1@huaweicloud.com
Signed-off-by: Song Liu <song@kernel.org>
Signed-off-by: Yu Kuai <yukuai1@huaweicloud.com>
---
 drivers/md/md.c          | 29 +++++++++++++++++++++++
 drivers/md/md.h          |  2 ++
 drivers/md/raid1.c       |  4 ----
 drivers/md/raid10.c      |  3 ---
 drivers/md/raid5-cache.c |  2 --
 drivers/md/raid5.c       | 50 +++++-----------------------------------
 drivers/md/raid5.h       |  3 ---
 7 files changed, 37 insertions(+), 56 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index aebe12b0ee27..c60ae2c70102 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -8745,12 +8745,32 @@ void md_submit_discard_bio(struct mddev *mddev, struct md_rdev *rdev,
 }
 EXPORT_SYMBOL_GPL(md_submit_discard_bio);
 
+static void md_bitmap_start(struct mddev *mddev,
+			    struct md_io_clone *md_io_clone)
+{
+	if (mddev->pers->bitmap_sector)
+		mddev->pers->bitmap_sector(mddev, &md_io_clone->offset,
+					   &md_io_clone->sectors);
+
+	mddev->bitmap_ops->startwrite(mddev, md_io_clone->offset,
+				      md_io_clone->sectors);
+}
+
+static void md_bitmap_end(struct mddev *mddev, struct md_io_clone *md_io_clone)
+{
+	mddev->bitmap_ops->endwrite(mddev, md_io_clone->offset,
+				    md_io_clone->sectors);
+}
+
 static void md_end_clone_io(struct bio *bio)
 {
 	struct md_io_clone *md_io_clone = bio->bi_private;
 	struct bio *orig_bio = md_io_clone->orig_bio;
 	struct mddev *mddev = md_io_clone->mddev;
 
+	if (bio_data_dir(orig_bio) == WRITE && mddev->bitmap)
+		md_bitmap_end(mddev, md_io_clone);
+
 	if (bio->bi_status && !orig_bio->bi_status)
 		orig_bio->bi_status = bio->bi_status;
 
@@ -8775,6 +8795,12 @@ static void md_clone_bio(struct mddev *mddev, struct bio **bio)
 	if (blk_queue_io_stat(bdev->bd_disk->queue))
 		md_io_clone->start_time = bio_start_io_acct(*bio);
 
+	if (bio_data_dir(*bio) == WRITE && mddev->bitmap) {
+		md_io_clone->offset = (*bio)->bi_iter.bi_sector;
+		md_io_clone->sectors = bio_sectors(*bio);
+		md_bitmap_start(mddev, md_io_clone);
+	}
+
 	clone->bi_end_io = md_end_clone_io;
 	clone->bi_private = md_io_clone;
 	*bio = clone;
@@ -8793,6 +8819,9 @@ void md_free_cloned_bio(struct bio *bio)
 	struct bio *orig_bio = md_io_clone->orig_bio;
 	struct mddev *mddev = md_io_clone->mddev;
 
+	if (bio_data_dir(orig_bio) == WRITE && mddev->bitmap)
+		md_bitmap_end(mddev, md_io_clone);
+
 	if (bio->bi_status && !orig_bio->bi_status)
 		orig_bio->bi_status = bio->bi_status;
 
diff --git a/drivers/md/md.h b/drivers/md/md.h
index de6dadb9a40b..def808064ad8 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -831,6 +831,8 @@ struct md_io_clone {
 	struct mddev	*mddev;
 	struct bio	*orig_bio;
 	unsigned long	start_time;
+	sector_t	offset;
+	unsigned long	sectors;
 	struct bio	bio_clone;
 };
 
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 4d09d85321b6..a5cd6522fc2d 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -422,8 +422,6 @@ static void close_write(struct r1bio *r1_bio)
 
 	if (test_bit(R1BIO_BehindIO, &r1_bio->state))
 		mddev->bitmap_ops->end_behind_write(mddev);
-	/* clear the bitmap if all writes complete successfully */
-	mddev->bitmap_ops->endwrite(mddev, r1_bio->sector, r1_bio->sectors);
 	md_write_end(mddev);
 }
 
@@ -1632,8 +1630,6 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 
 			if (test_bit(R1BIO_BehindIO, &r1_bio->state))
 				mddev->bitmap_ops->start_behind_write(mddev);
-			mddev->bitmap_ops->startwrite(mddev, r1_bio->sector,
-						      r1_bio->sectors);
 			first_clone = 0;
 		}
 
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 340a4710c222..e1e6cd7fb125 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -428,8 +428,6 @@ static void close_write(struct r10bio *r10_bio)
 {
 	struct mddev *mddev = r10_bio->mddev;
 
-	/* clear the bitmap if all writes complete successfully */
-	mddev->bitmap_ops->endwrite(mddev, r10_bio->sector, r10_bio->sectors);
 	md_write_end(mddev);
 }
 
@@ -1506,7 +1504,6 @@ static void raid10_write_request(struct mddev *mddev, struct bio *bio,
 	md_account_bio(mddev, &bio);
 	r10_bio->master_bio = bio;
 	atomic_set(&r10_bio->remaining, 1);
-	mddev->bitmap_ops->startwrite(mddev, r10_bio->sector, r10_bio->sectors);
 
 	for (i = 0; i < conf->copies; i++) {
 		if (r10_bio->devs[i].bio)
diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
index ba4f9577c737..011246e16a99 100644
--- a/drivers/md/raid5-cache.c
+++ b/drivers/md/raid5-cache.c
@@ -313,8 +313,6 @@ void r5c_handle_cached_data_endio(struct r5conf *conf,
 		if (sh->dev[i].written) {
 			set_bit(R5_UPTODATE, &sh->dev[i].flags);
 			r5c_return_dev_pending_writes(conf, &sh->dev[i]);
-			conf->mddev->bitmap_ops->endwrite(conf->mddev,
-					sh->sector, RAID5_STRIPE_SECTORS(conf));
 		}
 	}
 }
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index a08f49b47b7e..5c79429acc64 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -906,8 +906,7 @@ static bool stripe_can_batch(struct stripe_head *sh)
 	if (raid5_has_log(conf) || raid5_has_ppl(conf))
 		return false;
 	return test_bit(STRIPE_BATCH_READY, &sh->state) &&
-		!test_bit(STRIPE_BITMAP_PENDING, &sh->state) &&
-		is_full_stripe_write(sh);
+	       is_full_stripe_write(sh);
 }
 
 /* we only do back search */
@@ -3545,29 +3544,9 @@ static void __add_stripe_bio(struct stripe_head *sh, struct bio *bi,
 		 (*bip)->bi_iter.bi_sector, sh->sector, dd_idx,
 		 sh->dev[dd_idx].sector);
 
-	if (conf->mddev->bitmap && firstwrite) {
-		/* Cannot hold spinlock over bitmap_startwrite,
-		 * but must ensure this isn't added to a batch until
-		 * we have added to the bitmap and set bm_seq.
-		 * So set STRIPE_BITMAP_PENDING to prevent
-		 * batching.
-		 * If multiple __add_stripe_bio() calls race here they
-		 * much all set STRIPE_BITMAP_PENDING.  So only the first one
-		 * to complete "bitmap_startwrite" gets to set
-		 * STRIPE_BIT_DELAY.  This is important as once a stripe
-		 * is added to a batch, STRIPE_BIT_DELAY cannot be changed
-		 * any more.
-		 */
-		set_bit(STRIPE_BITMAP_PENDING, &sh->state);
-		spin_unlock_irq(&sh->stripe_lock);
-		conf->mddev->bitmap_ops->startwrite(conf->mddev, sh->sector,
-					RAID5_STRIPE_SECTORS(conf));
-		spin_lock_irq(&sh->stripe_lock);
-		clear_bit(STRIPE_BITMAP_PENDING, &sh->state);
-		if (!sh->batch_head) {
-			sh->bm_seq = conf->seq_flush+1;
-			set_bit(STRIPE_BIT_DELAY, &sh->state);
-		}
+	if (conf->mddev->bitmap && firstwrite && !sh->batch_head) {
+		sh->bm_seq = conf->seq_flush+1;
+		set_bit(STRIPE_BIT_DELAY, &sh->state);
 	}
 }
 
@@ -3618,7 +3597,6 @@ handle_failed_stripe(struct r5conf *conf, struct stripe_head *sh,
 	BUG_ON(sh->batch_head);
 	for (i = disks; i--; ) {
 		struct bio *bi;
-		int bitmap_end = 0;
 
 		if (test_bit(R5_ReadError, &sh->dev[i].flags)) {
 			struct md_rdev *rdev = conf->disks[i].rdev;
@@ -3643,8 +3621,6 @@ handle_failed_stripe(struct r5conf *conf, struct stripe_head *sh,
 		sh->dev[i].towrite = NULL;
 		sh->overwrite_disks = 0;
 		spin_unlock_irq(&sh->stripe_lock);
-		if (bi)
-			bitmap_end = 1;
 
 		log_stripe_write_finished(sh);
 
@@ -3659,10 +3635,6 @@ handle_failed_stripe(struct r5conf *conf, struct stripe_head *sh,
 			bio_io_error(bi);
 			bi = nextbi;
 		}
-		if (bitmap_end)
-			conf->mddev->bitmap_ops->endwrite(conf->mddev,
-					sh->sector, RAID5_STRIPE_SECTORS(conf));
-		bitmap_end = 0;
 		/* and fail all 'written' */
 		bi = sh->dev[i].written;
 		sh->dev[i].written = NULL;
@@ -3671,7 +3643,6 @@ handle_failed_stripe(struct r5conf *conf, struct stripe_head *sh,
 			sh->dev[i].page = sh->dev[i].orig_page;
 		}
 
-		if (bi) bitmap_end = 1;
 		while (bi && bi->bi_iter.bi_sector <
 		       sh->dev[i].sector + RAID5_STRIPE_SECTORS(conf)) {
 			struct bio *bi2 = r5_next_bio(conf, bi, sh->dev[i].sector);
@@ -3705,9 +3676,6 @@ handle_failed_stripe(struct r5conf *conf, struct stripe_head *sh,
 				bi = nextbi;
 			}
 		}
-		if (bitmap_end)
-			conf->mddev->bitmap_ops->endwrite(conf->mddev,
-					sh->sector, RAID5_STRIPE_SECTORS(conf));
 		/* If we were in the middle of a write the parity block might
 		 * still be locked - so just clear all R5_LOCKED flags
 		 */
@@ -4056,8 +4024,7 @@ static void handle_stripe_clean_event(struct r5conf *conf,
 					bio_endio(wbi);
 					wbi = wbi2;
 				}
-				conf->mddev->bitmap_ops->endwrite(conf->mddev,
-					sh->sector, RAID5_STRIPE_SECTORS(conf));
+
 				if (head_sh->batch_head) {
 					sh = list_first_entry(&sh->batch_list,
 							      struct stripe_head,
@@ -4882,8 +4849,7 @@ static void break_stripe_batch_list(struct stripe_head *head_sh,
 					  (1 << STRIPE_COMPUTE_RUN)  |
 					  (1 << STRIPE_DISCARD) |
 					  (1 << STRIPE_BATCH_READY) |
-					  (1 << STRIPE_BATCH_ERR) |
-					  (1 << STRIPE_BITMAP_PENDING)),
+					  (1 << STRIPE_BATCH_ERR)),
 			"stripe state: %lx\n", sh->state);
 		WARN_ONCE(head_sh->state & ((1 << STRIPE_DISCARD) |
 					      (1 << STRIPE_REPLACED)),
@@ -5774,10 +5740,6 @@ static void make_discard_request(struct mddev *mddev, struct bio *bi)
 		}
 		spin_unlock_irq(&sh->stripe_lock);
 		if (conf->mddev->bitmap) {
-			for (d = 0; d < conf->raid_disks - conf->max_degraded;
-			     d++)
-				mddev->bitmap_ops->startwrite(mddev, sh->sector,
-					RAID5_STRIPE_SECTORS(conf));
 			sh->bm_seq = conf->seq_flush + 1;
 			set_bit(STRIPE_BIT_DELAY, &sh->state);
 		}
diff --git a/drivers/md/raid5.h b/drivers/md/raid5.h
index 69000fb90bd5..eafc6e9ed6ee 100644
--- a/drivers/md/raid5.h
+++ b/drivers/md/raid5.h
@@ -371,9 +371,6 @@ enum {
 	STRIPE_ON_RELEASE_LIST,
 	STRIPE_BATCH_READY,
 	STRIPE_BATCH_ERR,
-	STRIPE_BITMAP_PENDING,	/* Being added to bitmap, don't add
-				 * to batch yet.
-				 */
 	STRIPE_LOG_TRAPPED,	/* trapped into log (see raid5-cache.c)
 				 * this bit is used in two scenarios:
 				 *
-- 
2.39.2


