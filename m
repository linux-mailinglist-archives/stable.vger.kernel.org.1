Return-Path: <stable+bounces-71921-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB6696785A
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 18:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BF7F1C2102D
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 16:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A13F17E900;
	Sun,  1 Sep 2024 16:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hcDd7FQI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CA25381A;
	Sun,  1 Sep 2024 16:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725208258; cv=none; b=TBcFQl6TobG5EDiWs7TO5upvarfCKAOTWviITlhZ1vk35uGzIfY6IIaz8rciUQgNspexAaD0Ony6z2oyFVarOV0UC7LxYGr3FtJPWTLRJoEqQooKYfY2BpU8R9AN5CBQpXgFmyQhQgi/tKovGd0uAf+y7HZ1dec1bjbkqsvzfKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725208258; c=relaxed/simple;
	bh=+o6G7zl2g3HsxvH4UyuRmDO4OvphWPY7QsqeXflnrOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gDC3wY2oSYrD3EbD2pCmjPGnsDuMaalYmG5PMsOVu4ePoSD0N7JQSh0iaOgP385rOK6MQdVXH+jnbG31YdiMv1Vfwt1KjWte0dqY0LUuLH9XshEKI0aXWWB7iKC5BZxUaobhZcAm1xdxd5U7zyuF9+7k7dSSHOS7sJjiuDyy3Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hcDd7FQI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26340C4CEC3;
	Sun,  1 Sep 2024 16:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725208257;
	bh=+o6G7zl2g3HsxvH4UyuRmDO4OvphWPY7QsqeXflnrOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hcDd7FQI7ux6iX8dFrkhuHUlHbGkp1oAmBJvt0qBpk64900vU1kkKDqUouQHuKUrn
	 2tt8H9rhKot7q6hDqyOlFiaRfbAIAk0W6wHzBu+KBPGOWSXS+zmYiPaDvmoBxU13ly
	 2pTP2ALft5RthD+7hm14YNAbkIkdmOzlDQiZXJBE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Sterba <dsterba@suse.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Qu Wenruo <wqu@suse.com>
Subject: [PATCH 6.10 009/149] btrfs: fix a use-after-free when hitting errors inside btrfs_submit_chunk()
Date: Sun,  1 Sep 2024 18:15:20 +0200
Message-ID: <20240901160817.818935943@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240901160817.461957599@linuxfoundation.org>
References: <20240901160817.461957599@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qu Wenruo <wqu@suse.com>

commit 10d9d8c3512f16cad47b2ff81ec6fc4b27d8ee10 upstream.

[BUG]
There is an internal report that KASAN is reporting use-after-free, with
the following backtrace:

  BUG: KASAN: slab-use-after-free in btrfs_check_read_bio+0xa68/0xb70 [btrfs]
  Read of size 4 at addr ffff8881117cec28 by task kworker/u16:2/45
  CPU: 1 UID: 0 PID: 45 Comm: kworker/u16:2 Not tainted 6.11.0-rc2-next-20240805-default+ #76
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.2-3-gd478f380-rebuilt.opensuse.org 04/01/2014
  Workqueue: btrfs-endio btrfs_end_bio_work [btrfs]
  Call Trace:
   dump_stack_lvl+0x61/0x80
   print_address_description.constprop.0+0x5e/0x2f0
   print_report+0x118/0x216
   kasan_report+0x11d/0x1f0
   btrfs_check_read_bio+0xa68/0xb70 [btrfs]
   process_one_work+0xce0/0x12a0
   worker_thread+0x717/0x1250
   kthread+0x2e3/0x3c0
   ret_from_fork+0x2d/0x70
   ret_from_fork_asm+0x11/0x20

  Allocated by task 20917:
   kasan_save_stack+0x37/0x60
   kasan_save_track+0x10/0x30
   __kasan_slab_alloc+0x7d/0x80
   kmem_cache_alloc_noprof+0x16e/0x3e0
   mempool_alloc_noprof+0x12e/0x310
   bio_alloc_bioset+0x3f0/0x7a0
   btrfs_bio_alloc+0x2e/0x50 [btrfs]
   submit_extent_page+0x4d1/0xdb0 [btrfs]
   btrfs_do_readpage+0x8b4/0x12a0 [btrfs]
   btrfs_readahead+0x29a/0x430 [btrfs]
   read_pages+0x1a7/0xc60
   page_cache_ra_unbounded+0x2ad/0x560
   filemap_get_pages+0x629/0xa20
   filemap_read+0x335/0xbf0
   vfs_read+0x790/0xcb0
   ksys_read+0xfd/0x1d0
   do_syscall_64+0x6d/0x140
   entry_SYSCALL_64_after_hwframe+0x4b/0x53

  Freed by task 20917:
   kasan_save_stack+0x37/0x60
   kasan_save_track+0x10/0x30
   kasan_save_free_info+0x37/0x50
   __kasan_slab_free+0x4b/0x60
   kmem_cache_free+0x214/0x5d0
   bio_free+0xed/0x180
   end_bbio_data_read+0x1cc/0x580 [btrfs]
   btrfs_submit_chunk+0x98d/0x1880 [btrfs]
   btrfs_submit_bio+0x33/0x70 [btrfs]
   submit_one_bio+0xd4/0x130 [btrfs]
   submit_extent_page+0x3ea/0xdb0 [btrfs]
   btrfs_do_readpage+0x8b4/0x12a0 [btrfs]
   btrfs_readahead+0x29a/0x430 [btrfs]
   read_pages+0x1a7/0xc60
   page_cache_ra_unbounded+0x2ad/0x560
   filemap_get_pages+0x629/0xa20
   filemap_read+0x335/0xbf0
   vfs_read+0x790/0xcb0
   ksys_read+0xfd/0x1d0
   do_syscall_64+0x6d/0x140
   entry_SYSCALL_64_after_hwframe+0x4b/0x53

[CAUSE]
Although I cannot reproduce the error, the report itself is good enough
to pin down the cause.

The call trace is the regular endio workqueue context, but the
free-by-task trace is showing that during btrfs_submit_chunk() we
already hit a critical error, and is calling btrfs_bio_end_io() to error
out.  And the original endio function called bio_put() to free the whole
bio.

This means a double freeing thus causing use-after-free, e.g.:

1. Enter btrfs_submit_bio() with a read bio
   The read bio length is 128K, crossing two 64K stripes.

2. The first run of btrfs_submit_chunk()

2.1 Call btrfs_map_block(), which returns 64K
2.2 Call btrfs_split_bio()
    Now there are two bios, one referring to the first 64K, the other
    referring to the second 64K.
2.3 The first half is submitted.

3. The second run of btrfs_submit_chunk()

3.1 Call btrfs_map_block(), which by somehow failed
    Now we call btrfs_bio_end_io() to handle the error

3.2 btrfs_bio_end_io() calls the original endio function
    Which is end_bbio_data_read(), and it calls bio_put() for the
    original bio.

    Now the original bio is freed.

4. The submitted first 64K bio finished
   Now we call into btrfs_check_read_bio() and tries to advance the bio
   iter.
   But since the original bio (thus its iter) is already freed, we
   trigger the above use-after free.

   And even if the memory is not poisoned/corrupted, we will later call
   the original endio function, causing a double freeing.

[FIX]
Instead of calling btrfs_bio_end_io(), call btrfs_orig_bbio_end_io(),
which has the extra check on split bios and do the proper refcounting
for cloned bios.

Furthermore there is already one extra btrfs_cleanup_bio() call, but
that is duplicated to btrfs_orig_bbio_end_io() call, so remove that
label completely.

Reported-by: David Sterba <dsterba@suse.com>
Fixes: 852eee62d31a ("btrfs: allow btrfs_submit_bio to split bios")
CC: stable@vger.kernel.org # 6.6+
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/bio.c |   26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -668,7 +668,6 @@ static bool btrfs_submit_chunk(struct bt
 {
 	struct btrfs_inode *inode = bbio->inode;
 	struct btrfs_fs_info *fs_info = bbio->fs_info;
-	struct btrfs_bio *orig_bbio = bbio;
 	struct bio *bio = &bbio->bio;
 	u64 logical = bio->bi_iter.bi_sector << SECTOR_SHIFT;
 	u64 length = bio->bi_iter.bi_size;
@@ -706,7 +705,7 @@ static bool btrfs_submit_chunk(struct bt
 		bbio->saved_iter = bio->bi_iter;
 		ret = btrfs_lookup_bio_sums(bbio);
 		if (ret)
-			goto fail_put_bio;
+			goto fail;
 	}
 
 	if (btrfs_op(bio) == BTRFS_MAP_WRITE) {
@@ -740,13 +739,13 @@ static bool btrfs_submit_chunk(struct bt
 
 			ret = btrfs_bio_csum(bbio);
 			if (ret)
-				goto fail_put_bio;
+				goto fail;
 		} else if (use_append ||
 			   (btrfs_is_zoned(fs_info) && inode &&
 			    inode->flags & BTRFS_INODE_NODATASUM)) {
 			ret = btrfs_alloc_dummy_sum(bbio);
 			if (ret)
-				goto fail_put_bio;
+				goto fail;
 		}
 	}
 
@@ -754,12 +753,23 @@ static bool btrfs_submit_chunk(struct bt
 done:
 	return map_length == length;
 
-fail_put_bio:
-	if (map_length < length)
-		btrfs_cleanup_bio(bbio);
 fail:
 	btrfs_bio_counter_dec(fs_info);
-	btrfs_bio_end_io(orig_bbio, ret);
+	/*
+	 * We have split the original bbio, now we have to end both the current
+	 * @bbio and remaining one, as the remaining one will never be submitted.
+	 */
+	if (map_length < length) {
+		struct btrfs_bio *remaining = bbio->private;
+
+		ASSERT(bbio->bio.bi_pool == &btrfs_clone_bioset);
+		ASSERT(remaining);
+
+		remaining->bio.bi_status = ret;
+		btrfs_orig_bbio_end_io(remaining);
+	}
+	bbio->bio.bi_status = ret;
+	btrfs_orig_bbio_end_io(bbio);
 	/* Do not submit another chunk */
 	return true;
 }



