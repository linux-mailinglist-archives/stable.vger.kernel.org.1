Return-Path: <stable+bounces-208120-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CADB0D12F8A
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 15:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87A3F30194C9
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 13:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3574735B158;
	Mon, 12 Jan 2026 13:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L5r8rMhz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECADB35B157
	for <stable@vger.kernel.org>; Mon, 12 Jan 2026 13:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768226096; cv=none; b=EPASVrJ9HNPqQpcHmHCi7qsRkegiDdp98HwmMS4mT0X6FszH6tlMSXYX9+vw4/c7K01jOiB/Wg4gwyc0SCEckP/YW+2+XqTx/KxnJjHEzYkVoM2X59zAdGSaB5XYlBijHzJH8rj1D7Wzr/BtgvuEh/MzRrwWi2teCr3YaPtzzcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768226096; c=relaxed/simple;
	bh=RODrjVBGp5eu7buTCDPavA498hvmo7+Lzy++jsc0jeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j7lVCTps5XhknJ/1tisiJL4p+QL5jQQNU3xzQQWHjR2gCvGoPRpmi0zBxYpBgGijcSO6TPJ66PuxfRQIorXGObn/+XQsJVEOz9UTVAEhkynQIyGEDrJhz9pMKjpvHAzj2anuANDfruYf23o0Sb8oud7ZyBKhIXJiB2MZYtcKRcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L5r8rMhz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F822C19422;
	Mon, 12 Jan 2026 13:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768226095;
	bh=RODrjVBGp5eu7buTCDPavA498hvmo7+Lzy++jsc0jeo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L5r8rMhzjRQU6CWcWF2C34ZjGqzzxzVI/WtaHhuyVg9yRFUdwfHxodkhq7qZm46Lz
	 72mhNoGfDYiTt3eHHzLofzQmYeIKU9+xbrdnIvcyxWLlMQxesbp4dtyapG8957daLQ
	 SJHP4xw2y/2Fas5oRPcoBGR2EfS1XScYBVxYXFIncGeMxpN9adrgesuLfsx7DL5ZW3
	 nwqpy+tzUiiaTaMeFk6tv2VHKgwfg3+Sev6p7WBXIOxt9UYvo97XN5sYRL9iXg43/W
	 rEh1Zv4zy/4vBjgyxxKVW+ABADNFTS0BRjr0ZHD/eECnWxJMACeIrGzL9wrEC6O7S3
	 zu8wzrvlhl3/A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Qu Wenruo <wqu@suse.com>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/3] btrfs: fix beyond-EOF write handling
Date: Mon, 12 Jan 2026 08:54:51 -0500
Message-ID: <20260112135451.704777-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260112135451.704777-1-sashal@kernel.org>
References: <2026011240-unreal-knee-7bf4@gregkh>
 <20260112135451.704777-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit e9e3b22ddfa760762b696ac6417c8d6edd182e49 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/extent_io.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index ca09f42d26aa1..1a07edaefaa0f 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1730,7 +1730,7 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
 			unsigned long flags;
 
 			ordered = btrfs_lookup_first_ordered_range(inode, cur,
-								   folio_end - cur);
+								   fs_info->sectorsize);
 			/*
 			 * We have just run delalloc before getting here, so
 			 * there must be an ordered extent.
@@ -1744,7 +1744,7 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
 			btrfs_put_ordered_extent(ordered);
 
 			btrfs_mark_ordered_io_finished(inode, folio, cur,
-						       end - cur, true);
+						       fs_info->sectorsize, true);
 			/*
 			 * This range is beyond i_size, thus we don't need to
 			 * bother writing back.
@@ -1753,8 +1753,8 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
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
-- 
2.51.0


