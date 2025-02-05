Return-Path: <stable+bounces-113735-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7B8A292DE
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 16:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 937AB7A23B6
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 15:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5327535946;
	Wed,  5 Feb 2025 15:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AHyovahj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC0B1E89C;
	Wed,  5 Feb 2025 15:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738767985; cv=none; b=Hz9vI5cCxgwbVkQgApjyy4qHH1ZbDN2JALyCpTyxVAfZI27bzLH7Wo+DcsZrvWTYryQjGLLAmjv9MA4DhAnZPG1KRC2LR420fNGOC8cmmDN8EPoFgkF5b7myTBgWGvNeu4eJZiJDAq9XRWMV+1UF6wGiWmp1LHWjzWXk9l5UuxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738767985; c=relaxed/simple;
	bh=oQMYZOoVoq+kgSBsWjhIxmailB5OUA9vxtaWhWEy2ns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r8pYfmIBoDBk5T7026RA8FM98UBHfoQN+7KpdetYfUUAvwNXfYzJ8kcQxlyJZ2S6EsilTjjDOgRtPA1VBT1ERP1rIWb1B8qXGIsqn0FE6YRP0R1rTKQn7Q1NggvKQLBN80zEJONLKtILoqD7KeoejSwZ/dQQxjtBKEkukMVJ2Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AHyovahj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06E42C4CED1;
	Wed,  5 Feb 2025 15:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738767984;
	bh=oQMYZOoVoq+kgSBsWjhIxmailB5OUA9vxtaWhWEy2ns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AHyovahjB4oEnqwfvmnUuxxv6yByZdle9VFTJgllSymxd877qiaUBDrMjg77QoPGq
	 spP1Kfikwf3G+1oD2dk6takuWxsOJPm0sPO48LQSegcv91+HUGb2Xdyu2HY3JgXcur
	 0hNJKwrzERTsANHaB+GvYy4ft/46dqOVV8dG/css=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yu Kuai <yukuai3@huawei.com>,
	Song Liu <song@kernel.org>,
	Yu Kuai <yukuai1@huaweicloud.com>
Subject: [PATCH 6.12 538/590] md/md-bitmap: remove the last parameter for bimtap_ops->endwrite()
Date: Wed,  5 Feb 2025 14:44:53 +0100
Message-ID: <20250205134515.853405280@linuxfoundation.org>
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

commit 4f0e7d0e03b7b80af84759a9e7cfb0f81ac4adae upstream.

For the case that IO failed for one rdev, the bit will be mark as NEEDED
in following cases:

1) If badblocks is set and rdev is not faulty;
2) If rdev is faulty;

Case 1) is useless because synchronize data to badblocks make no sense.
Case 2) can be replaced with mddev->degraded.

Also remove R1BIO_Degraded, R10BIO_Degraded and STRIPE_DEGRADED since
case 2) no longer use them.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Link: https://lore.kernel.org/r/20250109015145.158868-3-yukuai1@huaweicloud.com
Signed-off-by: Song Liu <song@kernel.org>
Signed-off-by: Yu Kuai <yukuai1@huaweicloud.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/md-bitmap.c   |   19 ++++++++++---------
 drivers/md/md-bitmap.h   |    2 +-
 drivers/md/raid1.c       |   26 +++-----------------------
 drivers/md/raid1.h       |    1 -
 drivers/md/raid10.c      |   23 +++--------------------
 drivers/md/raid10.h      |    1 -
 drivers/md/raid5-cache.c |    3 +--
 drivers/md/raid5.c       |   15 +++------------
 drivers/md/raid5.h       |    1 -
 9 files changed, 21 insertions(+), 70 deletions(-)

--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -1726,7 +1726,7 @@ static int bitmap_startwrite(struct mdde
 }
 
 static void bitmap_endwrite(struct mddev *mddev, sector_t offset,
-			    unsigned long sectors, bool success)
+			    unsigned long sectors)
 {
 	struct bitmap *bitmap = mddev->bitmap;
 
@@ -1745,15 +1745,16 @@ static void bitmap_endwrite(struct mddev
 			return;
 		}
 
-		if (success && !bitmap->mddev->degraded &&
-		    bitmap->events_cleared < bitmap->mddev->events) {
-			bitmap->events_cleared = bitmap->mddev->events;
-			bitmap->need_sync = 1;
-			sysfs_notify_dirent_safe(bitmap->sysfs_can_clear);
-		}
-
-		if (!success && !NEEDED(*bmc))
+		if (!bitmap->mddev->degraded) {
+			if (bitmap->events_cleared < bitmap->mddev->events) {
+				bitmap->events_cleared = bitmap->mddev->events;
+				bitmap->need_sync = 1;
+				sysfs_notify_dirent_safe(
+						bitmap->sysfs_can_clear);
+			}
+		} else if (!NEEDED(*bmc)) {
 			*bmc |= NEEDED_MASK;
+		}
 
 		if (COUNTER(*bmc) == COUNTER_MAX)
 			wake_up(&bitmap->overflow_wait);
--- a/drivers/md/md-bitmap.h
+++ b/drivers/md/md-bitmap.h
@@ -92,7 +92,7 @@ struct bitmap_operations {
 	int (*startwrite)(struct mddev *mddev, sector_t offset,
 			  unsigned long sectors);
 	void (*endwrite)(struct mddev *mddev, sector_t offset,
-			 unsigned long sectors, bool success);
+			 unsigned long sectors);
 	bool (*start_sync)(struct mddev *mddev, sector_t offset,
 			   sector_t *blocks, bool degraded);
 	void (*end_sync)(struct mddev *mddev, sector_t offset, sector_t *blocks);
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -423,8 +423,7 @@ static void close_write(struct r1bio *r1
 	if (test_bit(R1BIO_BehindIO, &r1_bio->state))
 		mddev->bitmap_ops->end_behind_write(mddev);
 	/* clear the bitmap if all writes complete successfully */
-	mddev->bitmap_ops->endwrite(mddev, r1_bio->sector, r1_bio->sectors,
-				    !test_bit(R1BIO_Degraded, &r1_bio->state));
+	mddev->bitmap_ops->endwrite(mddev, r1_bio->sector, r1_bio->sectors);
 	md_write_end(mddev);
 }
 
@@ -481,8 +480,6 @@ static void raid1_end_write_request(stru
 		if (!test_bit(Faulty, &rdev->flags))
 			set_bit(R1BIO_WriteError, &r1_bio->state);
 		else {
-			/* Fail the request */
-			set_bit(R1BIO_Degraded, &r1_bio->state);
 			/* Finished with this branch */
 			r1_bio->bios[mirror] = NULL;
 			to_put = bio;
@@ -1493,11 +1490,8 @@ static void raid1_write_request(struct m
 			break;
 		}
 		r1_bio->bios[i] = NULL;
-		if (!rdev || test_bit(Faulty, &rdev->flags)) {
-			if (i < conf->raid_disks)
-				set_bit(R1BIO_Degraded, &r1_bio->state);
+		if (!rdev || test_bit(Faulty, &rdev->flags))
 			continue;
-		}
 
 		atomic_inc(&rdev->nr_pending);
 		if (test_bit(WriteErrorSeen, &rdev->flags)) {
@@ -1523,16 +1517,6 @@ static void raid1_write_request(struct m
 					 */
 					max_sectors = bad_sectors;
 				rdev_dec_pending(rdev, mddev);
-				/* We don't set R1BIO_Degraded as that
-				 * only applies if the disk is
-				 * missing, so it might be re-added,
-				 * and we want to know to recover this
-				 * chunk.
-				 * In this case the device is here,
-				 * and the fact that this chunk is not
-				 * in-sync is recorded in the bad
-				 * block log
-				 */
 				continue;
 			}
 			if (is_bad) {
@@ -2569,12 +2553,10 @@ static void handle_write_finished(struct
 			 * errors.
 			 */
 			fail = true;
-			if (!narrow_write_error(r1_bio, m)) {
+			if (!narrow_write_error(r1_bio, m))
 				md_error(conf->mddev,
 					 conf->mirrors[m].rdev);
 				/* an I/O failed, we can't clear the bitmap */
-				set_bit(R1BIO_Degraded, &r1_bio->state);
-			}
 			rdev_dec_pending(conf->mirrors[m].rdev,
 					 conf->mddev);
 		}
@@ -2665,8 +2647,6 @@ static void raid1d(struct md_thread *thr
 			list_del(&r1_bio->retry_list);
 			idx = sector_to_idx(r1_bio->sector);
 			atomic_dec(&conf->nr_queued[idx]);
-			if (mddev->degraded)
-				set_bit(R1BIO_Degraded, &r1_bio->state);
 			if (test_bit(R1BIO_WriteError, &r1_bio->state))
 				close_write(r1_bio);
 			raid_end_bio_io(r1_bio);
--- a/drivers/md/raid1.h
+++ b/drivers/md/raid1.h
@@ -188,7 +188,6 @@ struct r1bio {
 enum r1bio_state {
 	R1BIO_Uptodate,
 	R1BIO_IsSync,
-	R1BIO_Degraded,
 	R1BIO_BehindIO,
 /* Set ReadError on bios that experience a readerror so that
  * raid1d knows what to do with them.
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -429,8 +429,7 @@ static void close_write(struct r10bio *r
 	struct mddev *mddev = r10_bio->mddev;
 
 	/* clear the bitmap if all writes complete successfully */
-	mddev->bitmap_ops->endwrite(mddev, r10_bio->sector, r10_bio->sectors,
-				    !test_bit(R10BIO_Degraded, &r10_bio->state));
+	mddev->bitmap_ops->endwrite(mddev, r10_bio->sector, r10_bio->sectors);
 	md_write_end(mddev);
 }
 
@@ -500,7 +499,6 @@ static void raid10_end_write_request(str
 				set_bit(R10BIO_WriteError, &r10_bio->state);
 			else {
 				/* Fail the request */
-				set_bit(R10BIO_Degraded, &r10_bio->state);
 				r10_bio->devs[slot].bio = NULL;
 				to_put = bio;
 				dec_rdev = 1;
@@ -1429,10 +1427,8 @@ static void raid10_write_request(struct
 		r10_bio->devs[i].bio = NULL;
 		r10_bio->devs[i].repl_bio = NULL;
 
-		if (!rdev && !rrdev) {
-			set_bit(R10BIO_Degraded, &r10_bio->state);
+		if (!rdev && !rrdev)
 			continue;
-		}
 		if (rdev && test_bit(WriteErrorSeen, &rdev->flags)) {
 			sector_t first_bad;
 			sector_t dev_sector = r10_bio->devs[i].addr;
@@ -1449,14 +1445,6 @@ static void raid10_write_request(struct
 					 * to other devices yet
 					 */
 					max_sectors = bad_sectors;
-				/* We don't set R10BIO_Degraded as that
-				 * only applies if the disk is missing,
-				 * so it might be re-added, and we want to
-				 * know to recover this chunk.
-				 * In this case the device is here, and the
-				 * fact that this chunk is not in-sync is
-				 * recorded in the bad block log.
-				 */
 				continue;
 			}
 			if (is_bad) {
@@ -2908,11 +2896,8 @@ static void handle_write_completed(struc
 				rdev_dec_pending(rdev, conf->mddev);
 			} else if (bio != NULL && bio->bi_status) {
 				fail = true;
-				if (!narrow_write_error(r10_bio, m)) {
+				if (!narrow_write_error(r10_bio, m))
 					md_error(conf->mddev, rdev);
-					set_bit(R10BIO_Degraded,
-						&r10_bio->state);
-				}
 				rdev_dec_pending(rdev, conf->mddev);
 			}
 			bio = r10_bio->devs[m].repl_bio;
@@ -2971,8 +2956,6 @@ static void raid10d(struct md_thread *th
 			r10_bio = list_first_entry(&tmp, struct r10bio,
 						   retry_list);
 			list_del(&r10_bio->retry_list);
-			if (mddev->degraded)
-				set_bit(R10BIO_Degraded, &r10_bio->state);
 
 			if (test_bit(R10BIO_WriteError,
 				     &r10_bio->state))
--- a/drivers/md/raid10.h
+++ b/drivers/md/raid10.h
@@ -161,7 +161,6 @@ enum r10bio_state {
 	R10BIO_IsSync,
 	R10BIO_IsRecover,
 	R10BIO_IsReshape,
-	R10BIO_Degraded,
 /* Set ReadError on bios that experience a read error
  * so that raid10d knows what to do with them.
  */
--- a/drivers/md/raid5-cache.c
+++ b/drivers/md/raid5-cache.c
@@ -314,8 +314,7 @@ void r5c_handle_cached_data_endio(struct
 			set_bit(R5_UPTODATE, &sh->dev[i].flags);
 			r5c_return_dev_pending_writes(conf, &sh->dev[i]);
 			conf->mddev->bitmap_ops->endwrite(conf->mddev,
-					sh->sector, RAID5_STRIPE_SECTORS(conf),
-					!test_bit(STRIPE_DEGRADED, &sh->state));
+					sh->sector, RAID5_STRIPE_SECTORS(conf));
 		}
 	}
 }
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -1345,8 +1345,6 @@ again:
 				submit_bio_noacct(rbi);
 		}
 		if (!rdev && !rrdev) {
-			if (op_is_write(op))
-				set_bit(STRIPE_DEGRADED, &sh->state);
 			pr_debug("skip op %d on disc %d for sector %llu\n",
 				bi->bi_opf, i, (unsigned long long)sh->sector);
 			clear_bit(R5_LOCKED, &sh->dev[i].flags);
@@ -2884,7 +2882,6 @@ static void raid5_end_write_request(stru
 			set_bit(R5_MadeGoodRepl, &sh->dev[i].flags);
 	} else {
 		if (bi->bi_status) {
-			set_bit(STRIPE_DEGRADED, &sh->state);
 			set_bit(WriteErrorSeen, &rdev->flags);
 			set_bit(R5_WriteError, &sh->dev[i].flags);
 			if (!test_and_set_bit(WantReplacement, &rdev->flags))
@@ -3664,8 +3661,7 @@ handle_failed_stripe(struct r5conf *conf
 		}
 		if (bitmap_end)
 			conf->mddev->bitmap_ops->endwrite(conf->mddev,
-					sh->sector, RAID5_STRIPE_SECTORS(conf),
-					false);
+					sh->sector, RAID5_STRIPE_SECTORS(conf));
 		bitmap_end = 0;
 		/* and fail all 'written' */
 		bi = sh->dev[i].written;
@@ -3711,8 +3707,7 @@ handle_failed_stripe(struct r5conf *conf
 		}
 		if (bitmap_end)
 			conf->mddev->bitmap_ops->endwrite(conf->mddev,
-					sh->sector, RAID5_STRIPE_SECTORS(conf),
-					false);
+					sh->sector, RAID5_STRIPE_SECTORS(conf));
 		/* If we were in the middle of a write the parity block might
 		 * still be locked - so just clear all R5_LOCKED flags
 		 */
@@ -4062,8 +4057,7 @@ returnbi:
 					wbi = wbi2;
 				}
 				conf->mddev->bitmap_ops->endwrite(conf->mddev,
-					sh->sector, RAID5_STRIPE_SECTORS(conf),
-					!test_bit(STRIPE_DEGRADED, &sh->state));
+					sh->sector, RAID5_STRIPE_SECTORS(conf));
 				if (head_sh->batch_head) {
 					sh = list_first_entry(&sh->batch_list,
 							      struct stripe_head,
@@ -4340,7 +4334,6 @@ static void handle_parity_checks5(struct
 		s->locked++;
 		set_bit(R5_Wantwrite, &dev->flags);
 
-		clear_bit(STRIPE_DEGRADED, &sh->state);
 		set_bit(STRIPE_INSYNC, &sh->state);
 		break;
 	case check_state_run:
@@ -4497,7 +4490,6 @@ static void handle_parity_checks6(struct
 			clear_bit(R5_Wantwrite, &dev->flags);
 			s->locked--;
 		}
-		clear_bit(STRIPE_DEGRADED, &sh->state);
 
 		set_bit(STRIPE_INSYNC, &sh->state);
 		break;
@@ -4900,7 +4892,6 @@ static void break_stripe_batch_list(stru
 
 		set_mask_bits(&sh->state, ~(STRIPE_EXPAND_SYNC_FLAGS |
 					    (1 << STRIPE_PREREAD_ACTIVE) |
-					    (1 << STRIPE_DEGRADED) |
 					    (1 << STRIPE_ON_UNPLUG_LIST)),
 			      head_sh->state & (1 << STRIPE_INSYNC));
 
--- a/drivers/md/raid5.h
+++ b/drivers/md/raid5.h
@@ -358,7 +358,6 @@ enum {
 	STRIPE_REPLACED,
 	STRIPE_PREREAD_ACTIVE,
 	STRIPE_DELAYED,
-	STRIPE_DEGRADED,
 	STRIPE_BIT_DELAY,
 	STRIPE_EXPANDING,
 	STRIPE_EXPAND_SOURCE,



