Return-Path: <stable+bounces-172371-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F4BB31803
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 14:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6CAF3A13F9
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 12:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77BC52FB63C;
	Fri, 22 Aug 2025 12:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tU5ww+nQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F00C2FB61A;
	Fri, 22 Aug 2025 12:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755866235; cv=none; b=JUMY1wNO9MDA/PBiHv9p2cjk2E0ZvockwWkuPOdYT3ZddeqZGK6hGSPL1eaEqMtUvyQwVvcatLgxiTOcm5ljTXawsHuwS01V5BObRFRKYVzJlP/ZITCvz+9sAjUGK6CrhAXuUHZovgFTlxdZQfs2I0yIw1TRGtPT1uZsMINXXRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755866235; c=relaxed/simple;
	bh=eumNUXs2nDU9J8J70aQealeVuU0/lo7fgD4dqSf+tVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cT85fdzIeuoAZvF1xaEDQyI1XMPyHm1Ey4R/tOsaNzwcZS/H0RTHEWGsOWbHKAUHaJpL6QcXPav2g9GoBlsf9LMPqThKwXg+3Mjg90ENotfTXyhC7JOTjaVyVCJNQkW39uZ5UgmsoUIeeVDE+0s5KVZESM2XuVtghyhZNbX8ltY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tU5ww+nQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 198A1C113CF;
	Fri, 22 Aug 2025 12:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755866233;
	bh=eumNUXs2nDU9J8J70aQealeVuU0/lo7fgD4dqSf+tVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tU5ww+nQnvm7j/Qa7X8+JwhGHwuremLAivZlqGS6WVkCSjEkN63/UMTaGA8w4oReA
	 sLigq1y1BnZm2VbkO7pdu81CLLjMQ/D9cXzx5ckFfEe6Ccb87epwXBKNtTruNKeK+B
	 GIVkw0bKBS0HT6BAtZREEkA+MUPje77YcpLThWuY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jan Kara <jack@suse.cz>,
	Zhang Yi <yi.zhang@huawei.com>,
	Theodore Tso <tytso@mit.edu>
Subject: [PATCH 6.16 1/9] ext4: process folios writeback in bytes
Date: Fri, 22 Aug 2025 14:37:01 +0200
Message-ID: <20250822123516.837435166@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822123516.780248736@linuxfoundation.org>
References: <20250822123516.780248736@linuxfoundation.org>
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

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhang Yi <yi.zhang@huawei.com>

commit 1bfe6354e0975fe89c3d25e81b6546d205556a4b upstream.

Since ext4 supports large folios, processing writebacks in pages is no
longer appropriate, it can be modified to process writebacks in bytes.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/20250707140814.542883-2-yi.zhang@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/inode.c             |   70 ++++++++++++++++++++++----------------------
 include/trace/events/ext4.h |   13 +++-----
 2 files changed, 42 insertions(+), 41 deletions(-)

--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1668,11 +1668,12 @@ struct mpage_da_data {
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
@@ -1692,38 +1693,38 @@ static void mpage_release_unused_pages(s
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
@@ -2025,7 +2026,7 @@ int ext4_da_get_block_prep(struct inode
 
 static void mpage_folio_done(struct mpage_da_data *mpd, struct folio *folio)
 {
-	mpd->first_page += folio_nr_pages(folio);
+	mpd->start_pos += folio_size(folio);
 	folio_unlock(folio);
 }
 
@@ -2035,7 +2036,7 @@ static int mpage_submit_folio(struct mpa
 	loff_t size;
 	int err;
 
-	BUG_ON(folio->index != mpd->first_page);
+	WARN_ON_ONCE(folio_pos(folio) != mpd->start_pos);
 	folio_clear_dirty_for_io(folio);
 	/*
 	 * We have to be very careful here!  Nothing protects writeback path
@@ -2447,7 +2448,7 @@ update_disksize:
 	 * Update on-disk size after IO is submitted.  Races with
 	 * truncate are avoided by checking i_size under i_data_sem.
 	 */
-	disksize = ((loff_t)mpd->first_page) << PAGE_SHIFT;
+	disksize = mpd->start_pos;
 	if (disksize > READ_ONCE(EXT4_I(inode)->i_disksize)) {
 		int err2;
 		loff_t i_size;
@@ -2550,8 +2551,8 @@ static int mpage_prepare_extent_to_map(s
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
@@ -2566,7 +2567,7 @@ static int mpage_prepare_extent_to_map(s
 		tag = PAGECACHE_TAG_DIRTY;
 
 	mpd->map.m_len = 0;
-	mpd->next_page = index;
+	mpd->next_pos = mpd->start_pos;
 	if (ext4_should_journal_data(mpd->inode)) {
 		handle = ext4_journal_start(mpd->inode, EXT4_HT_WRITE_PAGE,
 					    bpp);
@@ -2597,7 +2598,8 @@ static int mpage_prepare_extent_to_map(s
 				goto out;
 
 			/* If we can't merge this page, we are done. */
-			if (mpd->map.m_len > 0 && mpd->next_page != folio->index)
+			if (mpd->map.m_len > 0 &&
+			    mpd->next_pos != folio_pos(folio))
 				goto out;
 
 			if (handle) {
@@ -2643,8 +2645,8 @@ static int mpage_prepare_extent_to_map(s
 			}
 
 			if (mpd->map.m_len == 0)
-				mpd->first_page = folio->index;
-			mpd->next_page = folio_next_index(folio);
+				mpd->start_pos = folio_pos(folio);
+			mpd->next_pos = folio_pos(folio) + folio_size(folio);
 			/*
 			 * Writeout when we cannot modify metadata is simple.
 			 * Just submit the page. For data=journal mode we
@@ -2787,18 +2789,18 @@ static int ext4_do_writepages(struct mpa
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
@@ -2858,7 +2860,7 @@ retry:
 		}
 		mpd->do_map = 1;
 
-		trace_ext4_da_write_pages(inode, mpd->first_page, wbc);
+		trace_ext4_da_write_pages(inode, mpd->start_pos, wbc);
 		ret = mpage_prepare_extent_to_map(mpd);
 		if (!ret && mpd->map.m_len)
 			ret = mpage_map_and_submit_extent(handle, mpd,
@@ -2915,8 +2917,8 @@ unplug:
 	blk_finish_plug(&plug);
 	if (!ret && !cycled && wbc->nr_to_write > 0) {
 		cycled = 1;
-		mpd->last_page = writeback_index - 1;
-		mpd->first_page = 0;
+		mpd->end_pos = (writeback_index << PAGE_SHIFT) - 1;
+		mpd->start_pos = 0;
 		goto retry;
 	}
 
@@ -2926,7 +2928,7 @@ unplug:
 		 * Set the writeback_index so that range_cyclic
 		 * mode will write it back later
 		 */
-		mapping->writeback_index = mpd->first_page;
+		mapping->writeback_index = mpd->start_pos >> PAGE_SHIFT;
 
 out_writepages:
 	trace_ext4_writepages_result(inode, wbc, ret,
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -483,15 +483,15 @@ TRACE_EVENT(ext4_writepages,
 );
 
 TRACE_EVENT(ext4_da_write_pages,
-	TP_PROTO(struct inode *inode, pgoff_t first_page,
+	TP_PROTO(struct inode *inode, loff_t start_pos,
 		 struct writeback_control *wbc),
 
-	TP_ARGS(inode, first_page, wbc),
+	TP_ARGS(inode, start_pos, wbc),
 
 	TP_STRUCT__entry(
 		__field(	dev_t,	dev			)
 		__field(	ino_t,	ino			)
-		__field(      pgoff_t,	first_page		)
+		__field(       loff_t,	start_pos		)
 		__field(	 long,	nr_to_write		)
 		__field(	  int,	sync_mode		)
 	),
@@ -499,15 +499,14 @@ TRACE_EVENT(ext4_da_write_pages,
 	TP_fast_assign(
 		__entry->dev		= inode->i_sb->s_dev;
 		__entry->ino		= inode->i_ino;
-		__entry->first_page	= first_page;
+		__entry->start_pos	= start_pos;
 		__entry->nr_to_write	= wbc->nr_to_write;
 		__entry->sync_mode	= wbc->sync_mode;
 	),
 
-	TP_printk("dev %d,%d ino %lu first_page %lu nr_to_write %ld "
-		  "sync_mode %d",
+	TP_printk("dev %d,%d ino %lu start_pos 0x%llx nr_to_write %ld sync_mode %d",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
-		  (unsigned long) __entry->ino, __entry->first_page,
+		  (unsigned long) __entry->ino, __entry->start_pos,
 		  __entry->nr_to_write, __entry->sync_mode)
 );
 



