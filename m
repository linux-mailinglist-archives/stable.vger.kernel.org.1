Return-Path: <stable+bounces-208078-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BE4D11EC6
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 11:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A18213051FB1
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 10:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B85F2D2493;
	Mon, 12 Jan 2026 10:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jTwklJmE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1ABE280324
	for <stable@vger.kernel.org>; Mon, 12 Jan 2026 10:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768214087; cv=none; b=CgutBDYa8Tzsw0SKK9NldICdTKFU2LZX9zKr91D+NDZ546LeUr1JwO7J2+12MmHItWU18JrnnNgLmQL8g0M5kyx8PMx/VQk0fnD6pByjsQhGPv0Srjx4eLfdaM+OmiPnrs5uu3Jxl7ua9mCaOf7fpt+GLizge61FQb3PfMFe0C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768214087; c=relaxed/simple;
	bh=S76DmiuBpOlyMvf02OYxKps1XwjijyuZCpofKY2RDMQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=UTBgBz+uhIwyGFrB54fLwCGXy10J8X0JMyeKZLZyz7JvcwPil8+j33QS3V3BDHGgUr7iF1VtyxoBJ+ynf+alFAq8TIaIBogQMiuudcx/LPk251W24JRAd3No01FaW7KAFrVl5Woq7ntMMe73GKd3fDAV1+mLwf2EQMNZf6XDLmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jTwklJmE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3669FC16AAE;
	Mon, 12 Jan 2026 10:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768214086;
	bh=S76DmiuBpOlyMvf02OYxKps1XwjijyuZCpofKY2RDMQ=;
	h=Subject:To:Cc:From:Date:From;
	b=jTwklJmEg3Uetnx7gngDqkGyU4NdP1fUIyZbcB2LM2gvLbqOedHo4UZuskn/CNKBe
	 waXqNLeXiO45bk5A9xL5Yqcla9tOdRQO/JQANrjutN2mxOWsm+JRpzGlxBRw7TtaNR
	 vwACEH3jmlRtoLqDkolQuY3ZVD9bTKcHIfY8M9kU=
Subject: FAILED: patch "[PATCH] btrfs: fix beyond-EOF write handling" failed to apply to 6.12-stable tree
To: wqu@suse.com,dsterba@suse.com,fdmanana@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Jan 2026 11:34:42 +0100
Message-ID: <2026011242-empirical-gullible-4683@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x e9e3b22ddfa760762b696ac6417c8d6edd182e49
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026011242-empirical-gullible-4683@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e9e3b22ddfa760762b696ac6417c8d6edd182e49 Mon Sep 17 00:00:00 2001
From: Qu Wenruo <wqu@suse.com>
Date: Thu, 11 Dec 2025 12:45:17 +1030
Subject: [PATCH] btrfs: fix beyond-EOF write handling

[BUG]
For the following write sequence with 64K page size and 4K fs block size,
it will lead to file extent items to be inserted without any data
checksum:

  mkfs.btrfs -s 4k -f $dev > /dev/null
  mount $dev $mnt
  xfs_io -f -c "pwrite 0 16k" -c "pwrite 32k 4k" -c pwrite "60k 64K" \
            -c "truncate 16k" $mnt/foobar
  umount $mnt

This will result the following 2 file extent items to be inserted (extra
trace point added to insert_ordered_extent_file_extent()):

  btrfs_finish_one_ordered: root=5 ino=257 file_off=61440 num_bytes=4096 csum_bytes=0
  btrfs_finish_one_ordered: root=5 ino=257 file_off=0 num_bytes=16384 csum_bytes=16384

Note for file offset 60K, we're inserting a file extent without any
data checksum.

Also note that range [32K, 36K) didn't reach
insert_ordered_extent_file_extent(), which is the correct behavior as
that OE is fully truncated, should not result any file extent.

Although file extent at 60K will be later dropped by btrfs_truncate(),
if the transaction got committed after file extent inserted but before
the file extent dropping, we will have a small window where we have a
file extent beyond EOF and without any data checksum.

That will cause "btrfs check" to report error.

[CAUSE]
The sequence happens like this:

- Buffered write dirtied the page cache and updated isize

  Now the inode size is 64K, with the following page cache layout:

  0             16K             32K              48K           64K
  |/////////////|               |//|                        |//|

- Truncate the inode to 16K
  Which will trigger writeback through:

  btrfs_setsize()
  |- truncate_setsize()
  |  Now the inode size is set to 16K
  |
  |- btrfs_truncate()
     |- btrfs_wait_ordered_range() for [16K, u64(-1)]
        |- btrfs_fdatawrite_range() for [16K, u64(-1)}
	   |- extent_writepage() for folio 0
	      |- writepage_delalloc()
	      |  Generated OE for [0, 16K), [32K, 36K] and [60K, 64K)
	      |
	      |- extent_writepage_io()

  Then inside extent_writepage_io(), the dirty fs blocks are handled
  differently:

  - Submit write for range [0, 16K)
    As they are still inside the inode size (16K).

  - Mark OE [32K, 36K) as truncated
    Since we only call btrfs_lookup_first_ordered_range() once, which
    returned the first OE after file offset 16K.

  - Mark all OEs inside range [16K, 64K) as finished
    Which will mark OE ranges [32K, 36K) and [60K, 64K) as finished.

    For OE [32K, 36K) since it's already marked as truncated, and its
    truncated length is 0, no file extent will be inserted.

    For OE [60K, 64K) it has never been submitted thus has no data
    checksum, and we insert the file extent as usual.
    This is the root cause of file extent at 60K to be inserted without
    any data checksum.

  - Clear dirty flags for range [16K, 64K)
    It is the function btrfs_folio_clear_dirty() which searches and clears
    any dirty blocks inside that range.

[FIX]
The bug itself was introduced a long time ago, way before subpage and
large folio support.

At that time, fs block size must match page size, thus the range
[cur, end) is just one fs block.

But later with subpage and large folios, the same range [cur, end)
can have multiple blocks and ordered extents.

Later commit 18de34daa7c6 ("btrfs: truncate ordered extent when skipping
writeback past i_size") was fixing a bug related to subpage/large
folios, but it's still utilizing the old range [cur, end), meaning only
the first OE will be marked as truncated.

The proper fix here is to make EOF handling block-by-block, not trying
to handle the whole range to @end.

By this we always locate and truncate the OE for every dirty block.

CC: stable@vger.kernel.org # 5.15+
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 2d32dfc34ae3..97748d0d54d9 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1728,7 +1728,7 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
 			struct btrfs_ordered_extent *ordered;
 
 			ordered = btrfs_lookup_first_ordered_range(inode, cur,
-								   folio_end - cur);
+								   fs_info->sectorsize);
 			/*
 			 * We have just run delalloc before getting here, so
 			 * there must be an ordered extent.
@@ -1742,7 +1742,7 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
 			btrfs_put_ordered_extent(ordered);
 
 			btrfs_mark_ordered_io_finished(inode, folio, cur,
-						       end - cur, true);
+						       fs_info->sectorsize, true);
 			/*
 			 * This range is beyond i_size, thus we don't need to
 			 * bother writing back.
@@ -1751,8 +1751,8 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
 			 * writeback the sectors with subpage dirty bits,
 			 * causing writeback without ordered extent.
 			 */
-			btrfs_folio_clear_dirty(fs_info, folio, cur, end - cur);
-			break;
+			btrfs_folio_clear_dirty(fs_info, folio, cur, fs_info->sectorsize);
+			continue;
 		}
 		ret = submit_one_sector(inode, folio, cur, bio_ctrl, i_size);
 		if (unlikely(ret < 0)) {


