Return-Path: <stable+bounces-16092-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7661F83F000
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 21:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E89BE1F22756
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 20:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6FD514A9D;
	Sat, 27 Jan 2024 20:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SVzUm9co"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641C419474
	for <stable@vger.kernel.org>; Sat, 27 Jan 2024 20:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706387802; cv=none; b=Z+kUSYTXrLjsGJMraAftt09noe4CtYk1z8zSifRXtqApLMbIjyLilMJReL3Y+bimPpF7UbDquatFt1wvnCQO+dSPL91K7mmU4mfHiTlGT1gDB6GTPugVGejAie98VFEPZ9ofIyIxkTQAetN7bfzdz7QnCCr7YiDJhcS+ug/xKqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706387802; c=relaxed/simple;
	bh=l3e20ZTJYbHLa7vKEorfdfhH+7oAw6IDs7MzBLHy1rw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tDAfHwZTu4F0X+IxJ7+tp0etZR/bPFF5sOzju+7Q89a36yR3HfN9bewP30RT+XVAFMxim/9gQPoyQTCTY7rxCjSouzZDhBC/0kghBerZUvtd9/fo2QpE5KttyKooy5djG0Q5gKlqNuMpVZA3MonS+k6RaPY4gI91PlOUhn+rIkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SVzUm9co; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A184AC433F1;
	Sat, 27 Jan 2024 20:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706387801;
	bh=l3e20ZTJYbHLa7vKEorfdfhH+7oAw6IDs7MzBLHy1rw=;
	h=Subject:To:Cc:From:Date:From;
	b=SVzUm9coRViYccUncJmMMfCOfPiZ2nNYTHOyZTKUCs7yxSYcPEClfTBAALOmJNJHm
	 5+BlkVaqrXgxsJHVdNZ41zGaBJxzWwBJutSg8MNQJEyS3c25A6Su60Q6nQUJWSv54/
	 5dBtDzzEEEM01WWIErrSMMYGBC/4U+4bI4zSt+js=
Subject: FAILED: patch "[PATCH] btrfs: scrub: avoid use-after-free when chunk length is not" failed to apply to 6.6-stable tree
To: wqu@suse.com,dsterba@suse.com,i@rong.moe,johannes.thumshirn@wdc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 27 Jan 2024 12:36:40 -0800
Message-ID: <2024012740-mating-boxing-dd93@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x f546c4282673497a06ecb6190b50ae7f6c85b02f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012740-mating-boxing-dd93@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

f546c4282673 ("btrfs: scrub: avoid use-after-free when chunk length is not 64K aligned")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f546c4282673497a06ecb6190b50ae7f6c85b02f Mon Sep 17 00:00:00 2001
From: Qu Wenruo <wqu@suse.com>
Date: Wed, 17 Jan 2024 11:02:25 +1030
Subject: [PATCH] btrfs: scrub: avoid use-after-free when chunk length is not
 64K aligned

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

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index a01807cbd4d4..2d81b1a18a04 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1098,12 +1098,22 @@ static void scrub_stripe_read_repair_worker(struct work_struct *work)
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
@@ -1701,6 +1711,9 @@ static void scrub_submit_initial_read(struct scrub_ctx *sctx,
 {
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
 	struct btrfs_bio *bbio;
+	unsigned int nr_sectors = min(BTRFS_STRIPE_LEN, stripe->bg->start +
+				      stripe->bg->length - stripe->logical) >>
+				  fs_info->sectorsize_bits;
 	int mirror = stripe->mirror_num;
 
 	ASSERT(stripe->bg);
@@ -1715,14 +1728,16 @@ static void scrub_submit_initial_read(struct scrub_ctx *sctx,
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
 


