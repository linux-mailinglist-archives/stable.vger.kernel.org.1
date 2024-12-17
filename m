Return-Path: <stable+bounces-104885-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE4C9F5388
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 18:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AB1316CF66
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 17:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055A51F893A;
	Tue, 17 Dec 2024 17:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="duDBs2xj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B492E1F8932;
	Tue, 17 Dec 2024 17:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734456400; cv=none; b=ohBXa3gAkHUH7hrvkN98DzpO8CUpY86afjZngM2xrSYVGvhODPLxz+G36oboM0esNJoMi+RhWNnNWly2pnK+XAaBEdnrDo8N9c+GKfku/fa1fbQQ9gOEl91wWtiYfeJW4wKZ6wC2W5LyiA3/s223HR2SM0Wv+T5/4ykXihb3Yv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734456400; c=relaxed/simple;
	bh=nuXWnO10mz4VrZGMoKfcL/0hlH8WGKPW5bKj4YcWpp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gWiPinmD9g1ZOGKGdn7QsITI3Ghb9YphWnUl+aU9w0dqhjRaQgqCwVryMPADJAsoR7ASgoyX3Zd5L+GofeS1PUQWzlxO5AbEtbPuA5z3F1C3UF55ocNtTDSY1YIx+sHsXXpm3MDYfS2PNfFS6a2mbg7VYyNjI3okjJlz/+ysy8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=duDBs2xj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E7F9C4CED3;
	Tue, 17 Dec 2024 17:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734456400;
	bh=nuXWnO10mz4VrZGMoKfcL/0hlH8WGKPW5bKj4YcWpp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=duDBs2xjJtE/krxPwZzNpU/qe5lORXfBMfALqIyErSWPItghaXxIZLTACD8gzwkII
	 HpCkvlTJ6OQNfKRTNqFNU+zZkfoag0Rx3Tb5eqc50S6USjOlEi+VZLS97aks/ZLRal
	 ylZbAEnKjWG4YNn0truxLjQAaiccNsCowaYl49Po=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.12 018/172] block: Use a zone write plug BIO work for REQ_NOWAIT BIOs
Date: Tue, 17 Dec 2024 18:06:14 +0100
Message-ID: <20241217170547.011862796@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241217170546.209657098@linuxfoundation.org>
References: <20241217170546.209657098@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Damien Le Moal <dlemoal@kernel.org>

commit cae005670887cb07ceafc25bb32e221e56286488 upstream.

For zoned block devices, a write BIO issued to a zone that has no
on-going writes will be prepared for execution and allowed to execute
immediately by blk_zone_wplug_handle_write() (called from
blk_zone_plug_bio()). However, if this BIO specifies REQ_NOWAIT, the
allocation of a request for its execution in blk_mq_submit_bio() may
fail after blk_zone_plug_bio() completed, marking the target zone of the
BIO as plugged. When this BIO is retried later on, it will be blocked as
the zone write plug of the target zone is in a plugged state without any
on-going write operation (completion of write operations trigger
unplugging of the next write BIOs for a zone). This leads to a BIO that
is stuck in a zone write plug and never completes, which results in
various issues such as hung tasks.

Avoid this problem by always executing REQ_NOWAIT write BIOs using the
BIO work of a zone write plug. This ensure that we never block the BIO
issuer and can thus safely ignore the REQ_NOWAIT flag when executing the
BIO from the zone write plug BIO work.

Since such BIO may be the first write BIO issued to a zone with no
on-going write, modify disk_zone_wplug_add_bio() to schedule the zone
write plug BIO work if the write plug is not already marked with the
BLK_ZONE_WPLUG_PLUGGED flag. This scheduling is otherwise not necessary
as the completion of the on-going write for the zone will schedule the
execution of the next plugged BIOs.

blk_zone_wplug_handle_write() is also fixed to better handle zone write
plug allocation failures for REQ_NOWAIT BIOs by failing a write BIO
using bio_wouldblock_error() instead of bio_io_error().

Reported-by: Bart Van Assche <bvanassche@acm.org>
Fixes: dd291d77cc90 ("block: Introduce zone write plugging")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Link: https://lore.kernel.org/r/20241209122357.47838-2-dlemoal@kernel.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 block/blk-zoned.c |   62 ++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 42 insertions(+), 20 deletions(-)

--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -759,9 +759,25 @@ static bool blk_zone_wplug_handle_reset_
 	return false;
 }
 
-static inline void blk_zone_wplug_add_bio(struct blk_zone_wplug *zwplug,
-					  struct bio *bio, unsigned int nr_segs)
+static void disk_zone_wplug_schedule_bio_work(struct gendisk *disk,
+					      struct blk_zone_wplug *zwplug)
+{
+	/*
+	 * Take a reference on the zone write plug and schedule the submission
+	 * of the next plugged BIO. blk_zone_wplug_bio_work() will release the
+	 * reference we take here.
+	 */
+	WARN_ON_ONCE(!(zwplug->flags & BLK_ZONE_WPLUG_PLUGGED));
+	refcount_inc(&zwplug->ref);
+	queue_work(disk->zone_wplugs_wq, &zwplug->bio_work);
+}
+
+static inline void disk_zone_wplug_add_bio(struct gendisk *disk,
+				struct blk_zone_wplug *zwplug,
+				struct bio *bio, unsigned int nr_segs)
 {
+	bool schedule_bio_work = false;
+
 	/*
 	 * Grab an extra reference on the BIO request queue usage counter.
 	 * This reference will be reused to submit a request for the BIO for
@@ -778,6 +794,16 @@ static inline void blk_zone_wplug_add_bi
 	bio_clear_polled(bio);
 
 	/*
+	 * REQ_NOWAIT BIOs are always handled using the zone write plug BIO
+	 * work, which can block. So clear the REQ_NOWAIT flag and schedule the
+	 * work if this is the first BIO we are plugging.
+	 */
+	if (bio->bi_opf & REQ_NOWAIT) {
+		schedule_bio_work = !(zwplug->flags & BLK_ZONE_WPLUG_PLUGGED);
+		bio->bi_opf &= ~REQ_NOWAIT;
+	}
+
+	/*
 	 * Reuse the poll cookie field to store the number of segments when
 	 * split to the hardware limits.
 	 */
@@ -790,6 +816,11 @@ static inline void blk_zone_wplug_add_bi
 	 * at the tail of the list to preserve the sequential write order.
 	 */
 	bio_list_add(&zwplug->bio_list, bio);
+
+	zwplug->flags |= BLK_ZONE_WPLUG_PLUGGED;
+
+	if (schedule_bio_work)
+		disk_zone_wplug_schedule_bio_work(disk, zwplug);
 }
 
 /*
@@ -983,7 +1014,10 @@ static bool blk_zone_wplug_handle_write(
 
 	zwplug = disk_get_and_lock_zone_wplug(disk, sector, gfp_mask, &flags);
 	if (!zwplug) {
-		bio_io_error(bio);
+		if (bio->bi_opf & REQ_NOWAIT)
+			bio_wouldblock_error(bio);
+		else
+			bio_io_error(bio);
 		return true;
 	}
 
@@ -992,9 +1026,11 @@ static bool blk_zone_wplug_handle_write(
 
 	/*
 	 * If the zone is already plugged or has a pending error, add the BIO
-	 * to the plug BIO list. Otherwise, plug and let the BIO execute.
+	 * to the plug BIO list. Do the same for REQ_NOWAIT BIOs to ensure that
+	 * we will not see a BLK_STS_AGAIN failure if we let the BIO execute.
+	 * Otherwise, plug and let the BIO execute.
 	 */
-	if (zwplug->flags & BLK_ZONE_WPLUG_BUSY)
+	if (zwplug->flags & BLK_ZONE_WPLUG_BUSY || (bio->bi_opf & REQ_NOWAIT))
 		goto plug;
 
 	/*
@@ -1011,8 +1047,7 @@ static bool blk_zone_wplug_handle_write(
 	return false;
 
 plug:
-	zwplug->flags |= BLK_ZONE_WPLUG_PLUGGED;
-	blk_zone_wplug_add_bio(zwplug, bio, nr_segs);
+	disk_zone_wplug_add_bio(disk, zwplug, bio, nr_segs);
 
 	spin_unlock_irqrestore(&zwplug->lock, flags);
 
@@ -1096,19 +1131,6 @@ bool blk_zone_plug_bio(struct bio *bio,
 }
 EXPORT_SYMBOL_GPL(blk_zone_plug_bio);
 
-static void disk_zone_wplug_schedule_bio_work(struct gendisk *disk,
-					      struct blk_zone_wplug *zwplug)
-{
-	/*
-	 * Take a reference on the zone write plug and schedule the submission
-	 * of the next plugged BIO. blk_zone_wplug_bio_work() will release the
-	 * reference we take here.
-	 */
-	WARN_ON_ONCE(!(zwplug->flags & BLK_ZONE_WPLUG_PLUGGED));
-	refcount_inc(&zwplug->ref);
-	queue_work(disk->zone_wplugs_wq, &zwplug->bio_work);
-}
-
 static void disk_zone_wplug_unplug_bio(struct gendisk *disk,
 				       struct blk_zone_wplug *zwplug)
 {



