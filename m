Return-Path: <stable+bounces-208079-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F239AD11EC9
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 11:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9AA0E301D2DD
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 10:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1E730FC10;
	Mon, 12 Jan 2026 10:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="q3JILyJW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CB32D0601
	for <stable@vger.kernel.org>; Mon, 12 Jan 2026 10:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768214089; cv=none; b=F4Br+uilwmCcYiQn8zTIt0SSxdNjYyNHbaiQb90id26WJ978HTrf7dyhHx2R5xF2AVUHRP8fFgrMvxEuxzCUsF4FGKRSWuAw+PbemeIJ/8J7HZDbaXOY7E63fuiMJ0PztENuhU41xKMy68dwhObslT1Ac9WBd7mIUtoq5wtHpsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768214089; c=relaxed/simple;
	bh=bSSvpqaofUUd9JKoKKXXWhwHU06XUPXL4SO5+mNv/O0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=cAAFLWWDT2Ju6+4OXAyigRid8KPD0ys2B54uWtvXGJAuaWDV5Hru+hXTpPcjh5mX5eJL8irawtj1V67Fji4qc7nFd8yhg1Rr3CgnMzRLBcJkw48r/rcXS2aWw13/mBmljXPk4FHbNmORrgN04+d1jEvTYnwp1nPVpF8J0M0ILqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=q3JILyJW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 153FCC19422;
	Mon, 12 Jan 2026 10:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768214089;
	bh=bSSvpqaofUUd9JKoKKXXWhwHU06XUPXL4SO5+mNv/O0=;
	h=Subject:To:Cc:From:Date:From;
	b=q3JILyJWBCKJMYO2RsH3SxOL+gvVg0D/s5I7aSCbcze1nE5f/GTnwbhtJWk5r+4m8
	 xjnwqbd2h7nwPJg9pTCPCtvtrpH3urj09rM/O1ae8Trgkxz3mKg7HiEKda9tGNzqDV
	 OT5WTRIT/NjosLK48QYsayPI8Yxc82JTJ3n8JAlA=
Subject: FAILED: patch "[PATCH] btrfs: fix beyond-EOF write handling" failed to apply to 6.6-stable tree
To: wqu@suse.com,dsterba@suse.com,fdmanana@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Jan 2026 11:34:43 +0100
Message-ID: <2026011243-manor-perkiness-7a2a@gregkh>
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
git cherry-pick -x e9e3b22ddfa760762b696ac6417c8d6edd182e49
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026011243-manor-perkiness-7a2a@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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


