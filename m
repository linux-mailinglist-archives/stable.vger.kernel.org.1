Return-Path: <stable+bounces-179509-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71683B56230
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 18:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25870580422
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 16:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A097E2EFD8C;
	Sat, 13 Sep 2025 16:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r5fknwLQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD0A1DD0D4
	for <stable@vger.kernel.org>; Sat, 13 Sep 2025 16:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757780037; cv=none; b=MbXEC4RJ8t4LiOAbDhpfrFhHTlvyXmadqyzRUdpgFtIYGU3Ge8f0pPrW2/Okk0nPkMPp5YcFc7wC1yIdI/iMURbU8TMW9Q+1G0oHfYZB9MWcEmiCuNIpu9ljfzMopI48p4Tq+GMybflP1LXQavY0tcAn9j10elr43nReUCTTUAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757780037; c=relaxed/simple;
	bh=t25E7Qx2/8aOFpF5RHCchOM6LswxSq9NjI5Ud7/rQ7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j0EKMB3/J8xy4QB80Yw6kL0JS3ZYuuy2vExyeN5PD3piSUAYZZ9wiMbjNItVKzjpNiJgAb107GWhyKRfF8JZHfkfgPuKlV6pHS+TbtjhiiwTvWzN28111ZbT3saJAWbVXzBeJfy/ZWcgg2AFXfQF/BEMyQcBkhib6BVsYKHayi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r5fknwLQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E041C4CEEB;
	Sat, 13 Sep 2025 16:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757780037;
	bh=t25E7Qx2/8aOFpF5RHCchOM6LswxSq9NjI5Ud7/rQ7I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r5fknwLQDSKAMIoVRLpnom1So740R9tnjorpJ1p9mCiJ0qAK0PVoKO0ehGo5MksnQ
	 5gC+7J8odgXxkr5HiJ0xZgh06d8OFGNBMznPqTmaJpw2QMmyzWlR6JuBbFdHdMVK9J
	 uhlEGJcaT9oLSkrqkCE3+xumWI72pKHpcYVvcBhSKTpiq2SLIXQyXHpigSy2KuZwoQ
	 VvaNf2sdY6h49ZtmCdZBCW0ySjMIHsGCV0uXLOqILDvCxVnim11Y0DcMnAn0Fhpras
	 No/5ZRol9BmiYK1WYw6+EDzYZv/SU+Cs9BVkMLBR43SVs9gea5qAbsljCYeGJhVuKD
	 HlT0pKgWb1X4w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Boris Burkov <boris@bur.io>,
	Dimitrios Apostolou <jimis@gmx.net>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] btrfs: use readahead_expand() on compressed extents
Date: Sat, 13 Sep 2025 12:13:52 -0400
Message-ID: <20250913161353.1443138-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025091345-gloater-dolly-54a5@gregkh>
References: <2025091345-gloater-dolly-54a5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Boris Burkov <boris@bur.io>

[ Upstream commit 9e9ff875e4174be939371667d2cc81244e31232f ]

We recently received a report of poor performance doing sequential
buffered reads of a file with compressed extents. With bs=128k, a naive
sequential dd ran as fast on a compressed file as on an uncompressed
(1.2GB/s on my reproducing system) while with bs<32k, this performance
tanked down to ~300MB/s.

i.e., slow:

  dd if=some-compressed-file of=/dev/null bs=4k count=X

vs fast:

  dd if=some-compressed-file of=/dev/null bs=128k count=Y

The cause of this slowness is overhead to do with looking up extent_maps
to enable readahead pre-caching on compressed extents
(add_ra_bio_pages()), as well as some overhead in the generic VFS
readahead code we hit more in the slow case. Notably, the main
difference between the two read sizes is that in the large sized request
case, we call btrfs_readahead() relatively rarely while in the smaller
request we call it for every compressed extent. So the fast case stays
in the btrfs readahead loop:

    while ((folio = readahead_folio(rac)) != NULL)
	    btrfs_do_readpage(folio, &em_cached, &bio_ctrl, &prev_em_start);

where the slower one breaks out of that loop every time. This results in
calling add_ra_bio_pages a lot, doing lots of extent_map lookups,
extent_map locking, etc.

This happens because although add_ra_bio_pages() does add the
appropriate un-compressed file pages to the cache, it does not
communicate back to the ractl in any way. To solve this, we should be
using readahead_expand() to signal to readahead to expand the readahead
window.

This change passes the readahead_control into the btrfs_bio_ctrl and in
the case of compressed reads sets the expansion to the size of the
extent_map we already looked up anyway. It skips the subpage case as
that one already doesn't do add_ra_bio_pages().

With this change, whether we use bs=4k or bs=128k, btrfs expands the
readahead window up to the largest compressed extent we have seen so far
(in the trivial example: 128k) and the call stacks of the two modes look
identical. Notably, we barely call add_ra_bio_pages at all. And the
performance becomes identical as well. So this change certainly "fixes"
this performance problem.

Of course, it does seem to beg a few questions:

1. Will this waste too much page cache with a too large ra window?
2. Will this somehow cause bugs prevented by the more thoughtful
   checking in add_ra_bio_pages?
3. Should we delete add_ra_bio_pages?

My stabs at some answers:

1. Hard to say. See attempts at generic performance testing below. Is
   there a "readahead_shrink" we should be using? Should we expand more
   slowly, by half the remaining em size each time?
2. I don't think so. Since the new behavior is indistinguishable from
   reading the file with a larger read size passed in, I don't see why
   one would be safe but not the other.
3. Probably! I tested that and it was fine in fstests, and it seems like
   the pages would get re-used just as well in the readahead case.
   However, it is possible some reads that use page cache but not
   btrfs_readahead() could suffer. I will investigate this further as a
   follow up.

I tested the performance implications of this change in 3 ways (using
compress-force=zstd:3 for compression):

Directly test the affected workload of small sequential reads on a
compressed file (improved from ~250MB/s to ~1.2GB/s)

==========for-next==========
  dd /mnt/lol/non-cmpr 4k
  1048576+0 records in
  1048576+0 records out
  4294967296 bytes (4.3 GB, 4.0 GiB) copied, 6.02983 s, 712 MB/s
  dd /mnt/lol/non-cmpr 128k
  32768+0 records in
  32768+0 records out
  4294967296 bytes (4.3 GB, 4.0 GiB) copied, 5.92403 s, 725 MB/s
  dd /mnt/lol/cmpr 4k
  1048576+0 records in
  1048576+0 records out
  4294967296 bytes (4.3 GB, 4.0 GiB) copied, 17.8832 s, 240 MB/s
  dd /mnt/lol/cmpr 128k
  32768+0 records in
  32768+0 records out
  4294967296 bytes (4.3 GB, 4.0 GiB) copied, 3.71001 s, 1.2 GB/s

==========ra-expand==========
  dd /mnt/lol/non-cmpr 4k
  1048576+0 records in
  1048576+0 records out
  4294967296 bytes (4.3 GB, 4.0 GiB) copied, 6.09001 s, 705 MB/s
  dd /mnt/lol/non-cmpr 128k
  32768+0 records in
  32768+0 records out
  4294967296 bytes (4.3 GB, 4.0 GiB) copied, 6.07664 s, 707 MB/s
  dd /mnt/lol/cmpr 4k
  1048576+0 records in
  1048576+0 records out
  4294967296 bytes (4.3 GB, 4.0 GiB) copied, 3.79531 s, 1.1 GB/s
  dd /mnt/lol/cmpr 128k
  32768+0 records in
  32768+0 records out
  4294967296 bytes (4.3 GB, 4.0 GiB) copied, 3.69533 s, 1.2 GB/s

Built the linux kernel from clean (no change)

Ran fsperf. Mostly neutral results with some improvements and
regressions here and there.

Reported-by: Dimitrios Apostolou <jimis@gmx.net>
Link: https://lore.kernel.org/linux-btrfs/34601559-6c16-6ccc-1793-20a97ca0dbba@gmx.net/
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Boris Burkov <boris@bur.io>
Signed-off-by: David Sterba <dsterba@suse.com>
[ Assert doesn't take a format string ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/extent_io.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index d322cf82783f9..c59b6ec43581f 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -108,6 +108,7 @@ struct btrfs_bio_ctrl {
 	 * This is to avoid touching ranges covered by compression/inline.
 	 */
 	unsigned long submit_bitmap;
+	struct readahead_control *ractl;
 };
 
 static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
@@ -929,6 +930,23 @@ static struct extent_map *get_extent_map(struct btrfs_inode *inode,
 
 	return em;
 }
+
+static void btrfs_readahead_expand(struct readahead_control *ractl,
+				   const struct extent_map *em)
+{
+	const u64 ra_pos = readahead_pos(ractl);
+	const u64 ra_end = ra_pos + readahead_length(ractl);
+	const u64 em_end = em->start + em->ram_bytes;
+
+	/* No expansion for holes and inline extents. */
+	if (em->disk_bytenr > EXTENT_MAP_LAST_BYTE)
+		return;
+
+	ASSERT(em_end >= ra_pos);
+	if (em_end > ra_end)
+		readahead_expand(ractl, ra_pos, em_end - ra_pos);
+}
+
 /*
  * basic readpage implementation.  Locked extent state structs are inserted
  * into the tree that are removed when the IO is done (by the end_io
@@ -994,6 +1012,17 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
 
 		iosize = min(extent_map_end(em) - cur, end - cur + 1);
 		iosize = ALIGN(iosize, blocksize);
+
+		/*
+		 * Only expand readahead for extents which are already creating
+		 * the pages anyway in add_ra_bio_pages, which is compressed
+		 * extents in the non subpage case.
+		 */
+		if (bio_ctrl->ractl &&
+		    !btrfs_is_subpage(fs_info, folio->mapping) &&
+		    compress_type != BTRFS_COMPRESS_NONE)
+			btrfs_readahead_expand(bio_ctrl->ractl, em);
+
 		if (compress_type != BTRFS_COMPRESS_NONE)
 			disk_bytenr = em->disk_bytenr;
 		else
@@ -2360,7 +2389,10 @@ int btrfs_writepages(struct address_space *mapping, struct writeback_control *wb
 
 void btrfs_readahead(struct readahead_control *rac)
 {
-	struct btrfs_bio_ctrl bio_ctrl = { .opf = REQ_OP_READ | REQ_RAHEAD };
+	struct btrfs_bio_ctrl bio_ctrl = {
+		.opf = REQ_OP_READ | REQ_RAHEAD,
+		.ractl = rac
+	};
 	struct folio *folio;
 	struct btrfs_inode *inode = BTRFS_I(rac->mapping->host);
 	const u64 start = readahead_pos(rac);
-- 
2.51.0


