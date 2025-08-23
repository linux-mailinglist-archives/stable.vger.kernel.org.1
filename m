Return-Path: <stable+bounces-172612-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5A5B3296A
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 16:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6725E6854A6
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 14:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438B62848B4;
	Sat, 23 Aug 2025 14:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Pma8byMQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BEA25C80F;
	Sat, 23 Aug 2025 14:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755960700; cv=none; b=COrnO6/hIg8lpBF6dNz+s60YtZCkU7dlg88eUpQlwL/t1Fj7enByLjHMw5n82/sSorf50ypmrTXAS8BwMRosdWbKJ4RMZR3yzmRj/EWZnblybO3Y2ZDLYNSRj+BnN5OgkVaRUROknPG3K9dfb5T2bC9Trx+D9MED+RM6ADYSV9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755960700; c=relaxed/simple;
	bh=NiYiSAzH2FeMko/U1pIXxZvRy3V+sVOyr730YV1NLjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X5zOcY/akkx0FCGO/+W1KOBhUSHDhGp6VoOQmJfEALpTL2LaOAnreX1rdgRmFMxmlklJUKHOCPOK6988ZPpQNeg1Usk6Io9Knba9esWKB9wxTqByjlQqQy2I4rVg4OzrjvS5DS6bP0VR2ogMEe2ujw39htvvN1WSmr5vmOlSJD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Pma8byMQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0E1EC4CEE7;
	Sat, 23 Aug 2025 14:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755960699;
	bh=NiYiSAzH2FeMko/U1pIXxZvRy3V+sVOyr730YV1NLjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pma8byMQSzfpg3UF63s+dXRXflkzYAzJO9yg/4I1AE4fVs5VjR8ohZeZMM5okyL2Y
	 jffdiKwF0AoUzA3BT02seEyIFX3IcRn+QRlpZ8lFpm2f9AwDlwSRgSOp+1OrpzDa7j
	 BFInCcz/Io4Ke8FkIjspAX2Z8UGY+eiDI7Uf8bUc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.16.3
Date: Sat, 23 Aug 2025 16:51:27 +0200
Message-ID: <2025082354-mushily-uncertain-529d@gregkh>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082354-halogen-retaliate-a8ba@gregkh>
References: <2025082354-halogen-retaliate-a8ba@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index ed2967dd07d5..df1213830643 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 16
-SUBLEVEL = 2
+SUBLEVEL = 3
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index fe3366e98493..9ac0a7d4fa0c 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3064,9 +3064,9 @@ extern int ext4_punch_hole(struct file *file, loff_t offset, loff_t length);
 extern void ext4_set_inode_flags(struct inode *, bool init);
 extern int ext4_alloc_da_blocks(struct inode *inode);
 extern void ext4_set_aops(struct inode *inode);
-extern int ext4_writepage_trans_blocks(struct inode *);
 extern int ext4_normal_submit_inode_data_buffers(struct jbd2_inode *jinode);
 extern int ext4_chunk_trans_blocks(struct inode *, int nrblocks);
+extern int ext4_chunk_trans_extent(struct inode *inode, int nrblocks);
 extern int ext4_meta_trans_blocks(struct inode *inode, int lblocks,
 				  int pextents);
 extern int ext4_zero_partial_blocks(handle_t *handle, struct inode *inode,
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index b543a46fc809..f0f155458697 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -5171,7 +5171,7 @@ ext4_ext_shift_path_extents(struct ext4_ext_path *path, ext4_lblk_t shift,
 				credits = depth + 2;
 			}
 
-			restart_credits = ext4_writepage_trans_blocks(inode);
+			restart_credits = ext4_chunk_trans_extent(inode, 0);
 			err = ext4_datasem_ensure_credits(handle, inode, credits,
 					restart_credits, 0);
 			if (err) {
@@ -5431,7 +5431,7 @@ static int ext4_collapse_range(struct file *file, loff_t offset, loff_t len)
 
 	truncate_pagecache(inode, start);
 
-	credits = ext4_writepage_trans_blocks(inode);
+	credits = ext4_chunk_trans_extent(inode, 0);
 	handle = ext4_journal_start(inode, EXT4_HT_TRUNCATE, credits);
 	if (IS_ERR(handle))
 		return PTR_ERR(handle);
@@ -5527,7 +5527,7 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
 
 	truncate_pagecache(inode, start);
 
-	credits = ext4_writepage_trans_blocks(inode);
+	credits = ext4_chunk_trans_extent(inode, 0);
 	handle = ext4_journal_start(inode, EXT4_HT_TRUNCATE, credits);
 	if (IS_ERR(handle))
 		return PTR_ERR(handle);
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 05313c8ffb9c..38874d62f88c 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -570,7 +570,7 @@ static int ext4_convert_inline_data_to_extent(struct address_space *mapping,
 		return 0;
 	}
 
-	needed_blocks = ext4_writepage_trans_blocks(inode);
+	needed_blocks = ext4_chunk_trans_extent(inode, 1);
 
 	ret = ext4_get_inode_loc(inode, &iloc);
 	if (ret)
@@ -1874,7 +1874,7 @@ int ext4_inline_data_truncate(struct inode *inode, int *has_inline)
 	};
 
 
-	needed_blocks = ext4_writepage_trans_blocks(inode);
+	needed_blocks = ext4_chunk_trans_extent(inode, 1);
 	handle = ext4_journal_start(inode, EXT4_HT_INODE, needed_blocks);
 	if (IS_ERR(handle))
 		return PTR_ERR(handle);
@@ -1994,7 +1994,7 @@ int ext4_convert_inline_data(struct inode *inode)
 			return 0;
 	}
 
-	needed_blocks = ext4_writepage_trans_blocks(inode);
+	needed_blocks = ext4_chunk_trans_extent(inode, 1);
 
 	iloc.bh = NULL;
 	error = ext4_get_inode_loc(inode, &iloc);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 0f316632b8dd..3df0796a3010 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -877,6 +877,26 @@ static void ext4_update_bh_state(struct buffer_head *bh, unsigned long flags)
 	} while (unlikely(!try_cmpxchg(&bh->b_state, &old_state, new_state)));
 }
 
+/*
+ * Make sure that the current journal transaction has enough credits to map
+ * one extent. Return -EAGAIN if it cannot extend the current running
+ * transaction.
+ */
+static inline int ext4_journal_ensure_extent_credits(handle_t *handle,
+						     struct inode *inode)
+{
+	int credits;
+	int ret;
+
+	/* Called from ext4_da_write_begin() which has no handle started? */
+	if (!handle)
+		return 0;
+
+	credits = ext4_chunk_trans_blocks(inode, 1);
+	ret = __ext4_journal_ensure_credits(handle, credits, credits, 0);
+	return ret <= 0 ? ret : -EAGAIN;
+}
+
 static int _ext4_get_block(struct inode *inode, sector_t iblock,
 			   struct buffer_head *bh, int flags)
 {
@@ -1175,7 +1195,9 @@ int ext4_block_write_begin(handle_t *handle, struct folio *folio,
 			clear_buffer_new(bh);
 		if (!buffer_mapped(bh)) {
 			WARN_ON(bh->b_size != blocksize);
-			err = get_block(inode, block, bh, 1);
+			err = ext4_journal_ensure_extent_credits(handle, inode);
+			if (!err)
+				err = get_block(inode, block, bh, 1);
 			if (err)
 				break;
 			if (buffer_new(bh)) {
@@ -1274,7 +1296,8 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
 	 * Reserve one block more for addition to orphan list in case
 	 * we allocate blocks but write fails for some reason
 	 */
-	needed_blocks = ext4_writepage_trans_blocks(inode) + 1;
+	needed_blocks = ext4_chunk_trans_extent(inode,
+			ext4_journal_blocks_per_folio(inode)) + 1;
 	index = pos >> PAGE_SHIFT;
 
 	if (ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA)) {
@@ -1374,8 +1397,9 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
 				ext4_orphan_del(NULL, inode);
 		}
 
-		if (ret == -ENOSPC &&
-		    ext4_should_retry_alloc(inode->i_sb, &retries))
+		if (ret == -EAGAIN ||
+		    (ret == -ENOSPC &&
+		     ext4_should_retry_alloc(inode->i_sb, &retries)))
 			goto retry_journal;
 		folio_put(folio);
 		return ret;
@@ -1668,11 +1692,12 @@ struct mpage_da_data {
 	unsigned int can_map:1;	/* Can writepages call map blocks? */
 
 	/* These are internal state of ext4_do_writepages() */
-	pgoff_t first_page;	/* The first page to write */
-	pgoff_t next_page;	/* Current page to examine */
-	pgoff_t last_page;	/* Last page to examine */
+	loff_t start_pos;	/* The start pos to write */
+	loff_t next_pos;	/* Current pos to examine */
+	loff_t end_pos;		/* Last pos to examine */
+
 	/*
-	 * Extent to map - this can be after first_page because that can be
+	 * Extent to map - this can be after start_pos because that can be
 	 * fully mapped. We somewhat abuse m_flags to store whether the extent
 	 * is delalloc or unwritten.
 	 */
@@ -1692,38 +1717,38 @@ static void mpage_release_unused_pages(struct mpage_da_data *mpd,
 	struct inode *inode = mpd->inode;
 	struct address_space *mapping = inode->i_mapping;
 
-	/* This is necessary when next_page == 0. */
-	if (mpd->first_page >= mpd->next_page)
+	/* This is necessary when next_pos == 0. */
+	if (mpd->start_pos >= mpd->next_pos)
 		return;
 
 	mpd->scanned_until_end = 0;
-	index = mpd->first_page;
-	end   = mpd->next_page - 1;
 	if (invalidate) {
 		ext4_lblk_t start, last;
-		start = index << (PAGE_SHIFT - inode->i_blkbits);
-		last = end << (PAGE_SHIFT - inode->i_blkbits);
+		start = EXT4_B_TO_LBLK(inode, mpd->start_pos);
+		last = mpd->next_pos >> inode->i_blkbits;
 
 		/*
 		 * avoid racing with extent status tree scans made by
 		 * ext4_insert_delayed_block()
 		 */
 		down_write(&EXT4_I(inode)->i_data_sem);
-		ext4_es_remove_extent(inode, start, last - start + 1);
+		ext4_es_remove_extent(inode, start, last - start);
 		up_write(&EXT4_I(inode)->i_data_sem);
 	}
 
 	folio_batch_init(&fbatch);
-	while (index <= end) {
-		nr = filemap_get_folios(mapping, &index, end, &fbatch);
+	index = mpd->start_pos >> PAGE_SHIFT;
+	end = mpd->next_pos >> PAGE_SHIFT;
+	while (index < end) {
+		nr = filemap_get_folios(mapping, &index, end - 1, &fbatch);
 		if (nr == 0)
 			break;
 		for (i = 0; i < nr; i++) {
 			struct folio *folio = fbatch.folios[i];
 
-			if (folio->index < mpd->first_page)
+			if (folio_pos(folio) < mpd->start_pos)
 				continue;
-			if (folio_next_index(folio) - 1 > end)
+			if (folio_next_index(folio) > end)
 				continue;
 			BUG_ON(!folio_test_locked(folio));
 			BUG_ON(folio_test_writeback(folio));
@@ -2025,7 +2050,8 @@ int ext4_da_get_block_prep(struct inode *inode, sector_t iblock,
 
 static void mpage_folio_done(struct mpage_da_data *mpd, struct folio *folio)
 {
-	mpd->first_page += folio_nr_pages(folio);
+	mpd->start_pos += folio_size(folio);
+	mpd->wbc->nr_to_write -= folio_nr_pages(folio);
 	folio_unlock(folio);
 }
 
@@ -2035,7 +2061,7 @@ static int mpage_submit_folio(struct mpage_da_data *mpd, struct folio *folio)
 	loff_t size;
 	int err;
 
-	BUG_ON(folio->index != mpd->first_page);
+	WARN_ON_ONCE(folio_pos(folio) != mpd->start_pos);
 	folio_clear_dirty_for_io(folio);
 	/*
 	 * We have to be very careful here!  Nothing protects writeback path
@@ -2056,8 +2082,6 @@ static int mpage_submit_folio(struct mpage_da_data *mpd, struct folio *folio)
 	    !ext4_verity_in_progress(mpd->inode))
 		len = size & (len - 1);
 	err = ext4_bio_write_folio(&mpd->io_submit, folio, len);
-	if (!err)
-		mpd->wbc->nr_to_write -= folio_nr_pages(folio);
 
 	return err;
 }
@@ -2324,6 +2348,11 @@ static int mpage_map_one_extent(handle_t *handle, struct mpage_da_data *mpd)
 	int get_blocks_flags;
 	int err, dioread_nolock;
 
+	/* Make sure transaction has enough credits for this extent */
+	err = ext4_journal_ensure_extent_credits(handle, inode);
+	if (err < 0)
+		return err;
+
 	trace_ext4_da_write_pages_extent(inode, map);
 	/*
 	 * Call ext4_map_blocks() to allocate any delayed allocation blocks, or
@@ -2362,6 +2391,47 @@ static int mpage_map_one_extent(handle_t *handle, struct mpage_da_data *mpd)
 	return 0;
 }
 
+/*
+ * This is used to submit mapped buffers in a single folio that is not fully
+ * mapped for various reasons, such as insufficient space or journal credits.
+ */
+static int mpage_submit_partial_folio(struct mpage_da_data *mpd)
+{
+	struct inode *inode = mpd->inode;
+	struct folio *folio;
+	loff_t pos;
+	int ret;
+
+	folio = filemap_get_folio(inode->i_mapping,
+				  mpd->start_pos >> PAGE_SHIFT);
+	if (IS_ERR(folio))
+		return PTR_ERR(folio);
+	/*
+	 * The mapped position should be within the current processing folio
+	 * but must not be the folio start position.
+	 */
+	pos = ((loff_t)mpd->map.m_lblk) << inode->i_blkbits;
+	if (WARN_ON_ONCE((folio_pos(folio) == pos) ||
+			 !folio_contains(folio, pos >> PAGE_SHIFT)))
+		return -EINVAL;
+
+	ret = mpage_submit_folio(mpd, folio);
+	if (ret)
+		goto out;
+	/*
+	 * Update start_pos to prevent this folio from being released in
+	 * mpage_release_unused_pages(), it will be reset to the aligned folio
+	 * pos when this folio is written again in the next round. Additionally,
+	 * do not update wbc->nr_to_write here, as it will be updated once the
+	 * entire folio has finished processing.
+	 */
+	mpd->start_pos = pos;
+out:
+	folio_unlock(folio);
+	folio_put(folio);
+	return ret;
+}
+
 /*
  * mpage_map_and_submit_extent - map extent starting at mpd->lblk of length
  *				 mpd->len and submit pages underlying it for IO
@@ -2410,10 +2480,18 @@ static int mpage_map_and_submit_extent(handle_t *handle,
 			 * In the case of ENOSPC, if ext4_count_free_blocks()
 			 * is non-zero, a commit should free up blocks.
 			 */
-			if ((err == -ENOMEM) ||
+			if ((err == -ENOMEM) || (err == -EAGAIN) ||
 			    (err == -ENOSPC && ext4_count_free_clusters(sb))) {
-				if (progress)
+				/*
+				 * We may have already allocated extents for
+				 * some bhs inside the folio, issue the
+				 * corresponding data to prevent stale data.
+				 */
+				if (progress) {
+					if (mpage_submit_partial_folio(mpd))
+						goto invalidate_dirty_pages;
 					goto update_disksize;
+				}
 				return err;
 			}
 			ext4_msg(sb, KERN_CRIT,
@@ -2447,7 +2525,7 @@ static int mpage_map_and_submit_extent(handle_t *handle,
 	 * Update on-disk size after IO is submitted.  Races with
 	 * truncate are avoided by checking i_size under i_data_sem.
 	 */
-	disksize = ((loff_t)mpd->first_page) << PAGE_SHIFT;
+	disksize = mpd->start_pos;
 	if (disksize > READ_ONCE(EXT4_I(inode)->i_disksize)) {
 		int err2;
 		loff_t i_size;
@@ -2471,21 +2549,6 @@ static int mpage_map_and_submit_extent(handle_t *handle,
 	return err;
 }
 
-/*
- * Calculate the total number of credits to reserve for one writepages
- * iteration. This is called from ext4_writepages(). We map an extent of
- * up to MAX_WRITEPAGES_EXTENT_LEN blocks and then we go on and finish mapping
- * the last partial page. So in total we can map MAX_WRITEPAGES_EXTENT_LEN +
- * bpp - 1 blocks in bpp different extents.
- */
-static int ext4_da_writepages_trans_blocks(struct inode *inode)
-{
-	int bpp = ext4_journal_blocks_per_folio(inode);
-
-	return ext4_meta_trans_blocks(inode,
-				MAX_WRITEPAGES_EXTENT_LEN + bpp - 1, bpp);
-}
-
 static int ext4_journal_folio_buffers(handle_t *handle, struct folio *folio,
 				     size_t len)
 {
@@ -2550,8 +2613,8 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 	struct address_space *mapping = mpd->inode->i_mapping;
 	struct folio_batch fbatch;
 	unsigned int nr_folios;
-	pgoff_t index = mpd->first_page;
-	pgoff_t end = mpd->last_page;
+	pgoff_t index = mpd->start_pos >> PAGE_SHIFT;
+	pgoff_t end = mpd->end_pos >> PAGE_SHIFT;
 	xa_mark_t tag;
 	int i, err = 0;
 	int blkbits = mpd->inode->i_blkbits;
@@ -2566,7 +2629,7 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 		tag = PAGECACHE_TAG_DIRTY;
 
 	mpd->map.m_len = 0;
-	mpd->next_page = index;
+	mpd->next_pos = mpd->start_pos;
 	if (ext4_should_journal_data(mpd->inode)) {
 		handle = ext4_journal_start(mpd->inode, EXT4_HT_WRITE_PAGE,
 					    bpp);
@@ -2597,7 +2660,8 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 				goto out;
 
 			/* If we can't merge this page, we are done. */
-			if (mpd->map.m_len > 0 && mpd->next_page != folio->index)
+			if (mpd->map.m_len > 0 &&
+			    mpd->next_pos != folio_pos(folio))
 				goto out;
 
 			if (handle) {
@@ -2643,8 +2707,8 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 			}
 
 			if (mpd->map.m_len == 0)
-				mpd->first_page = folio->index;
-			mpd->next_page = folio_next_index(folio);
+				mpd->start_pos = folio_pos(folio);
+			mpd->next_pos = folio_pos(folio) + folio_size(folio);
 			/*
 			 * Writeout when we cannot modify metadata is simple.
 			 * Just submit the page. For data=journal mode we
@@ -2772,12 +2836,12 @@ static int ext4_do_writepages(struct mpage_da_data *mpd)
 	mpd->journalled_more_data = 0;
 
 	if (ext4_should_dioread_nolock(inode)) {
+		int bpf = ext4_journal_blocks_per_folio(inode);
 		/*
 		 * We may need to convert up to one extent per block in
-		 * the page and we may dirty the inode.
+		 * the folio and we may dirty the inode.
 		 */
-		rsv_blocks = 1 + ext4_chunk_trans_blocks(inode,
-						PAGE_SIZE >> inode->i_blkbits);
+		rsv_blocks = 1 + ext4_ext_index_trans_blocks(inode, bpf);
 	}
 
 	if (wbc->range_start == 0 && wbc->range_end == LLONG_MAX)
@@ -2787,18 +2851,18 @@ static int ext4_do_writepages(struct mpage_da_data *mpd)
 		writeback_index = mapping->writeback_index;
 		if (writeback_index)
 			cycled = 0;
-		mpd->first_page = writeback_index;
-		mpd->last_page = -1;
+		mpd->start_pos = writeback_index << PAGE_SHIFT;
+		mpd->end_pos = LLONG_MAX;
 	} else {
-		mpd->first_page = wbc->range_start >> PAGE_SHIFT;
-		mpd->last_page = wbc->range_end >> PAGE_SHIFT;
+		mpd->start_pos = wbc->range_start;
+		mpd->end_pos = wbc->range_end;
 	}
 
 	ext4_io_submit_init(&mpd->io_submit, wbc);
 retry:
 	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
-		tag_pages_for_writeback(mapping, mpd->first_page,
-					mpd->last_page);
+		tag_pages_for_writeback(mapping, mpd->start_pos >> PAGE_SHIFT,
+					mpd->end_pos >> PAGE_SHIFT);
 	blk_start_plug(&plug);
 
 	/*
@@ -2841,8 +2905,14 @@ static int ext4_do_writepages(struct mpage_da_data *mpd)
 		 * not supported by delalloc.
 		 */
 		BUG_ON(ext4_should_journal_data(inode));
-		needed_blocks = ext4_da_writepages_trans_blocks(inode);
-
+		/*
+		 * Calculate the number of credits needed to reserve for one
+		 * extent of up to MAX_WRITEPAGES_EXTENT_LEN blocks. It will
+		 * attempt to extend the transaction or start a new iteration
+		 * if the reserved credits are insufficient.
+		 */
+		needed_blocks = ext4_chunk_trans_blocks(inode,
+						MAX_WRITEPAGES_EXTENT_LEN);
 		/* start a new transaction */
 		handle = ext4_journal_start_with_reserve(inode,
 				EXT4_HT_WRITE_PAGE, needed_blocks, rsv_blocks);
@@ -2858,7 +2928,8 @@ static int ext4_do_writepages(struct mpage_da_data *mpd)
 		}
 		mpd->do_map = 1;
 
-		trace_ext4_da_write_pages(inode, mpd->first_page, wbc);
+		trace_ext4_da_write_folios_start(inode, mpd->start_pos,
+				mpd->next_pos, wbc);
 		ret = mpage_prepare_extent_to_map(mpd);
 		if (!ret && mpd->map.m_len)
 			ret = mpage_map_and_submit_extent(handle, mpd,
@@ -2896,6 +2967,8 @@ static int ext4_do_writepages(struct mpage_da_data *mpd)
 		} else
 			ext4_put_io_end(mpd->io_submit.io_end);
 		mpd->io_submit.io_end = NULL;
+		trace_ext4_da_write_folios_end(inode, mpd->start_pos,
+				mpd->next_pos, wbc, ret);
 
 		if (ret == -ENOSPC && sbi->s_journal) {
 			/*
@@ -2907,6 +2980,8 @@ static int ext4_do_writepages(struct mpage_da_data *mpd)
 			ret = 0;
 			continue;
 		}
+		if (ret == -EAGAIN)
+			ret = 0;
 		/* Fatal error - ENOMEM, EIO... */
 		if (ret)
 			break;
@@ -2915,8 +2990,8 @@ static int ext4_do_writepages(struct mpage_da_data *mpd)
 	blk_finish_plug(&plug);
 	if (!ret && !cycled && wbc->nr_to_write > 0) {
 		cycled = 1;
-		mpd->last_page = writeback_index - 1;
-		mpd->first_page = 0;
+		mpd->end_pos = (writeback_index << PAGE_SHIFT) - 1;
+		mpd->start_pos = 0;
 		goto retry;
 	}
 
@@ -2926,7 +3001,7 @@ static int ext4_do_writepages(struct mpage_da_data *mpd)
 		 * Set the writeback_index so that range_cyclic
 		 * mode will write it back later
 		 */
-		mapping->writeback_index = mpd->first_page;
+		mapping->writeback_index = mpd->start_pos >> PAGE_SHIFT;
 
 out_writepages:
 	trace_ext4_writepages_result(inode, wbc, ret,
@@ -4390,7 +4465,7 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
 		return ret;
 
 	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
-		credits = ext4_writepage_trans_blocks(inode);
+		credits = ext4_chunk_trans_extent(inode, 2);
 	else
 		credits = ext4_blocks_for_truncate(inode);
 	handle = ext4_journal_start(inode, EXT4_HT_TRUNCATE, credits);
@@ -4539,7 +4614,7 @@ int ext4_truncate(struct inode *inode)
 	}
 
 	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
-		credits = ext4_writepage_trans_blocks(inode);
+		credits = ext4_chunk_trans_extent(inode, 1);
 	else
 		credits = ext4_blocks_for_truncate(inode);
 
@@ -6182,25 +6257,19 @@ int ext4_meta_trans_blocks(struct inode *inode, int lblocks, int pextents)
 }
 
 /*
- * Calculate the total number of credits to reserve to fit
- * the modification of a single pages into a single transaction,
- * which may include multiple chunks of block allocations.
- *
- * This could be called via ext4_write_begin()
- *
- * We need to consider the worse case, when
- * one new block per extent.
+ * Calculate the journal credits for modifying the number of blocks
+ * in a single extent within one transaction. 'nrblocks' is used only
+ * for non-extent inodes. For extent type inodes, 'nrblocks' can be
+ * zero if the exact number of blocks is unknown.
  */
-int ext4_writepage_trans_blocks(struct inode *inode)
+int ext4_chunk_trans_extent(struct inode *inode, int nrblocks)
 {
-	int bpp = ext4_journal_blocks_per_folio(inode);
 	int ret;
 
-	ret = ext4_meta_trans_blocks(inode, bpp, bpp);
-
+	ret = ext4_meta_trans_blocks(inode, nrblocks, 1);
 	/* Account for data blocks for journalled mode */
 	if (ext4_should_journal_data(inode))
-		ret += bpp;
+		ret += nrblocks;
 	return ret;
 }
 
@@ -6572,6 +6641,55 @@ static int ext4_bh_unmapped(handle_t *handle, struct inode *inode,
 	return !buffer_mapped(bh);
 }
 
+static int ext4_block_page_mkwrite(struct inode *inode, struct folio *folio,
+				   get_block_t get_block)
+{
+	handle_t *handle;
+	loff_t size;
+	unsigned long len;
+	int credits;
+	int ret;
+
+	credits = ext4_chunk_trans_extent(inode,
+			ext4_journal_blocks_per_folio(inode));
+	handle = ext4_journal_start(inode, EXT4_HT_WRITE_PAGE, credits);
+	if (IS_ERR(handle))
+		return PTR_ERR(handle);
+
+	folio_lock(folio);
+	size = i_size_read(inode);
+	/* Page got truncated from under us? */
+	if (folio->mapping != inode->i_mapping || folio_pos(folio) > size) {
+		ret = -EFAULT;
+		goto out_error;
+	}
+
+	len = folio_size(folio);
+	if (folio_pos(folio) + len > size)
+		len = size - folio_pos(folio);
+
+	ret = ext4_block_write_begin(handle, folio, 0, len, get_block);
+	if (ret)
+		goto out_error;
+
+	if (!ext4_should_journal_data(inode)) {
+		block_commit_write(folio, 0, len);
+		folio_mark_dirty(folio);
+	} else {
+		ret = ext4_journal_folio_buffers(handle, folio, len);
+		if (ret)
+			goto out_error;
+	}
+	ext4_journal_stop(handle);
+	folio_wait_stable(folio);
+	return ret;
+
+out_error:
+	folio_unlock(folio);
+	ext4_journal_stop(handle);
+	return ret;
+}
+
 vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
@@ -6583,8 +6701,7 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
 	struct file *file = vma->vm_file;
 	struct inode *inode = file_inode(file);
 	struct address_space *mapping = inode->i_mapping;
-	handle_t *handle;
-	get_block_t *get_block;
+	get_block_t *get_block = ext4_get_block;
 	int retries = 0;
 
 	if (unlikely(IS_IMMUTABLE(inode)))
@@ -6652,47 +6769,11 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
 	/* OK, we need to fill the hole... */
 	if (ext4_should_dioread_nolock(inode))
 		get_block = ext4_get_block_unwritten;
-	else
-		get_block = ext4_get_block;
 retry_alloc:
-	handle = ext4_journal_start(inode, EXT4_HT_WRITE_PAGE,
-				    ext4_writepage_trans_blocks(inode));
-	if (IS_ERR(handle)) {
-		ret = VM_FAULT_SIGBUS;
-		goto out;
-	}
-	/*
-	 * Data journalling can't use block_page_mkwrite() because it
-	 * will set_buffer_dirty() before do_journal_get_write_access()
-	 * thus might hit warning messages for dirty metadata buffers.
-	 */
-	if (!ext4_should_journal_data(inode)) {
-		err = block_page_mkwrite(vma, vmf, get_block);
-	} else {
-		folio_lock(folio);
-		size = i_size_read(inode);
-		/* Page got truncated from under us? */
-		if (folio->mapping != mapping || folio_pos(folio) > size) {
-			ret = VM_FAULT_NOPAGE;
-			goto out_error;
-		}
-
-		len = folio_size(folio);
-		if (folio_pos(folio) + len > size)
-			len = size - folio_pos(folio);
-
-		err = ext4_block_write_begin(handle, folio, 0, len,
-					     ext4_get_block);
-		if (!err) {
-			ret = VM_FAULT_SIGBUS;
-			if (ext4_journal_folio_buffers(handle, folio, len))
-				goto out_error;
-		} else {
-			folio_unlock(folio);
-		}
-	}
-	ext4_journal_stop(handle);
-	if (err == -ENOSPC && ext4_should_retry_alloc(inode->i_sb, &retries))
+	/* Start journal and allocate blocks */
+	err = ext4_block_page_mkwrite(inode, folio, get_block);
+	if (err == -EAGAIN ||
+	    (err == -ENOSPC && ext4_should_retry_alloc(inode->i_sb, &retries)))
 		goto retry_alloc;
 out_ret:
 	ret = vmf_fs_error(err);
@@ -6700,8 +6781,4 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
 	filemap_invalidate_unlock_shared(mapping);
 	sb_end_pagefault(inode->i_sb);
 	return ret;
-out_error:
-	folio_unlock(folio);
-	ext4_journal_stop(handle);
-	goto out;
 }
diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index 1f8493a56e8f..adae3caf175a 100644
--- a/fs/ext4/move_extent.c
+++ b/fs/ext4/move_extent.c
@@ -280,7 +280,8 @@ move_extent_per_page(struct file *o_filp, struct inode *donor_inode,
 	 */
 again:
 	*err = 0;
-	jblocks = ext4_writepage_trans_blocks(orig_inode) * 2;
+	jblocks = ext4_meta_trans_blocks(orig_inode, block_len_in_page,
+					 block_len_in_page) * 2;
 	handle = ext4_journal_start(orig_inode, EXT4_HT_MOVE_EXTENTS, jblocks);
 	if (IS_ERR(handle)) {
 		*err = PTR_ERR(handle);
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 8d15acbacc20..3fb93247330d 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -962,7 +962,7 @@ int __ext4_xattr_set_credits(struct super_block *sb, struct inode *inode,
 	 * so we need to reserve credits for this eventuality
 	 */
 	if (inode && ext4_has_inline_data(inode))
-		credits += ext4_writepage_trans_blocks(inode) + 1;
+		credits += ext4_chunk_trans_extent(inode, 1) + 1;
 
 	/* We are done if ea_inode feature is not enabled. */
 	if (!ext4_has_feature_ea_inode(sb))
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index 156908641e68..845451077c41 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -482,16 +482,17 @@ TRACE_EVENT(ext4_writepages,
 		  (unsigned long) __entry->writeback_index)
 );
 
-TRACE_EVENT(ext4_da_write_pages,
-	TP_PROTO(struct inode *inode, pgoff_t first_page,
+TRACE_EVENT(ext4_da_write_folios_start,
+	TP_PROTO(struct inode *inode, loff_t start_pos, loff_t next_pos,
 		 struct writeback_control *wbc),
 
-	TP_ARGS(inode, first_page, wbc),
+	TP_ARGS(inode, start_pos, next_pos, wbc),
 
 	TP_STRUCT__entry(
 		__field(	dev_t,	dev			)
 		__field(	ino_t,	ino			)
-		__field(      pgoff_t,	first_page		)
+		__field(       loff_t,	start_pos		)
+		__field(       loff_t,	next_pos		)
 		__field(	 long,	nr_to_write		)
 		__field(	  int,	sync_mode		)
 	),
@@ -499,18 +500,48 @@ TRACE_EVENT(ext4_da_write_pages,
 	TP_fast_assign(
 		__entry->dev		= inode->i_sb->s_dev;
 		__entry->ino		= inode->i_ino;
-		__entry->first_page	= first_page;
+		__entry->start_pos	= start_pos;
+		__entry->next_pos	= next_pos;
 		__entry->nr_to_write	= wbc->nr_to_write;
 		__entry->sync_mode	= wbc->sync_mode;
 	),
 
-	TP_printk("dev %d,%d ino %lu first_page %lu nr_to_write %ld "
-		  "sync_mode %d",
+	TP_printk("dev %d,%d ino %lu start_pos 0x%llx next_pos 0x%llx nr_to_write %ld sync_mode %d",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
-		  (unsigned long) __entry->ino, __entry->first_page,
+		  (unsigned long) __entry->ino, __entry->start_pos, __entry->next_pos,
 		  __entry->nr_to_write, __entry->sync_mode)
 );
 
+TRACE_EVENT(ext4_da_write_folios_end,
+	TP_PROTO(struct inode *inode, loff_t start_pos, loff_t next_pos,
+		 struct writeback_control *wbc, int ret),
+
+	TP_ARGS(inode, start_pos, next_pos, wbc, ret),
+
+	TP_STRUCT__entry(
+		__field(	dev_t,	dev			)
+		__field(	ino_t,	ino			)
+		__field(       loff_t,	start_pos		)
+		__field(       loff_t,	next_pos		)
+		__field(	 long,	nr_to_write		)
+		__field(	  int,	ret			)
+	),
+
+	TP_fast_assign(
+		__entry->dev		= inode->i_sb->s_dev;
+		__entry->ino		= inode->i_ino;
+		__entry->start_pos	= start_pos;
+		__entry->next_pos	= next_pos;
+		__entry->nr_to_write	= wbc->nr_to_write;
+		__entry->ret		= ret;
+	),
+
+	TP_printk("dev %d,%d ino %lu start_pos 0x%llx next_pos 0x%llx nr_to_write %ld ret %d",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  (unsigned long) __entry->ino, __entry->start_pos, __entry->next_pos,
+		  __entry->nr_to_write, __entry->ret)
+);
+
 TRACE_EVENT(ext4_da_write_pages_extent,
 	TP_PROTO(struct inode *inode, struct ext4_map_blocks *map),
 

