Return-Path: <stable+bounces-204835-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BC5CF4589
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 16:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4202B30AAD39
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 15:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8EAD2417C3;
	Mon,  5 Jan 2026 15:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cY/7RHPq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AE63A1E6D
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 15:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767625865; cv=none; b=rqQH53C6oEHtCKfalhpZXhXzQRgMU/vn/2emZ/tRc3qkkraHZk3l68DOjeJH+52NByIQati+rHzDPn6TfXK/Bi5CFBSSTlNwM34bN4XlzWRnHRhXzr8ev8giV04BF8tOjcK71jQlmKDgzQ4e3+MA/eDtyxh9EmPIazOqmW7pVzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767625865; c=relaxed/simple;
	bh=Q5fHDRmoPgUs5dmwzU4t6qK7nn5NMtMfNQr8IycEM8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rQY17RgpLd8QZRTzbFyNBS/mPmUDqauj+IB05EgfxZhnHnIOx1Xtm7T1dh2kF39aqFDNzNO9R1NcdEZdnaR7KvKvuFb9vFmU4VY80338WJMgfA2k7NO5z73giPyNR1G7Z6PP76FdhrkcIBdldBTHJ+DKez1bq8zt+M+ZlQqthGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cY/7RHPq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E74B5C116D0;
	Mon,  5 Jan 2026 15:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767625864;
	bh=Q5fHDRmoPgUs5dmwzU4t6qK7nn5NMtMfNQr8IycEM8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cY/7RHPqwPEUtJVsA6GhPi+NCEVQv/670BhF9MJPZqh3+n2SZFhCxMEHs3Kngq3EZ
	 +HB6QHhTMD3nH5xSCf/9aHRJ0PUIBt+Z7h4LSEBrZffIi6FhmKCPc1yko5jDopsX9T
	 b/geusMVgb803QU7HCEUevAHBed8gWaQlWclFFlRIbgO8kS8FjJ1LWrhs/ExVljcKj
	 A2ZNLzBH6+3b4098E28crfMi1dfjqxsqJ9WWVAUPy/JPRVfPhPcFWEmR2KanSV9QH5
	 D25WUygnWGtqPRdpf7gmu775VXkfI/NQrN6B606RRVMKgA0kCVmO9WMwd4X18qaLRU
	 6LtU2vISXsqwQ==
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
Subject: [PATCH 6.12.y] block: handle zone management operations completions
Date: Mon,  5 Jan 2026 10:11:02 -0500
Message-ID: <20260105151102.2626035-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026010502-speak-resubmit-7be4@gregkh>
References: <2026010502-speak-resubmit-7be4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Damien Le Moal <dlemoal@kernel.org>

[ Upstream commit efae226c2ef19528ffd81d29ba0eecf1b0896ca2 ]

The functions blk_zone_wplug_handle_reset_or_finish() and
blk_zone_wplug_handle_reset_all() both modify the zone write pointer
offset of zone write plugs that are the target of a reset, reset all or
finish zone management operation. However, these functions do this
modification before the BIO is executed. So if the zone operation fails,
the modified zone write pointer offsets become invalid.

Avoid this by modifying the zone write pointer offset of a zone write
plug that is the target of a zone management operation when the
operation completes. To do so, modify blk_zone_bio_endio() to call the
new function blk_zone_mgmt_bio_endio() which in turn calls the functions
blk_zone_reset_all_bio_endio(), blk_zone_reset_bio_endio() or
blk_zone_finish_bio_endio() depending on the operation of the completed
BIO, to modify a zone write plug write pointer offset accordingly.
These functions are called only if the BIO execution was successful.

Fixes: dd291d77cc90 ("block: Introduce zone write plugging")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
[ adapted bdev_zone_is_seq() check to disk_zone_is_conv() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-zoned.c | 141 ++++++++++++++++++++++++++++++----------------
 block/blk.h       |  14 +++++
 2 files changed, 106 insertions(+), 49 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index f1160cc2cf85..8aefc267837f 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -73,6 +73,11 @@ struct blk_zone_wplug {
 	struct gendisk		*disk;
 };
 
+static inline unsigned int disk_zone_wplugs_hash_size(struct gendisk *disk)
+{
+	return 1U << disk->zone_wplugs_hash_bits;
+}
+
 /*
  * Zone write plug flags bits:
  *  - BLK_ZONE_WPLUG_PLUGGED: Indicates that the zone write plug is plugged,
@@ -708,71 +713,91 @@ static int disk_zone_sync_wp_offset(struct gendisk *disk, sector_t sector)
 					disk_report_zones_cb, &args);
 }
 
-static bool blk_zone_wplug_handle_reset_or_finish(struct bio *bio,
-						  unsigned int wp_offset)
+static void blk_zone_reset_bio_endio(struct bio *bio)
 {
 	struct gendisk *disk = bio->bi_bdev->bd_disk;
-	sector_t sector = bio->bi_iter.bi_sector;
 	struct blk_zone_wplug *zwplug;
-	unsigned long flags;
-
-	/* Conventional zones cannot be reset nor finished. */
-	if (disk_zone_is_conv(disk, sector)) {
-		bio_io_error(bio);
-		return true;
-	}
 
 	/*
-	 * No-wait reset or finish BIOs do not make much sense as the callers
-	 * issue these as blocking operations in most cases. To avoid issues
-	 * the BIO execution potentially failing with BLK_STS_AGAIN, warn about
-	 * REQ_NOWAIT being set and ignore that flag.
-	 */
-	if (WARN_ON_ONCE(bio->bi_opf & REQ_NOWAIT))
-		bio->bi_opf &= ~REQ_NOWAIT;
-
-	/*
-	 * If we have a zone write plug, set its write pointer offset to 0
-	 * (reset case) or to the zone size (finish case). This will abort all
-	 * BIOs plugged for the target zone. It is fine as resetting or
-	 * finishing zones while writes are still in-flight will result in the
+	 * If we have a zone write plug, set its write pointer offset to 0.
+	 * This will abort all BIOs plugged for the target zone. It is fine as
+	 * resetting zones while writes are still in-flight will result in the
 	 * writes failing anyway.
 	 */
-	zwplug = disk_get_zone_wplug(disk, sector);
+	zwplug = disk_get_zone_wplug(disk, bio->bi_iter.bi_sector);
 	if (zwplug) {
+		unsigned long flags;
+
 		spin_lock_irqsave(&zwplug->lock, flags);
-		disk_zone_wplug_set_wp_offset(disk, zwplug, wp_offset);
+		disk_zone_wplug_set_wp_offset(disk, zwplug, 0);
 		spin_unlock_irqrestore(&zwplug->lock, flags);
 		disk_put_zone_wplug(zwplug);
 	}
-
-	return false;
 }
 
-static bool blk_zone_wplug_handle_reset_all(struct bio *bio)
+static void blk_zone_reset_all_bio_endio(struct bio *bio)
 {
 	struct gendisk *disk = bio->bi_bdev->bd_disk;
 	struct blk_zone_wplug *zwplug;
 	unsigned long flags;
-	sector_t sector;
+	unsigned int i;
 
-	/*
-	 * Set the write pointer offset of all zone write plugs to 0. This will
-	 * abort all plugged BIOs. It is fine as resetting zones while writes
-	 * are still in-flight will result in the writes failing anyway.
-	 */
-	for (sector = 0; sector < get_capacity(disk);
-	     sector += disk->queue->limits.chunk_sectors) {
-		zwplug = disk_get_zone_wplug(disk, sector);
-		if (zwplug) {
+	/* Update the condition of all zone write plugs. */
+	rcu_read_lock();
+	for (i = 0; i < disk_zone_wplugs_hash_size(disk); i++) {
+		hlist_for_each_entry_rcu(zwplug, &disk->zone_wplugs_hash[i],
+					 node) {
 			spin_lock_irqsave(&zwplug->lock, flags);
 			disk_zone_wplug_set_wp_offset(disk, zwplug, 0);
 			spin_unlock_irqrestore(&zwplug->lock, flags);
-			disk_put_zone_wplug(zwplug);
 		}
 	}
+	rcu_read_unlock();
+}
 
-	return false;
+static void blk_zone_finish_bio_endio(struct bio *bio)
+{
+	struct block_device *bdev = bio->bi_bdev;
+	struct gendisk *disk = bdev->bd_disk;
+	struct blk_zone_wplug *zwplug;
+
+	/*
+	 * If we have a zone write plug, set its write pointer offset to the
+	 * zone size. This will abort all BIOs plugged for the target zone. It
+	 * is fine as resetting zones while writes are still in-flight will
+	 * result in the writes failing anyway.
+	 */
+	zwplug = disk_get_zone_wplug(disk, bio->bi_iter.bi_sector);
+	if (zwplug) {
+		unsigned long flags;
+
+		spin_lock_irqsave(&zwplug->lock, flags);
+		disk_zone_wplug_set_wp_offset(disk, zwplug,
+					      bdev_zone_sectors(bdev));
+		spin_unlock_irqrestore(&zwplug->lock, flags);
+		disk_put_zone_wplug(zwplug);
+	}
+}
+
+void blk_zone_mgmt_bio_endio(struct bio *bio)
+{
+	/* If the BIO failed, we have nothing to do. */
+	if (bio->bi_status != BLK_STS_OK)
+		return;
+
+	switch (bio_op(bio)) {
+	case REQ_OP_ZONE_RESET:
+		blk_zone_reset_bio_endio(bio);
+		return;
+	case REQ_OP_ZONE_RESET_ALL:
+		blk_zone_reset_all_bio_endio(bio);
+		return;
+	case REQ_OP_ZONE_FINISH:
+		blk_zone_finish_bio_endio(bio);
+		return;
+	default:
+		return;
+	}
 }
 
 static void disk_zone_wplug_schedule_bio_work(struct gendisk *disk,
@@ -1115,6 +1140,32 @@ static void blk_zone_wplug_handle_native_zone_append(struct bio *bio)
 	disk_put_zone_wplug(zwplug);
 }
 
+static bool blk_zone_wplug_handle_zone_mgmt(struct bio *bio)
+{
+	struct gendisk *disk = bio->bi_bdev->bd_disk;
+
+	if (bio_op(bio) != REQ_OP_ZONE_RESET_ALL &&
+	    disk_zone_is_conv(disk, bio->bi_iter.bi_sector)) {
+		/*
+		 * Zone reset and zone finish operations do not apply to
+		 * conventional zones.
+		 */
+		bio_io_error(bio);
+		return true;
+	}
+
+	/*
+	 * No-wait zone management BIOs do not make much sense as the callers
+	 * issue these as blocking operations in most cases. To avoid issues
+	 * with the BIO execution potentially failing with BLK_STS_AGAIN, warn
+	 * about REQ_NOWAIT being set and ignore that flag.
+	 */
+	if (WARN_ON_ONCE(bio->bi_opf & REQ_NOWAIT))
+		bio->bi_opf &= ~REQ_NOWAIT;
+
+	return false;
+}
+
 /**
  * blk_zone_plug_bio - Handle a zone write BIO with zone write plugging
  * @bio: The BIO being submitted
@@ -1162,12 +1213,9 @@ bool blk_zone_plug_bio(struct bio *bio, unsigned int nr_segs)
 	case REQ_OP_WRITE_ZEROES:
 		return blk_zone_wplug_handle_write(bio, nr_segs);
 	case REQ_OP_ZONE_RESET:
-		return blk_zone_wplug_handle_reset_or_finish(bio, 0);
 	case REQ_OP_ZONE_FINISH:
-		return blk_zone_wplug_handle_reset_or_finish(bio,
-						bdev_zone_sectors(bdev));
 	case REQ_OP_ZONE_RESET_ALL:
-		return blk_zone_wplug_handle_reset_all(bio);
+		return blk_zone_wplug_handle_zone_mgmt(bio);
 	default:
 		return false;
 	}
@@ -1324,11 +1372,6 @@ static void blk_zone_wplug_bio_work(struct work_struct *work)
 	disk_put_zone_wplug(zwplug);
 }
 
-static inline unsigned int disk_zone_wplugs_hash_size(struct gendisk *disk)
-{
-	return 1U << disk->zone_wplugs_hash_bits;
-}
-
 void disk_init_zone_resources(struct gendisk *disk)
 {
 	spin_lock_init(&disk->zone_wplugs_lock);
diff --git a/block/blk.h b/block/blk.h
index e91012247ff2..63c92db0a507 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -486,9 +486,23 @@ static inline void blk_zone_update_request_bio(struct request *rq,
 	    bio_flagged(bio, BIO_EMULATES_ZONE_APPEND))
 		bio->bi_iter.bi_sector = rq->__sector;
 }
+void blk_zone_mgmt_bio_endio(struct bio *bio);
 void blk_zone_write_plug_bio_endio(struct bio *bio);
 static inline void blk_zone_bio_endio(struct bio *bio)
 {
+	/*
+	 * Zone management BIOs may impact zone write plugs (e.g. a zone reset
+	 * changes a zone write plug zone write pointer offset), but these
+	 * operation do not go through zone write plugging as they may operate
+	 * on zones that do not have a zone write
+	 * plug. blk_zone_mgmt_bio_endio() handles the potential changes to zone
+	 * write plugs that are present.
+	 */
+	if (op_is_zone_mgmt(bio_op(bio))) {
+		blk_zone_mgmt_bio_endio(bio);
+		return;
+	}
+
 	/*
 	 * For write BIOs to zoned devices, signal the completion of the BIO so
 	 * that the next write BIO can be submitted by zone write plugging.
-- 
2.51.0


