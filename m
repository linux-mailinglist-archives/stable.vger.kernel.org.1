Return-Path: <stable+bounces-119100-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BAAAA42430
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 15:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6E8A19C4C46
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 14:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF11B18A6BA;
	Mon, 24 Feb 2025 14:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lPihQnv+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCBD38DD8;
	Mon, 24 Feb 2025 14:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740408322; cv=none; b=R5Y12B+5HgDMqn5jlmt0VR4MlrNiW7icWzq/erHw/KlHo56xz36wiQTXHVd0mV1E2WRnpqRO2ggPDpT57WvxRGipJD+vAA0sv55/F47s1C7zcgJSSMfFMj80fq6+rSHD6ibAnzXC4xWdfBmRqCMjutfdaHmIipMdJ9UQad6ELgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740408322; c=relaxed/simple;
	bh=WiKYsGyzlb0aIAK82jKO925PZl5VUlpYjcW6yBSuAqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tGt+Y9poES7rqt4qDd5sjZ3mnZl5cEue10nMJX/pdcJ5EZ2KP7HiwsL7YgctskHTbpJHufIShpx/EB/whiT3hICLFzWbqRLxLE4dsU5Yxel/OeqSEWNlgXiRZo14QayQ4mJBqDGt298IZgLhUxIq8MEApeIxeP9AbHZPDhndDBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lPihQnv+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CD45C4CEE8;
	Mon, 24 Feb 2025 14:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740408322;
	bh=WiKYsGyzlb0aIAK82jKO925PZl5VUlpYjcW6yBSuAqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lPihQnv+xBA0e5CbcTZO6UiVYZb840LxB3Q2L5wdzQ3XjjbQsME3Cfa6wDoutuLfV
	 0RSFfB3YoYKhJUjehDeYVHirFhaEqoKyVN3//a10EkZSaMgbqsjIubqAfMG2JdGjZO
	 t2kggR4aLJzq1KvSc3T5lq6a0dnVGMzrzx0Rqk6I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 007/154] btrfs: move the delalloc range bitmap search into extent_io.c
Date: Mon, 24 Feb 2025 15:33:26 +0100
Message-ID: <20250224142607.357461857@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224142607.058226288@linuxfoundation.org>
References: <20250224142607.058226288@linuxfoundation.org>
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

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit 2bca8eb0774d271b1077b72f1be135073e0a898f ]

Currently for subpage (sector size < page size) cases, we reuse subpage
locked bitmap to find out all delalloc ranges we have locked, and run
all those found ranges.

However such reuse is not perfect, e.g.:

    0       32K      64K      96K       128K
    |       |////////||///////|    |////|
                                   120K

For above range, writepage_delalloc() for page 0 will handle the range
[32K, 96k), note delalloc range can be beyond the page boundary.

But writepage_delalloc() for page 64K will only handle range [120K,
128K), as the previous run on page 0 has already handled range [64K,
96K).
Meanwhile for the writeback we should expect range [64K, 96K) to also be
locked, this leads to the mismatch from locked bitmap and delalloc
range.

This is not causing problems yet, but it's still an inconsistent
behavior.

So instead of relying on the subpage locked bitmap, move the delalloc
range search using local @delalloc_bitmap, so that we can remove the
existing btrfs_folio_find_writer_locked().

Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: 8bf334beb349 ("btrfs: fix double accounting race when extent_writepage_io() failed")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/extent_io.c | 44 ++++++++++++++++++++++++++++++++++++++++-
 fs/btrfs/subpage.c   | 47 --------------------------------------------
 fs/btrfs/subpage.h   |  4 ----
 3 files changed, 43 insertions(+), 52 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 9ff72a5a13eb3..ba34b92d48c2f 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1105,6 +1105,45 @@ int btrfs_read_folio(struct file *file, struct folio *folio)
 	return ret;
 }
 
+static void set_delalloc_bitmap(struct folio *folio, unsigned long *delalloc_bitmap,
+				u64 start, u32 len)
+{
+	struct btrfs_fs_info *fs_info = folio_to_fs_info(folio);
+	const u64 folio_start = folio_pos(folio);
+	unsigned int start_bit;
+	unsigned int nbits;
+
+	ASSERT(start >= folio_start && start + len <= folio_start + PAGE_SIZE);
+	start_bit = (start - folio_start) >> fs_info->sectorsize_bits;
+	nbits = len >> fs_info->sectorsize_bits;
+	ASSERT(bitmap_test_range_all_zero(delalloc_bitmap, start_bit, nbits));
+	bitmap_set(delalloc_bitmap, start_bit, nbits);
+}
+
+static bool find_next_delalloc_bitmap(struct folio *folio,
+				      unsigned long *delalloc_bitmap, u64 start,
+				      u64 *found_start, u32 *found_len)
+{
+	struct btrfs_fs_info *fs_info = folio_to_fs_info(folio);
+	const u64 folio_start = folio_pos(folio);
+	const unsigned int bitmap_size = fs_info->sectors_per_page;
+	unsigned int start_bit;
+	unsigned int first_zero;
+	unsigned int first_set;
+
+	ASSERT(start >= folio_start && start < folio_start + PAGE_SIZE);
+
+	start_bit = (start - folio_start) >> fs_info->sectorsize_bits;
+	first_set = find_next_bit(delalloc_bitmap, bitmap_size, start_bit);
+	if (first_set >= bitmap_size)
+		return false;
+
+	*found_start = folio_start + (first_set << fs_info->sectorsize_bits);
+	first_zero = find_next_zero_bit(delalloc_bitmap, bitmap_size, first_set);
+	*found_len = (first_zero - first_set) << fs_info->sectorsize_bits;
+	return true;
+}
+
 /*
  * helper for extent_writepage(), doing all of the delayed allocation setup.
  *
@@ -1124,6 +1163,7 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 	const bool is_subpage = btrfs_is_subpage(fs_info, folio->mapping);
 	const u64 page_start = folio_pos(folio);
 	const u64 page_end = page_start + folio_size(folio) - 1;
+	unsigned long delalloc_bitmap = 0;
 	/*
 	 * Save the last found delalloc end. As the delalloc end can go beyond
 	 * page boundary, thus we cannot rely on subpage bitmap to locate the
@@ -1151,6 +1191,8 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 			delalloc_start = delalloc_end + 1;
 			continue;
 		}
+		set_delalloc_bitmap(folio, &delalloc_bitmap, delalloc_start,
+				    min(delalloc_end, page_end) + 1 - delalloc_start);
 		btrfs_folio_set_writer_lock(fs_info, folio, delalloc_start,
 					    min(delalloc_end, page_end) + 1 -
 					    delalloc_start);
@@ -1178,7 +1220,7 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 			found_len = last_delalloc_end + 1 - found_start;
 			found = true;
 		} else {
-			found = btrfs_subpage_find_writer_locked(fs_info, folio,
+			found = find_next_delalloc_bitmap(folio, &delalloc_bitmap,
 					delalloc_start, &found_start, &found_len);
 		}
 		if (!found)
diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index ec7328a6bfd75..c4950e04f481a 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -801,53 +801,6 @@ void btrfs_folio_set_writer_lock(const struct btrfs_fs_info *fs_info,
 	spin_unlock_irqrestore(&subpage->lock, flags);
 }
 
-/*
- * Find any subpage writer locked range inside @folio, starting at file offset
- * @search_start. The caller should ensure the folio is locked.
- *
- * Return true and update @found_start_ret and @found_len_ret to the first
- * writer locked range.
- * Return false if there is no writer locked range.
- */
-bool btrfs_subpage_find_writer_locked(const struct btrfs_fs_info *fs_info,
-				      struct folio *folio, u64 search_start,
-				      u64 *found_start_ret, u32 *found_len_ret)
-{
-	struct btrfs_subpage *subpage = folio_get_private(folio);
-	const u32 sectors_per_page = fs_info->sectors_per_page;
-	const unsigned int len = PAGE_SIZE - offset_in_page(search_start);
-	const unsigned int start_bit = subpage_calc_start_bit(fs_info, folio,
-						locked, search_start, len);
-	const unsigned int locked_bitmap_start = sectors_per_page * btrfs_bitmap_nr_locked;
-	const unsigned int locked_bitmap_end = locked_bitmap_start + sectors_per_page;
-	unsigned long flags;
-	int first_zero;
-	int first_set;
-	bool found = false;
-
-	ASSERT(folio_test_locked(folio));
-	spin_lock_irqsave(&subpage->lock, flags);
-	first_set = find_next_bit(subpage->bitmaps, locked_bitmap_end, start_bit);
-	if (first_set >= locked_bitmap_end)
-		goto out;
-
-	found = true;
-
-	*found_start_ret = folio_pos(folio) +
-		((first_set - locked_bitmap_start) << fs_info->sectorsize_bits);
-	/*
-	 * Since @first_set is ensured to be smaller than locked_bitmap_end
-	 * here, @found_start_ret should be inside the folio.
-	 */
-	ASSERT(*found_start_ret < folio_pos(folio) + PAGE_SIZE);
-
-	first_zero = find_next_zero_bit(subpage->bitmaps, locked_bitmap_end, first_set);
-	*found_len_ret = (first_zero - first_set) << fs_info->sectorsize_bits;
-out:
-	spin_unlock_irqrestore(&subpage->lock, flags);
-	return found;
-}
-
 #define GET_SUBPAGE_BITMAP(subpage, fs_info, name, dst)			\
 {									\
 	const int sectors_per_page = fs_info->sectors_per_page;		\
diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
index cdb554e0d215e..197ec6c0b07b2 100644
--- a/fs/btrfs/subpage.h
+++ b/fs/btrfs/subpage.h
@@ -108,10 +108,6 @@ void btrfs_folio_set_writer_lock(const struct btrfs_fs_info *fs_info,
 				 struct folio *folio, u64 start, u32 len);
 void btrfs_folio_end_writer_lock_bitmap(const struct btrfs_fs_info *fs_info,
 					struct folio *folio, unsigned long bitmap);
-bool btrfs_subpage_find_writer_locked(const struct btrfs_fs_info *fs_info,
-				      struct folio *folio, u64 search_start,
-				      u64 *found_start_ret, u32 *found_len_ret);
-
 /*
  * Template for subpage related operations.
  *
-- 
2.39.5




