Return-Path: <stable+bounces-180160-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E889AB7EC03
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 14:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A199188BE7E
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 12:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8E0330D50;
	Wed, 17 Sep 2025 12:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bFOcvwgj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7BF330D41;
	Wed, 17 Sep 2025 12:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758113568; cv=none; b=uk8hEFu/AOU0ABE5BvnJluz15agJAO8XvoWX/TbfyauUkkL8VOvmxQAOZzbZQ6NlxGDXBGfJ5/dSFKioMK6Qbkfo7E+FRb/T54sLMBsxGtDxJUDQosuGzHnjtxOymtwX0CbCZLIuvqVjpM4uaxlUnMQZsvpbSdJRPIFVNrBdv/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758113568; c=relaxed/simple;
	bh=2axWjKNRdRveeHzQ4Bj5S7PLqEHDjjcofcSV3p01SII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mYZOxMc9LQbG919HFNvznwOFhNj9G3WmqwPWwKmkWmE6z4QyPRcIlQyda7gxG3KGEghtsTUrCgH3eiMGahznGyyIXltMPF66fY8o6pKhf9cJQ09EBOWRI64gouCUuUQKFcszeS/SgV2/x8Xh7PDRgBwmWkX1Hgaqo2xA9qgTy9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bFOcvwgj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D346C4CEF0;
	Wed, 17 Sep 2025 12:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758113568;
	bh=2axWjKNRdRveeHzQ4Bj5S7PLqEHDjjcofcSV3p01SII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bFOcvwgjVMzD1yPtyuce63N1nxyaMn0XHKSe0c4aoqRJavKbMK4ZdWXmR2k6AqDfj
	 gIbiTUCf2cKM+n9nXmG+XjIrBgtSivPb7D0amshmPhI9Qf+oE9mMp75hCq+lvayT0p
	 BWmlrhAZH6edARTrjrMKl6uypplFdkrIxXzNJgnA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dimitrios Apostolou <jimis@gmx.net>,
	Filipe Manana <fdmanana@suse.com>,
	Boris Burkov <boris@bur.io>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 083/140] btrfs: use readahead_expand() on compressed extents
Date: Wed, 17 Sep 2025 14:34:15 +0200
Message-ID: <20250917123346.338981245@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917123344.315037637@linuxfoundation.org>
References: <20250917123344.315037637@linuxfoundation.org>
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/extent_io.c |   34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -108,6 +108,7 @@ struct btrfs_bio_ctrl {
 	 * This is to avoid touching ranges covered by compression/inline.
 	 */
 	unsigned long submit_bitmap;
+	struct readahead_control *ractl;
 };
 
 static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
@@ -929,6 +930,23 @@ static struct extent_map *get_extent_map
 
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
@@ -994,6 +1012,17 @@ static int btrfs_do_readpage(struct foli
 
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
@@ -2360,7 +2389,10 @@ int btrfs_writepages(struct address_spac
 
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



