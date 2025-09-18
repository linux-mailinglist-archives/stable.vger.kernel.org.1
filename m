Return-Path: <stable+bounces-173437-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB42B35CC9
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06ABC7C5459
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 11:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A5129D273;
	Tue, 26 Aug 2025 11:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bBi16d0D"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677CA20330;
	Tue, 26 Aug 2025 11:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756208246; cv=none; b=cZ6aur5iWVeRaog8Xom3s2eiUkuliR1s4/UdQLEwFtjlTP6NRk49duD8rtaDzVdmwCEreYwf0roA5WNSR9zgVURtSORxpp6IrRfS3RX7mrH/z+kmbfmkHU9UKakSg87UiGbjcge1OZh7h/jxuH3CwaCBCtoseDjV/5jxVf5ABLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756208246; c=relaxed/simple;
	bh=QHuQoPWyqNxoZ1AEvsdYSkGnHIj8335MwwQsLueoJ2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iJgta3usX8ujBUd02fMt1hinknQ2AW3JhJDXhm8x9H1b+wSGTBHoxb/zcF6M0rz227iZSNN3/jNKQzM0DHmfMS8E1onAbbdn3+FbXZX/SfoTqQ1zp/6ZjUJj/6INbiKTLYTE8JI0dWBDsxYeptr/ZFoWYcVjTrfpgQ4rdlK1vCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bBi16d0D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7B59C116B1;
	Tue, 26 Aug 2025 11:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756208246;
	bh=QHuQoPWyqNxoZ1AEvsdYSkGnHIj8335MwwQsLueoJ2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bBi16d0DJGKgWqlKAJGJ4BTS8P6Rp5DYBPdGpOKxcrLbUNXh8InjlXWXRkwogLErb
	 nWL0j/Qz6tpdHWoYGf2N0I3quB7B2KsZQJtGZHQdWYIymSdt3WqRPiyavCN7t+M/uF
	 yQOGYD+3sArao93Ss/bJvZW+5ONZWhhyouwwBqTo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Damien Le Moal <dlemoal@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.12 006/322] dm: dm-crypt: Do not partially accept write BIOs with zoned targets
Date: Tue, 26 Aug 2025 13:07:01 +0200
Message-ID: <20250826110915.355780605@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110915.169062587@linuxfoundation.org>
References: <20250826110915.169062587@linuxfoundation.org>
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

From: Damien Le Moal <dlemoal@kernel.org>

commit e549663849e5bb3b985dc2d293069f0d9747ae72 upstream.

Read and write operations issued to a dm-crypt target may be split
according to the dm-crypt internal limits defined by the max_read_size
and max_write_size module parameters (default is 128 KB). The intent is
to improve processing time of large BIOs by splitting them into smaller
operations that can be parallelized on different CPUs.

For zoned dm-crypt targets, this BIO splitting is still done but without
the parallel execution to ensure that the issuing order of write
operations to the underlying devices remains sequential. However, the
splitting itself causes other problems:

1) Since dm-crypt relies on the block layer zone write plugging to
   handle zone append emulation using regular write operations, the
   reminder of a split write BIO will always be plugged into the target
   zone write plugged. Once the on-going write BIO finishes, this
   reminder BIO is unplugged and issued from the zone write plug work.
   If this reminder BIO itself needs to be split, the reminder will be
   re-issued and plugged again, but that causes a call to a
   blk_queue_enter(), which may block if a queue freeze operation was
   initiated. This results in a deadlock as DM submission still holds
   BIOs that the queue freeze side is waiting for.

2) dm-crypt relies on the emulation done by the block layer using
   regular write operations for processing zone append operations. This
   still requires to properly return the written sector as the BIO
   sector of the original BIO. However, this can be done correctly only
   and only if there is a single clone BIO used for processing the
   original zone append operation issued by the user. If the size of a
   zone append operation is larger than dm-crypt max_write_size, then
   the orginal BIO will be split and processed as a chain of regular
   write operations. Such chaining result in an incorrect written sector
   being returned to the zone append issuer using the original BIO
   sector.  This in turn results in file system data corruptions using
   xfs or btrfs.

Fix this by modifying get_max_request_size() to always return the size
of the BIO to avoid it being split with dm_accpet_partial_bio() in
crypt_map(). get_max_request_size() is renamed to
get_max_request_sectors() to clarify the unit of the value returned
and its interface is changed to take a struct dm_target pointer and a
pointer to the struct bio being processed. In addition to this change,
to ensure that crypt_alloc_buffer() works correctly, set the dm-crypt
device max_hw_sectors limit to be at most
BIO_MAX_VECS << PAGE_SECTORS_SHIFT (1 MB with a 4KB page architecture).
This forces DM core to split write BIOs before passing them to
crypt_map(), and thus guaranteeing that dm-crypt can always accept an
entire write BIO without needing to split it.

This change does not have any effect on the read path of dm-crypt. Read
operations can still be split and the BIO fragments processed in
parallel. There is also no impact on the performance of the write path
given that all zone write BIOs were already processed inline instead of
in parallel.

This change also does not affect in any way regular dm-crypt block
devices.

Fixes: f211268ed1f9 ("dm: Use the block layer zone append emulation")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Mikulas Patocka <mpatocka@redhat.com>
Link: https://lore.kernel.org/r/20250625093327.548866-5-dlemoal@kernel.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/dm-crypt.c |   47 ++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 38 insertions(+), 9 deletions(-)

--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -253,17 +253,35 @@ MODULE_PARM_DESC(max_read_size, "Maximum
 static unsigned int max_write_size = 0;
 module_param(max_write_size, uint, 0644);
 MODULE_PARM_DESC(max_write_size, "Maximum size of a write request");
-static unsigned get_max_request_size(struct crypt_config *cc, bool wrt)
+
+static unsigned get_max_request_sectors(struct dm_target *ti, struct bio *bio)
 {
+	struct crypt_config *cc = ti->private;
 	unsigned val, sector_align;
-	val = !wrt ? READ_ONCE(max_read_size) : READ_ONCE(max_write_size);
-	if (likely(!val))
-		val = !wrt ? DM_CRYPT_DEFAULT_MAX_READ_SIZE : DM_CRYPT_DEFAULT_MAX_WRITE_SIZE;
-	if (wrt || cc->used_tag_size) {
-		if (unlikely(val > BIO_MAX_VECS << PAGE_SHIFT))
-			val = BIO_MAX_VECS << PAGE_SHIFT;
+	bool wrt = op_is_write(bio_op(bio));
+
+	if (wrt) {
+		/*
+		 * For zoned devices, splitting write operations creates the
+		 * risk of deadlocking queue freeze operations with zone write
+		 * plugging BIO work when the reminder of a split BIO is
+		 * issued. So always allow the entire BIO to proceed.
+		 */
+		if (ti->emulate_zone_append)
+			return bio_sectors(bio);
+
+		val = min_not_zero(READ_ONCE(max_write_size),
+				   DM_CRYPT_DEFAULT_MAX_WRITE_SIZE);
+	} else {
+		val = min_not_zero(READ_ONCE(max_read_size),
+				   DM_CRYPT_DEFAULT_MAX_READ_SIZE);
 	}
-	sector_align = max(bdev_logical_block_size(cc->dev->bdev), (unsigned)cc->sector_size);
+
+	if (wrt || cc->used_tag_size)
+		val = min(val, BIO_MAX_VECS << PAGE_SHIFT);
+
+	sector_align = max(bdev_logical_block_size(cc->dev->bdev),
+			   (unsigned)cc->sector_size);
 	val = round_down(val, sector_align);
 	if (unlikely(!val))
 		val = sector_align;
@@ -3517,7 +3535,7 @@ static int crypt_map(struct dm_target *t
 	/*
 	 * Check if bio is too large, split as needed.
 	 */
-	max_sectors = get_max_request_size(cc, bio_data_dir(bio) == WRITE);
+	max_sectors = get_max_request_sectors(ti, bio);
 	if (unlikely(bio_sectors(bio) > max_sectors))
 		dm_accept_partial_bio(bio, max_sectors);
 
@@ -3754,6 +3772,17 @@ static void crypt_io_hints(struct dm_tar
 		max_t(unsigned int, limits->physical_block_size, cc->sector_size);
 	limits->io_min = max_t(unsigned int, limits->io_min, cc->sector_size);
 	limits->dma_alignment = limits->logical_block_size - 1;
+
+	/*
+	 * For zoned dm-crypt targets, there will be no internal splitting of
+	 * write BIOs to avoid exceeding BIO_MAX_VECS vectors per BIO. But
+	 * without respecting this limit, crypt_alloc_buffer() will trigger a
+	 * BUG(). Avoid this by forcing DM core to split write BIOs to this
+	 * limit.
+	 */
+	if (ti->emulate_zone_append)
+		limits->max_hw_sectors = min(limits->max_hw_sectors,
+					     BIO_MAX_VECS << PAGE_SECTORS_SHIFT);
 }
 
 static struct target_type crypt_target = {



