Return-Path: <stable+bounces-113733-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 344BCA2936B
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 16:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0420F16AB37
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 15:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33FD70825;
	Wed,  5 Feb 2025 15:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AuaUffZn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0341519BF;
	Wed,  5 Feb 2025 15:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738767978; cv=none; b=f50A+4LeNgBhUI6AwTE2u8U+rG4sECmKx+aOAgml/zHQ1r76kqAL0weZd2Q0mA5Fsf1Q10FaKrle9pviVGIbjAUe6w+uLRBJi4C19KHq/W6YOLvULfg4bVjttCbmpuvYENjROyJuMlbpjr7LcB4REjZZ36bo33Haat+nN5eC12o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738767978; c=relaxed/simple;
	bh=GwqQ2KsU6E/77OY/7jvd5b6adLJ+XPW8F9P4lys9WSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uxKAbAX6rS/zCJEfYqyqmtGipYrIkQjcFlmzv/ejeo6N+TRNTnQfBM+78h5G1dpzom6gGtnJRhHdXakysDq8+DN962cZj4SNPM17R4XCjAP5jCTWYULyB25VSIcKxJLv6X3lr4eFsO1wXTru/qLbGSK2+AEEv7AT771GJCOSwus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AuaUffZn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 591C3C4CED1;
	Wed,  5 Feb 2025 15:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738767977;
	bh=GwqQ2KsU6E/77OY/7jvd5b6adLJ+XPW8F9P4lys9WSY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AuaUffZnDjO7YekHaqndgfC5YnRlC9mshhzbNWJPvwO/x1jMk7caXOFWv8UZGyaUW
	 IVhKGGoypJiMWLgGJI63NMeneibjinkANQKoLa3tv7zXL3VdFo5SATKL8rN7hMOsMB
	 VV8xLYhfZFtVGExUgFq2LDcAoZOtqn1FOIiEI9C8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yu Kuai <yukuai3@huawei.com>,
	Xiao Ni <xni@redhat.com>,
	Song Liu <song@kernel.org>,
	Yu Kuai <yukuai1@huaweicloud.com>
Subject: [PATCH 6.12 537/590] md/md-bitmap: factor behind write counters out from bitmap_{start/end}write()
Date: Wed,  5 Feb 2025 14:44:52 +0100
Message-ID: <20250205134515.815605314@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134455.220373560@linuxfoundation.org>
References: <20250205134455.220373560@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yu Kuai <yukuai3@huawei.com>

commit 08c50142a128dcb2d7060aa3b4c5db8837f7a46a upstream.

behind_write is only used in raid1, prepare to refactor
bitmap_{start/end}write(), there are no functional changes.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Xiao Ni <xni@redhat.com>
Link: https://lore.kernel.org/r/20250109015145.158868-2-yukuai1@huaweicloud.com
Signed-off-by: Song Liu <song@kernel.org>
Signed-off-by: Yu Kuai <yukuai1@huaweicloud.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/md-bitmap.c   |   57 +++++++++++++++++++++++++++++------------------
 drivers/md/md-bitmap.h   |    7 ++++-
 drivers/md/raid1.c       |   12 +++++----
 drivers/md/raid10.c      |    6 +---
 drivers/md/raid5-cache.c |    3 --
 drivers/md/raid5.c       |   11 ++++-----
 6 files changed, 56 insertions(+), 40 deletions(-)

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
@@ -1737,21 +1726,13 @@ static int bitmap_startwrite(struct mdde
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
@@ -2981,6 +2993,9 @@ static struct bitmap_operations bitmap_o
 	.dirty_bits		= bitmap_dirty_bits,
 	.unplug			= bitmap_unplug,
 	.daemon_work		= bitmap_daemon_work,
+
+	.start_behind_write	= bitmap_start_behind_write,
+	.end_behind_write	= bitmap_end_behind_write,
 	.wait_behind_writes	= bitmap_wait_behind_writes,
 
 	.startwrite		= bitmap_startwrite,
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
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -420,10 +420,11 @@ static void close_write(struct r1bio *r1
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
 
@@ -1611,9 +1612,10 @@ static void raid1_write_request(struct m
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
 
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -430,8 +430,7 @@ static void close_write(struct r10bio *r
 
 	/* clear the bitmap if all writes complete successfully */
 	mddev->bitmap_ops->endwrite(mddev, r10_bio->sector, r10_bio->sectors,
-				    !test_bit(R10BIO_Degraded, &r10_bio->state),
-				    false);
+				    !test_bit(R10BIO_Degraded, &r10_bio->state));
 	md_write_end(mddev);
 }
 
@@ -1493,8 +1492,7 @@ static void raid10_write_request(struct
 	md_account_bio(mddev, &bio);
 	r10_bio->master_bio = bio;
 	atomic_set(&r10_bio->remaining, 1);
-	mddev->bitmap_ops->startwrite(mddev, r10_bio->sector, r10_bio->sectors,
-				      false);
+	mddev->bitmap_ops->startwrite(mddev, r10_bio->sector, r10_bio->sectors);
 
 	for (i = 0; i < conf->copies; i++) {
 		if (r10_bio->devs[i].bio)
--- a/drivers/md/raid5-cache.c
+++ b/drivers/md/raid5-cache.c
@@ -315,8 +315,7 @@ void r5c_handle_cached_data_endio(struct
 			r5c_return_dev_pending_writes(conf, &sh->dev[i]);
 			conf->mddev->bitmap_ops->endwrite(conf->mddev,
 					sh->sector, RAID5_STRIPE_SECTORS(conf),
-					!test_bit(STRIPE_DEGRADED, &sh->state),
-					false);
+					!test_bit(STRIPE_DEGRADED, &sh->state));
 		}
 	}
 }
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -3564,7 +3564,7 @@ static void __add_stripe_bio(struct stri
 		set_bit(STRIPE_BITMAP_PENDING, &sh->state);
 		spin_unlock_irq(&sh->stripe_lock);
 		conf->mddev->bitmap_ops->startwrite(conf->mddev, sh->sector,
-					RAID5_STRIPE_SECTORS(conf), false);
+					RAID5_STRIPE_SECTORS(conf));
 		spin_lock_irq(&sh->stripe_lock);
 		clear_bit(STRIPE_BITMAP_PENDING, &sh->state);
 		if (!sh->batch_head) {
@@ -3665,7 +3665,7 @@ handle_failed_stripe(struct r5conf *conf
 		if (bitmap_end)
 			conf->mddev->bitmap_ops->endwrite(conf->mddev,
 					sh->sector, RAID5_STRIPE_SECTORS(conf),
-					false, false);
+					false);
 		bitmap_end = 0;
 		/* and fail all 'written' */
 		bi = sh->dev[i].written;
@@ -3712,7 +3712,7 @@ handle_failed_stripe(struct r5conf *conf
 		if (bitmap_end)
 			conf->mddev->bitmap_ops->endwrite(conf->mddev,
 					sh->sector, RAID5_STRIPE_SECTORS(conf),
-					false, false);
+					false);
 		/* If we were in the middle of a write the parity block might
 		 * still be locked - so just clear all R5_LOCKED flags
 		 */
@@ -4063,8 +4063,7 @@ returnbi:
 				}
 				conf->mddev->bitmap_ops->endwrite(conf->mddev,
 					sh->sector, RAID5_STRIPE_SECTORS(conf),
-					!test_bit(STRIPE_DEGRADED, &sh->state),
-					false);
+					!test_bit(STRIPE_DEGRADED, &sh->state));
 				if (head_sh->batch_head) {
 					sh = list_first_entry(&sh->batch_list,
 							      struct stripe_head,
@@ -5788,7 +5787,7 @@ static void make_discard_request(struct
 			for (d = 0; d < conf->raid_disks - conf->max_degraded;
 			     d++)
 				mddev->bitmap_ops->startwrite(mddev, sh->sector,
-					RAID5_STRIPE_SECTORS(conf), false);
+					RAID5_STRIPE_SECTORS(conf));
 			sh->bm_seq = conf->seq_flush + 1;
 			set_bit(STRIPE_BIT_DELAY, &sh->state);
 		}



