Return-Path: <stable+bounces-179510-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0822DB56231
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 18:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBEF8A06371
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 16:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D5B2F0686;
	Sat, 13 Sep 2025 16:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KgIe6sMQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6244B2EFDB0
	for <stable@vger.kernel.org>; Sat, 13 Sep 2025 16:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757780038; cv=none; b=bi+r3xyFLF59Vfiqc3uPJCG+8BbPWdnoRHUeRjBwLqfvoSN83FiDYVwbOFeJOas7RAs3+S2YgUCzPks78p8qbKA1N8IGeBTzIDidkF8AxUAf1NwBJLITT1S2/EMo648Hs9d0nd88ojLjjgE4eR78mbG6vahnMqJZBKV9vlLYihI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757780038; c=relaxed/simple;
	bh=k6Qba71fG0REPmqxLX3NNppRrHgSfyNqYKSBewsKsnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YE+dmT9d2sLqCbBYha3BzFpxukl0wFEOd46nMpnj+7nH5RG1CsuRtaxflDPUgqI22vPyZvte0hrt3DZpFNED+d0qVR0IkeXWSBlX8rISppUHnF3jCRHRRzHOlCrvI8gbbTFocojk84ey3jkOCNhwBpu7Bw6K7FrBCRLcIM6dj9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KgIe6sMQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BF11C4CEF5;
	Sat, 13 Sep 2025 16:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757780037;
	bh=k6Qba71fG0REPmqxLX3NNppRrHgSfyNqYKSBewsKsnY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KgIe6sMQsAfs2/fP7GHbA8uKXAjVpfJnJOf95wmG7wRzhX7uttLJ9ZtjHitOxn9sg
	 PYsrtC6PIwXr9VrDCNqEQihSqH+WkJyvtSd/jYyKXawr5oULlDALLz/xNbomElBHol
	 CiAEzY2oPFX+fLovkHI0PxxtKR/OKfL/9GPkG9Q7+OY5NC2pCRbbsCvgXVMOzJC6Mv
	 Hsqdo9W7cAG7PeQdItDBaHzjfueISl+a3CVDGgIlImXuhkdJ6trk9X9u5IH7rdBItO
	 DWnlDaTFQETG74NHPvTBD3Wi+/lwMDMN/4rqad8iBbTlrlC6L9Ra+QiySBwf5hFCgG
	 L8ER8I+CGDz4A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Qu Wenruo <wqu@suse.com>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] btrfs: fix corruption reading compressed range when block size is smaller than page size
Date: Sat, 13 Sep 2025 12:13:53 -0400
Message-ID: <20250913161353.1443138-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250913161353.1443138-1-sashal@kernel.org>
References: <2025091345-gloater-dolly-54a5@gregkh>
 <20250913161353.1443138-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit 9786531399a679fc2f4630d2c0a186205282ab2f ]

[BUG]
With 64K page size (aarch64 with 64K page size config) and 4K btrfs
block size, the following workload can easily lead to a corrupted read:

        mkfs.btrfs -f -s 4k $dev > /dev/null
        mount -o compress $dev $mnt
        xfs_io -f -c "pwrite -S 0xff 0 64k" $mnt/base > /dev/null
	echo "correct result:"
        od -Ad -t x1 $mnt/base
        xfs_io -f -c "reflink $mnt/base 32k 0 32k" \
		  -c "reflink $mnt/base 0 32k 32k" \
		  -c "pwrite -S 0xff 60k 4k" $mnt/new > /dev/null
	echo "incorrect result:"
        od -Ad -t x1 $mnt/new
        umount $mnt

This shows the following result:

correct result:
0000000 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
*
0065536
incorrect result:
0000000 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
*
0032768 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
*
0061440 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
*
0065536

Notice the zero in the range [32K, 60K), which is incorrect.

[CAUSE]
With extra trace printk, it shows the following events during od:
(some unrelated info removed like CPU and context)

 od-3457   btrfs_do_readpage: enter r/i=5/258 folio=0(65536) prev_em_start=0000000000000000

The "r/i" is indicating the root and inode number. In our case the file
"new" is using ino 258 from fs tree (root 5).

Here notice the @prev_em_start pointer is NULL. This means the
btrfs_do_readpage() is called from btrfs_read_folio(), not from
btrfs_readahead().

 od-3457   btrfs_do_readpage: r/i=5/258 folio=0(65536) cur=0 got em start=0 len=32768
 od-3457   btrfs_do_readpage: r/i=5/258 folio=0(65536) cur=4096 got em start=0 len=32768
 od-3457   btrfs_do_readpage: r/i=5/258 folio=0(65536) cur=8192 got em start=0 len=32768
 od-3457   btrfs_do_readpage: r/i=5/258 folio=0(65536) cur=12288 got em start=0 len=32768
 od-3457   btrfs_do_readpage: r/i=5/258 folio=0(65536) cur=16384 got em start=0 len=32768
 od-3457   btrfs_do_readpage: r/i=5/258 folio=0(65536) cur=20480 got em start=0 len=32768
 od-3457   btrfs_do_readpage: r/i=5/258 folio=0(65536) cur=24576 got em start=0 len=32768
 od-3457   btrfs_do_readpage: r/i=5/258 folio=0(65536) cur=28672 got em start=0 len=32768

These above 32K blocks will be read from the first half of the
compressed data extent.

 od-3457   btrfs_do_readpage: r/i=5/258 folio=0(65536) cur=32768 got em start=32768 len=32768

Note here there is no btrfs_submit_compressed_read() call. Which is
incorrect now.
Although both extent maps at 0 and 32K are pointing to the same compressed
data, their offsets are different thus can not be merged into the same
read.

So this means the compressed data read merge check is doing something
wrong.

 od-3457   btrfs_do_readpage: r/i=5/258 folio=0(65536) cur=36864 got em start=32768 len=32768
 od-3457   btrfs_do_readpage: r/i=5/258 folio=0(65536) cur=40960 got em start=32768 len=32768
 od-3457   btrfs_do_readpage: r/i=5/258 folio=0(65536) cur=45056 got em start=32768 len=32768
 od-3457   btrfs_do_readpage: r/i=5/258 folio=0(65536) cur=49152 got em start=32768 len=32768
 od-3457   btrfs_do_readpage: r/i=5/258 folio=0(65536) cur=53248 got em start=32768 len=32768
 od-3457   btrfs_do_readpage: r/i=5/258 folio=0(65536) cur=57344 got em start=32768 len=32768
 od-3457   btrfs_do_readpage: r/i=5/258 folio=0(65536) cur=61440 skip uptodate
 od-3457   btrfs_submit_compressed_read: cb orig_bio: file off=0 len=61440

The function btrfs_submit_compressed_read() is only called at the end of
folio read. The compressed bio will only have an extent map of range [0,
32K), but the original bio passed in is for the whole 64K folio.

This will cause the decompression part to only fill the first 32K,
leaving the rest untouched (aka, filled with zero).

This incorrect compressed read merge leads to the above data corruption.

There were similar problems that happened in the past, commit 808f80b46790
("Btrfs: update fix for read corruption of compressed and shared
extents") is doing pretty much the same fix for readahead.

But that's back to 2015, where btrfs still only supports bs (block size)
== ps (page size) cases.
This means btrfs_do_readpage() only needs to handle a folio which
contains exactly one block.

Only btrfs_readahead() can lead to a read covering multiple blocks.
Thus only btrfs_readahead() passes a non-NULL @prev_em_start pointer.

With v5.15 kernel btrfs introduced bs < ps support. This breaks the above
assumption that a folio can only contain one block.

Now btrfs_read_folio() can also read multiple blocks in one go.
But btrfs_read_folio() doesn't pass a @prev_em_start pointer, thus the
existing bio force submission check will never be triggered.

In theory, this can also happen for btrfs with large folios, but since
large folio is still experimental, we don't need to bother it, thus only
bs < ps support is affected for now.

[FIX]
Instead of passing @prev_em_start to do the proper compressed extent
check, introduce one new member, btrfs_bio_ctrl::last_em_start, so that
the existing bio force submission logic will always be triggered.

CC: stable@vger.kernel.org # 5.15+
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/extent_io.c | 40 ++++++++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index c59b6ec43581f..afebc91882bef 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -109,6 +109,24 @@ struct btrfs_bio_ctrl {
 	 */
 	unsigned long submit_bitmap;
 	struct readahead_control *ractl;
+
+	/*
+	 * The start offset of the last used extent map by a read operation.
+	 *
+	 * This is for proper compressed read merge.
+	 * U64_MAX means we are starting the read and have made no progress yet.
+	 *
+	 * The current btrfs_bio_is_contig() only uses disk_bytenr as
+	 * the condition to check if the read can be merged with previous
+	 * bio, which is not correct. E.g. two file extents pointing to the
+	 * same extent but with different offset.
+	 *
+	 * So here we need to do extra checks to only merge reads that are
+	 * covered by the same extent map.
+	 * Just extent_map::start will be enough, as they are unique
+	 * inside the same inode.
+	 */
+	u64 last_em_start;
 };
 
 static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
@@ -955,7 +973,7 @@ static void btrfs_readahead_expand(struct readahead_control *ractl,
  * return 0 on success, otherwise return error
  */
 static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
-		      struct btrfs_bio_ctrl *bio_ctrl, u64 *prev_em_start)
+			     struct btrfs_bio_ctrl *bio_ctrl)
 {
 	struct inode *inode = folio->mapping->host;
 	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
@@ -1066,12 +1084,11 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
 		 * non-optimal behavior (submitting 2 bios for the same extent).
 		 */
 		if (compress_type != BTRFS_COMPRESS_NONE &&
-		    prev_em_start && *prev_em_start != (u64)-1 &&
-		    *prev_em_start != em->start)
+		    bio_ctrl->last_em_start != U64_MAX &&
+		    bio_ctrl->last_em_start != em->start)
 			force_bio_submit = true;
 
-		if (prev_em_start)
-			*prev_em_start = em->start;
+		bio_ctrl->last_em_start = em->start;
 
 		free_extent_map(em);
 		em = NULL;
@@ -1115,12 +1132,15 @@ int btrfs_read_folio(struct file *file, struct folio *folio)
 	const u64 start = folio_pos(folio);
 	const u64 end = start + folio_size(folio) - 1;
 	struct extent_state *cached_state = NULL;
-	struct btrfs_bio_ctrl bio_ctrl = { .opf = REQ_OP_READ };
+	struct btrfs_bio_ctrl bio_ctrl = {
+		.opf = REQ_OP_READ,
+		.last_em_start = U64_MAX,
+	};
 	struct extent_map *em_cached = NULL;
 	int ret;
 
 	btrfs_lock_and_flush_ordered_range(inode, start, end, &cached_state);
-	ret = btrfs_do_readpage(folio, &em_cached, &bio_ctrl, NULL);
+	ret = btrfs_do_readpage(folio, &em_cached, &bio_ctrl);
 	unlock_extent(&inode->io_tree, start, end, &cached_state);
 
 	free_extent_map(em_cached);
@@ -2391,7 +2411,8 @@ void btrfs_readahead(struct readahead_control *rac)
 {
 	struct btrfs_bio_ctrl bio_ctrl = {
 		.opf = REQ_OP_READ | REQ_RAHEAD,
-		.ractl = rac
+		.ractl = rac,
+		.last_em_start = U64_MAX,
 	};
 	struct folio *folio;
 	struct btrfs_inode *inode = BTRFS_I(rac->mapping->host);
@@ -2399,12 +2420,11 @@ void btrfs_readahead(struct readahead_control *rac)
 	const u64 end = start + readahead_length(rac) - 1;
 	struct extent_state *cached_state = NULL;
 	struct extent_map *em_cached = NULL;
-	u64 prev_em_start = (u64)-1;
 
 	btrfs_lock_and_flush_ordered_range(inode, start, end, &cached_state);
 
 	while ((folio = readahead_folio(rac)) != NULL)
-		btrfs_do_readpage(folio, &em_cached, &bio_ctrl, &prev_em_start);
+		btrfs_do_readpage(folio, &em_cached, &bio_ctrl);
 
 	unlock_extent(&inode->io_tree, start, end, &cached_state);
 
-- 
2.51.0


