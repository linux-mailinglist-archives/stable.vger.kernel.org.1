Return-Path: <stable+bounces-17190-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E161A84102E
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 18:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98D9E284E05
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 17:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2315915B310;
	Mon, 29 Jan 2024 17:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0+yVAM75"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E9274079;
	Mon, 29 Jan 2024 17:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706548576; cv=none; b=ofqKktxFhAFivPJxkREQkIKSCGkpnphQOm3wBs+ixdKeMVc4yWdxGr3ybuO91u6dC/ZDCRPfrgTHhXLWW4u8+5kUPkycyYqmhCbF7obCtViuhK32iDG8U1vpvedmm4Yf09rQtrkdxTNpNj2EkqS36xjmzVq/XL6BRICaO3/0xx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706548576; c=relaxed/simple;
	bh=V3WIHKz5q9FNKIs7d/V66lEIBb/nlTMgAPI2uMgX6JA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HVunxtMAg6XIcO1vU8bNB/FR6iy9rszRMKhbsrnvB0ProBKuU3NquuGj+mn1qifBts8/zbsp1LtEBIraQJYChUfyz3JKHTKffD2FmzTLvRAFjnB42nXtV8lmmu9RWGde1BjF9o072kiay1GlhY3rrQIAp4pLl7ux2qLl2wsmtWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0+yVAM75; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F4FCC433F1;
	Mon, 29 Jan 2024 17:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706548576;
	bh=V3WIHKz5q9FNKIs7d/V66lEIBb/nlTMgAPI2uMgX6JA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0+yVAM75x9eaHFMKuOVxMpNfqUMcqszba1cfWdjNTH9wzF1EN+9TAstwS/oPixlA9
	 ABzlitXJpDuJeegaoik03EsB7fH9eFY1vLJy8Hi5lN22ZkjhMAuJbUVnovirgVhAMI
	 b2kCefI5uDcQ8zMShDTOMG4Kz73rKYbBhqEIs0A0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Rongrong <i@rong.moe>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 6.6 230/331] btrfs: scrub: avoid use-after-free when chunk length is not 64K aligned
Date: Mon, 29 Jan 2024 09:04:54 -0800
Message-ID: <20240129170021.609280080@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129170014.969142961@linuxfoundation.org>
References: <20240129170014.969142961@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qu Wenruo <wqu@suse.com>

commit f546c4282673497a06ecb6190b50ae7f6c85b02f upstream.

[BUG]
There is a bug report that, on a ext4-converted btrfs, scrub leads to
various problems, including:

- "unable to find chunk map" errors
  BTRFS info (device vdb): scrub: started on devid 1
  BTRFS critical (device vdb): unable to find chunk map for logical 2214744064 length 4096
  BTRFS critical (device vdb): unable to find chunk map for logical 2214744064 length 45056

  This would lead to unrepariable errors.

- Use-after-free KASAN reports:
  ==================================================================
  BUG: KASAN: slab-use-after-free in __blk_rq_map_sg+0x18f/0x7c0
  Read of size 8 at addr ffff8881013c9040 by task btrfs/909
  CPU: 0 PID: 909 Comm: btrfs Not tainted 6.7.0-x64v3-dbg #11 c50636e9419a8354555555245df535e380563b2b
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 2023.11-2 12/24/2023
  Call Trace:
   <TASK>
   dump_stack_lvl+0x43/0x60
   print_report+0xcf/0x640
   kasan_report+0xa6/0xd0
   __blk_rq_map_sg+0x18f/0x7c0
   virtblk_prep_rq.isra.0+0x215/0x6a0 [virtio_blk 19a65eeee9ae6fcf02edfad39bb9ddee07dcdaff]
   virtio_queue_rqs+0xc4/0x310 [virtio_blk 19a65eeee9ae6fcf02edfad39bb9ddee07dcdaff]
   blk_mq_flush_plug_list.part.0+0x780/0x860
   __blk_flush_plug+0x1ba/0x220
   blk_finish_plug+0x3b/0x60
   submit_initial_group_read+0x10a/0x290 [btrfs e57987a360bed82fe8756dcd3e0de5406ccfe965]
   flush_scrub_stripes+0x38e/0x430 [btrfs e57987a360bed82fe8756dcd3e0de5406ccfe965]
   scrub_stripe+0x82a/0xae0 [btrfs e57987a360bed82fe8756dcd3e0de5406ccfe965]
   scrub_chunk+0x178/0x200 [btrfs e57987a360bed82fe8756dcd3e0de5406ccfe965]
   scrub_enumerate_chunks+0x4bc/0xa30 [btrfs e57987a360bed82fe8756dcd3e0de5406ccfe965]
   btrfs_scrub_dev+0x398/0x810 [btrfs e57987a360bed82fe8756dcd3e0de5406ccfe965]
   btrfs_ioctl+0x4b9/0x3020 [btrfs e57987a360bed82fe8756dcd3e0de5406ccfe965]
   __x64_sys_ioctl+0xbd/0x100
   do_syscall_64+0x5d/0xe0
   entry_SYSCALL_64_after_hwframe+0x63/0x6b
  RIP: 0033:0x7f47e5e0952b

- Crash, mostly due to above use-after-free

[CAUSE]
The converted fs has the following data chunk layout:

    item 2 key (FIRST_CHUNK_TREE CHUNK_ITEM 2214658048) itemoff 16025 itemsize 80
        length 86016 owner 2 stripe_len 65536 type DATA|single

For above logical bytenr 2214744064, it's at the chunk end
(2214658048 + 86016 = 2214744064).

This means btrfs_submit_bio() would split the bio, and trigger endio
function for both of the two halves.

However scrub_submit_initial_read() would only expect the endio function
to be called once, not any more.
This means the first endio function would already free the bbio::bio,
leaving the bvec freed, thus the 2nd endio call would lead to
use-after-free.

[FIX]
- Make sure scrub_read_endio() only updates bits in its range
  Since we may read less than 64K at the end of the chunk, we should not
  touch the bits beyond chunk boundary.

- Make sure scrub_submit_initial_read() only to read the chunk range
  This is done by calculating the real number of sectors we need to
  read, and add sector-by-sector to the bio.

Thankfully the scrub read repair path won't need extra fixes:

- scrub_stripe_submit_repair_read()
  With above fixes, we won't update error bit for range beyond chunk,
  thus scrub_stripe_submit_repair_read() should never submit any read
  beyond the chunk.

Reported-by: Rongrong <i@rong.moe>
Fixes: e02ee89baa66 ("btrfs: scrub: switch scrub_simple_mirror() to scrub_stripe infrastructure")
Tested-by: Rongrong <i@rong.moe>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
[ Use min_t() to fix a compiling error due to difference types ]
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/scrub.c |   29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1099,12 +1099,22 @@ out:
 static void scrub_read_endio(struct btrfs_bio *bbio)
 {
 	struct scrub_stripe *stripe = bbio->private;
+	struct bio_vec *bvec;
+	int sector_nr = calc_sector_number(stripe, bio_first_bvec_all(&bbio->bio));
+	int num_sectors;
+	u32 bio_size = 0;
+	int i;
+
+	ASSERT(sector_nr < stripe->nr_sectors);
+	bio_for_each_bvec_all(bvec, &bbio->bio, i)
+		bio_size += bvec->bv_len;
+	num_sectors = bio_size >> stripe->bg->fs_info->sectorsize_bits;
 
 	if (bbio->bio.bi_status) {
-		bitmap_set(&stripe->io_error_bitmap, 0, stripe->nr_sectors);
-		bitmap_set(&stripe->error_bitmap, 0, stripe->nr_sectors);
+		bitmap_set(&stripe->io_error_bitmap, sector_nr, num_sectors);
+		bitmap_set(&stripe->error_bitmap, sector_nr, num_sectors);
 	} else {
-		bitmap_clear(&stripe->io_error_bitmap, 0, stripe->nr_sectors);
+		bitmap_clear(&stripe->io_error_bitmap, sector_nr, num_sectors);
 	}
 	bio_put(&bbio->bio);
 	if (atomic_dec_and_test(&stripe->pending_io)) {
@@ -1640,6 +1650,9 @@ static void scrub_submit_initial_read(st
 {
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
 	struct btrfs_bio *bbio;
+	unsigned int nr_sectors = min_t(u64, BTRFS_STRIPE_LEN, stripe->bg->start +
+				      stripe->bg->length - stripe->logical) >>
+				  fs_info->sectorsize_bits;
 	int mirror = stripe->mirror_num;
 
 	ASSERT(stripe->bg);
@@ -1649,14 +1662,16 @@ static void scrub_submit_initial_read(st
 	bbio = btrfs_bio_alloc(SCRUB_STRIPE_PAGES, REQ_OP_READ, fs_info,
 			       scrub_read_endio, stripe);
 
-	/* Read the whole stripe. */
 	bbio->bio.bi_iter.bi_sector = stripe->logical >> SECTOR_SHIFT;
-	for (int i = 0; i < BTRFS_STRIPE_LEN >> PAGE_SHIFT; i++) {
+	/* Read the whole range inside the chunk boundary. */
+	for (unsigned int cur = 0; cur < nr_sectors; cur++) {
+		struct page *page = scrub_stripe_get_page(stripe, cur);
+		unsigned int pgoff = scrub_stripe_get_page_offset(stripe, cur);
 		int ret;
 
-		ret = bio_add_page(&bbio->bio, stripe->pages[i], PAGE_SIZE, 0);
+		ret = bio_add_page(&bbio->bio, page, fs_info->sectorsize, pgoff);
 		/* We should have allocated enough bio vectors. */
-		ASSERT(ret == PAGE_SIZE);
+		ASSERT(ret == fs_info->sectorsize);
 	}
 	atomic_inc(&stripe->pending_io);
 



