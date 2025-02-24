Return-Path: <stable+bounces-119087-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AED49A4245B
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 15:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D56D4423BBF
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 14:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7473114A62A;
	Mon, 24 Feb 2025 14:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F5D2VcLQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B2E17579;
	Mon, 24 Feb 2025 14:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740408278; cv=none; b=JbPaH/7HYjQ5uslTqlPLrvIPMvYjMhDqePM1Hzx9Etm6pBl5lXdv9K0lR2saGVtH3CRABTcVX/ITL7/HA/iCkGzHre13zTCPWQ6LPzRXCg37PnkWVwzUCBXg0Sn9Cz7hE2zn9PEiCjjyhYa8QTxm9d45gVv4IzB//fKmd04+J9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740408278; c=relaxed/simple;
	bh=1CKfqxjDM4itUmOelGLe6cjcZZKyg4EjT/xfmWGrSC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f1qv2JYO5+t3tYUfB1XvODjl+x2jX+GENETGXDL2HdiTN+1yudYkSfjMUaCXOXItnlTFYvwScG3SukYNB29FNGf2zus/RRNwIkdSgwxeZTCklVZFeFSKTVxwVqb0q4nQDl8CW62T2e89nvhFz98iZs0DRk9KCb6SrzTo3S2+gvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F5D2VcLQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85846C4CED6;
	Mon, 24 Feb 2025 14:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740408278;
	bh=1CKfqxjDM4itUmOelGLe6cjcZZKyg4EjT/xfmWGrSC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F5D2VcLQJ+eqCl69RM3tcbyFaJST/3VPWDWdfLgz00nhK1gaUV5PP4VqDDkq/86Z1
	 qI+y4UvvT3w2G/6y13/KbdqWjWJRMaioFt1/IPo5O1rxMos44NaTOi2tPGqR6Efrou
	 Kl+rrXs1bb699/TFh/tX0HWggWwdOiqMGAaPkEfM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 011/154] btrfs: rename btrfs_folio_(set|start|end)_writer_lock()
Date: Mon, 24 Feb 2025 15:33:30 +0100
Message-ID: <20250224142607.516319571@linuxfoundation.org>
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

[ Upstream commit 0f7120266584490616f031873e7148495d77dd68 ]

Since there is no user of reader locks, rename the writer locks into a
more generic name, by removing the "_writer" part from the name.

And also rename btrfs_subpage::writer into btrfs_subpage::locked.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: 8bf334beb349 ("btrfs: fix double accounting race when extent_writepage_io() failed")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/compression.c |  2 +-
 fs/btrfs/extent_io.c   | 14 ++++++-------
 fs/btrfs/subpage.c     | 46 +++++++++++++++++++++---------------------
 fs/btrfs/subpage.h     | 20 ++++++++++--------
 4 files changed, 43 insertions(+), 39 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 64eaf74fbebc8..40332ab62f101 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -545,7 +545,7 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 		 * subpage::readers and to unlock the page.
 		 */
 		if (fs_info->sectorsize < PAGE_SIZE)
-			btrfs_folio_set_writer_lock(fs_info, folio, cur, add_size);
+			btrfs_folio_set_lock(fs_info, folio, cur, add_size);
 		folio_put(folio);
 		cur += add_size;
 	}
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 5d6b3b812593d..5a1bde8cc8b64 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -190,7 +190,7 @@ static void process_one_folio(struct btrfs_fs_info *fs_info,
 		btrfs_folio_clamp_clear_writeback(fs_info, folio, start, len);
 
 	if (folio != locked_folio && (page_ops & PAGE_UNLOCK))
-		btrfs_folio_end_writer_lock(fs_info, folio, start, len);
+		btrfs_folio_end_lock(fs_info, folio, start, len);
 }
 
 static void __process_folios_contig(struct address_space *mapping,
@@ -276,7 +276,7 @@ static noinline int lock_delalloc_folios(struct inode *inode,
 			range_start = max_t(u64, folio_pos(folio), start);
 			range_len = min_t(u64, folio_pos(folio) + folio_size(folio),
 					  end + 1) - range_start;
-			btrfs_folio_set_writer_lock(fs_info, folio, range_start, range_len);
+			btrfs_folio_set_lock(fs_info, folio, range_start, range_len);
 
 			processed_end = range_start + range_len - 1;
 		}
@@ -438,7 +438,7 @@ static void end_folio_read(struct folio *folio, bool uptodate, u64 start, u32 le
 	if (!btrfs_is_subpage(fs_info, folio->mapping))
 		folio_unlock(folio);
 	else
-		btrfs_folio_end_writer_lock(fs_info, folio, start, len);
+		btrfs_folio_end_lock(fs_info, folio, start, len);
 }
 
 /*
@@ -495,7 +495,7 @@ static void begin_folio_read(struct btrfs_fs_info *fs_info, struct folio *folio)
 		return;
 
 	ASSERT(folio_test_private(folio));
-	btrfs_folio_set_writer_lock(fs_info, folio, folio_pos(folio), PAGE_SIZE);
+	btrfs_folio_set_lock(fs_info, folio, folio_pos(folio), PAGE_SIZE);
 }
 
 /*
@@ -1187,7 +1187,7 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 	for_each_set_bit(bit, &bio_ctrl->submit_bitmap, fs_info->sectors_per_page) {
 		u64 start = page_start + (bit << fs_info->sectorsize_bits);
 
-		btrfs_folio_set_writer_lock(fs_info, folio, start, fs_info->sectorsize);
+		btrfs_folio_set_lock(fs_info, folio, start, fs_info->sectorsize);
 	}
 
 	/* Lock all (subpage) delalloc ranges inside the folio first. */
@@ -1523,7 +1523,7 @@ static int extent_writepage(struct folio *folio, struct btrfs_bio_ctrl *bio_ctrl
 	 * Only unlock ranges that are submitted. As there can be some async
 	 * submitted ranges inside the folio.
 	 */
-	btrfs_folio_end_writer_lock_bitmap(fs_info, folio, bio_ctrl->submit_bitmap);
+	btrfs_folio_end_lock_bitmap(fs_info, folio, bio_ctrl->submit_bitmap);
 	ASSERT(ret <= 0);
 	return ret;
 }
@@ -2280,7 +2280,7 @@ void extent_write_locked_range(struct inode *inode, const struct folio *locked_f
 						       cur, cur_len, !ret);
 			mapping_set_error(mapping, ret);
 		}
-		btrfs_folio_end_writer_lock(fs_info, folio, cur, cur_len);
+		btrfs_folio_end_lock(fs_info, folio, cur, cur_len);
 		if (ret < 0)
 			found_error = true;
 next_page:
diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index 0587a7d7b5e81..88a01d51ab11f 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -143,7 +143,7 @@ struct btrfs_subpage *btrfs_alloc_subpage(const struct btrfs_fs_info *fs_info,
 	if (type == BTRFS_SUBPAGE_METADATA)
 		atomic_set(&ret->eb_refs, 0);
 	else
-		atomic_set(&ret->writers, 0);
+		atomic_set(&ret->nr_locked, 0);
 	return ret;
 }
 
@@ -237,8 +237,8 @@ static void btrfs_subpage_clamp_range(struct folio *folio, u64 *start, u32 *len)
 			     orig_start + orig_len) - *start;
 }
 
-static bool btrfs_subpage_end_and_test_writer(const struct btrfs_fs_info *fs_info,
-					      struct folio *folio, u64 start, u32 len)
+static bool btrfs_subpage_end_and_test_lock(const struct btrfs_fs_info *fs_info,
+					    struct folio *folio, u64 start, u32 len)
 {
 	struct btrfs_subpage *subpage = folio_get_private(folio);
 	const int start_bit = subpage_calc_start_bit(fs_info, folio, locked, start, len);
@@ -256,9 +256,9 @@ static bool btrfs_subpage_end_and_test_writer(const struct btrfs_fs_info *fs_inf
 	 * extent_clear_unlock_delalloc() for compression path.
 	 *
 	 * This @locked_page is locked by plain lock_page(), thus its
-	 * subpage::writers is 0.  Handle them in a special way.
+	 * subpage::locked is 0.  Handle them in a special way.
 	 */
-	if (atomic_read(&subpage->writers) == 0) {
+	if (atomic_read(&subpage->nr_locked) == 0) {
 		spin_unlock_irqrestore(&subpage->lock, flags);
 		return true;
 	}
@@ -267,8 +267,8 @@ static bool btrfs_subpage_end_and_test_writer(const struct btrfs_fs_info *fs_inf
 		clear_bit(bit, subpage->bitmaps);
 		cleared++;
 	}
-	ASSERT(atomic_read(&subpage->writers) >= cleared);
-	last = atomic_sub_and_test(cleared, &subpage->writers);
+	ASSERT(atomic_read(&subpage->nr_locked) >= cleared);
+	last = atomic_sub_and_test(cleared, &subpage->nr_locked);
 	spin_unlock_irqrestore(&subpage->lock, flags);
 	return last;
 }
@@ -289,8 +289,8 @@ static bool btrfs_subpage_end_and_test_writer(const struct btrfs_fs_info *fs_inf
  *   bitmap, reduce the writer lock number, and unlock the page if that's
  *   the last locked range.
  */
-void btrfs_folio_end_writer_lock(const struct btrfs_fs_info *fs_info,
-				 struct folio *folio, u64 start, u32 len)
+void btrfs_folio_end_lock(const struct btrfs_fs_info *fs_info,
+			  struct folio *folio, u64 start, u32 len)
 {
 	struct btrfs_subpage *subpage = folio_get_private(folio);
 
@@ -303,24 +303,24 @@ void btrfs_folio_end_writer_lock(const struct btrfs_fs_info *fs_info,
 
 	/*
 	 * For subpage case, there are two types of locked page.  With or
-	 * without writers number.
+	 * without locked number.
 	 *
-	 * Since we own the page lock, no one else could touch subpage::writers
+	 * Since we own the page lock, no one else could touch subpage::locked
 	 * and we are safe to do several atomic operations without spinlock.
 	 */
-	if (atomic_read(&subpage->writers) == 0) {
-		/* No writers, locked by plain lock_page(). */
+	if (atomic_read(&subpage->nr_locked) == 0) {
+		/* No subpage lock, locked by plain lock_page(). */
 		folio_unlock(folio);
 		return;
 	}
 
 	btrfs_subpage_clamp_range(folio, &start, &len);
-	if (btrfs_subpage_end_and_test_writer(fs_info, folio, start, len))
+	if (btrfs_subpage_end_and_test_lock(fs_info, folio, start, len))
 		folio_unlock(folio);
 }
 
-void btrfs_folio_end_writer_lock_bitmap(const struct btrfs_fs_info *fs_info,
-					struct folio *folio, unsigned long bitmap)
+void btrfs_folio_end_lock_bitmap(const struct btrfs_fs_info *fs_info,
+				 struct folio *folio, unsigned long bitmap)
 {
 	struct btrfs_subpage *subpage = folio_get_private(folio);
 	const int start_bit = fs_info->sectors_per_page * btrfs_bitmap_nr_locked;
@@ -334,8 +334,8 @@ void btrfs_folio_end_writer_lock_bitmap(const struct btrfs_fs_info *fs_info,
 		return;
 	}
 
-	if (atomic_read(&subpage->writers) == 0) {
-		/* No writers, locked by plain lock_page(). */
+	if (atomic_read(&subpage->nr_locked) == 0) {
+		/* No subpage lock, locked by plain lock_page(). */
 		folio_unlock(folio);
 		return;
 	}
@@ -345,8 +345,8 @@ void btrfs_folio_end_writer_lock_bitmap(const struct btrfs_fs_info *fs_info,
 		if (test_and_clear_bit(bit + start_bit, subpage->bitmaps))
 			cleared++;
 	}
-	ASSERT(atomic_read(&subpage->writers) >= cleared);
-	last = atomic_sub_and_test(cleared, &subpage->writers);
+	ASSERT(atomic_read(&subpage->nr_locked) >= cleared);
+	last = atomic_sub_and_test(cleared, &subpage->nr_locked);
 	spin_unlock_irqrestore(&subpage->lock, flags);
 	if (last)
 		folio_unlock(folio);
@@ -671,8 +671,8 @@ void btrfs_folio_assert_not_dirty(const struct btrfs_fs_info *fs_info,
  * This populates the involved subpage ranges so that subpage helpers can
  * properly unlock them.
  */
-void btrfs_folio_set_writer_lock(const struct btrfs_fs_info *fs_info,
-				 struct folio *folio, u64 start, u32 len)
+void btrfs_folio_set_lock(const struct btrfs_fs_info *fs_info,
+			  struct folio *folio, u64 start, u32 len)
 {
 	struct btrfs_subpage *subpage;
 	unsigned long flags;
@@ -691,7 +691,7 @@ void btrfs_folio_set_writer_lock(const struct btrfs_fs_info *fs_info,
 	/* Target range should not yet be locked. */
 	ASSERT(bitmap_test_range_all_zero(subpage->bitmaps, start_bit, nbits));
 	bitmap_set(subpage->bitmaps, start_bit, nbits);
-	ret = atomic_add_return(nbits, &subpage->writers);
+	ret = atomic_add_return(nbits, &subpage->nr_locked);
 	ASSERT(ret <= fs_info->sectors_per_page);
 	spin_unlock_irqrestore(&subpage->lock, flags);
 }
diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
index 8488ea057b30b..44fff1f4eac48 100644
--- a/fs/btrfs/subpage.h
+++ b/fs/btrfs/subpage.h
@@ -54,8 +54,12 @@ struct btrfs_subpage {
 		 */
 		atomic_t eb_refs;
 
-		/* Structures only used by data */
-		atomic_t writers;
+		/*
+		 * Structures only used by data,
+		 *
+		 * How many sectors inside the page is locked.
+		 */
+		atomic_t nr_locked;
 	};
 	unsigned long bitmaps[];
 };
@@ -87,12 +91,12 @@ void btrfs_free_subpage(struct btrfs_subpage *subpage);
 void btrfs_folio_inc_eb_refs(const struct btrfs_fs_info *fs_info, struct folio *folio);
 void btrfs_folio_dec_eb_refs(const struct btrfs_fs_info *fs_info, struct folio *folio);
 
-void btrfs_folio_end_writer_lock(const struct btrfs_fs_info *fs_info,
-				 struct folio *folio, u64 start, u32 len);
-void btrfs_folio_set_writer_lock(const struct btrfs_fs_info *fs_info,
-				 struct folio *folio, u64 start, u32 len);
-void btrfs_folio_end_writer_lock_bitmap(const struct btrfs_fs_info *fs_info,
-					struct folio *folio, unsigned long bitmap);
+void btrfs_folio_end_lock(const struct btrfs_fs_info *fs_info,
+			  struct folio *folio, u64 start, u32 len);
+void btrfs_folio_set_lock(const struct btrfs_fs_info *fs_info,
+			  struct folio *folio, u64 start, u32 len);
+void btrfs_folio_end_lock_bitmap(const struct btrfs_fs_info *fs_info,
+				 struct folio *folio, unsigned long bitmap);
 /*
  * Template for subpage related operations.
  *
-- 
2.39.5




