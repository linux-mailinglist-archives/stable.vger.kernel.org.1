Return-Path: <stable+bounces-45791-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA43C8CD3E5
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 15:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FC862830A3
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 13:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4024113B7AE;
	Thu, 23 May 2024 13:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VllvtaBk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF31A14A60D;
	Thu, 23 May 2024 13:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716470372; cv=none; b=d0INpkbkukF493A8QS1j5Wi7pg+Z6cyh69HQF0Llx9mE7bpvaEApdBkNljb1jsThHLNOup8QMKW1nHrxY49x9VZx2o5yS+bJpBFXpt/3U+tJMxXmfySSPLEo0lkwT15s41kVRtGr3cVN0wBlZU9moasd8liJ/5V6uaV1IQgKD6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716470372; c=relaxed/simple;
	bh=j1r0G+kT7O4nnWM2DLVvONV4lnfG4nYKYgLubgnEu3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kmQ9GDuKKS/0ZTkaeBPpcha4v0VPyht8/ltyNeFZPQzjuoRl7UT7rmNiuiVjJw4rg4f3Kq+4Y2WJvvy7AphckkZvr4dqKbkpTDIDFkqyFt1gndUy+F3FJC4vSO8rBjb+uGD002uePGdWb7TiwAdCnzodFA02abRzG2yKwHg2Iok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VllvtaBk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D14AC2BD10;
	Thu, 23 May 2024 13:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716470371;
	bh=j1r0G+kT7O4nnWM2DLVvONV4lnfG4nYKYgLubgnEu3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VllvtaBk+CFqjClGZVXQ+mkLK38x+Dc3PDfOSTwiNbUbyX1rkV7HKl+pqQA/Cm5U2
	 WPcEBrEFrsHPvS08Mp+k6HUA9Kz9ozEFG9seV+vMulICfM0U32yRVzWBZreQFQXQi2
	 1F91dfWbfqegFVnAsOWmA9JqeIf/uFh777a9tofo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dave Chinner <dchinner@redhat.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 14/45] iomap: buffered write failure should not truncate the page cache
Date: Thu, 23 May 2024 15:13:05 +0200
Message-ID: <20240523130333.031511077@linuxfoundation.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523130332.496202557@linuxfoundation.org>
References: <20240523130332.496202557@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dave Chinner <dchinner@redhat.com>

[ Upstream commit f43dc4dc3eff028b5ddddd99f3a66c5a6bdd4e78 ]

iomap_file_buffered_write_punch_delalloc() currently invalidates the
page cache over the unused range of the delalloc extent that was
allocated. While the write allocated the delalloc extent, it does
not own it exclusively as the write does not hold any locks that
prevent either writeback or mmap page faults from changing the state
of either the page cache or the extent state backing this range.

Whilst xfs_bmap_punch_delalloc_range() already handles races in
extent conversion - it will only punch out delalloc extents and it
ignores any other type of extent - the page cache truncate does not
discriminate between data written by this write or some other task.
As a result, truncating the page cache can result in data corruption
if the write races with mmap modifications to the file over the same
range.

generic/346 exercises this workload, and if we randomly fail writes
(as will happen when iomap gets stale iomap detection later in the
patchset), it will randomly corrupt the file data because it removes
data written by mmap() in the same page as the write() that failed.

Hence we do not want to punch out the page cache over the range of
the extent we failed to write to - what we actually need to do is
detect the ranges that have dirty data in cache over them and *not
punch them out*.

To do this, we have to walk the page cache over the range of the
delalloc extent we want to remove. This is made complex by the fact
we have to handle partially up-to-date folios correctly and this can
happen even when the FSB size == PAGE_SIZE because we now support
multi-page folios in the page cache.

Because we are only interested in discovering the edges of data
ranges in the page cache (i.e. hole-data boundaries) we can make use
of mapping_seek_hole_data() to find those transitions in the page
cache. As we hold the invalidate_lock, we know that the boundaries
are not going to change while we walk the range. This interface is
also byte-based and is sub-page block aware, so we can find the data
ranges in the cache based on byte offsets rather than page, folio or
fs block sized chunks. This greatly simplifies the logic of finding
dirty cached ranges in the page cache.

Once we've identified a range that contains cached data, we can then
iterate the range folio by folio. This allows us to determine if the
data is dirty and hence perform the correct delalloc extent punching
operations. The seek interface we use to iterate data ranges will
give us sub-folio start/end granularity, so we may end up looking up
the same folio multiple times as the seek interface iterates across
each discontiguous data region in the folio.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/iomap/buffered-io.c |  195 +++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 180 insertions(+), 15 deletions(-)

--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -828,6 +828,165 @@ iomap_file_buffered_write(struct kiocb *
 EXPORT_SYMBOL_GPL(iomap_file_buffered_write);
 
 /*
+ * Scan the data range passed to us for dirty page cache folios. If we find a
+ * dirty folio, punch out the preceeding range and update the offset from which
+ * the next punch will start from.
+ *
+ * We can punch out storage reservations under clean pages because they either
+ * contain data that has been written back - in which case the delalloc punch
+ * over that range is a no-op - or they have been read faults in which case they
+ * contain zeroes and we can remove the delalloc backing range and any new
+ * writes to those pages will do the normal hole filling operation...
+ *
+ * This makes the logic simple: we only need to keep the delalloc extents only
+ * over the dirty ranges of the page cache.
+ *
+ * This function uses [start_byte, end_byte) intervals (i.e. open ended) to
+ * simplify range iterations.
+ */
+static int iomap_write_delalloc_scan(struct inode *inode,
+		loff_t *punch_start_byte, loff_t start_byte, loff_t end_byte,
+		int (*punch)(struct inode *inode, loff_t offset, loff_t length))
+{
+	while (start_byte < end_byte) {
+		struct folio	*folio;
+
+		/* grab locked page */
+		folio = filemap_lock_folio(inode->i_mapping,
+				start_byte >> PAGE_SHIFT);
+		if (!folio) {
+			start_byte = ALIGN_DOWN(start_byte, PAGE_SIZE) +
+					PAGE_SIZE;
+			continue;
+		}
+
+		/* if dirty, punch up to offset */
+		if (folio_test_dirty(folio)) {
+			if (start_byte > *punch_start_byte) {
+				int	error;
+
+				error = punch(inode, *punch_start_byte,
+						start_byte - *punch_start_byte);
+				if (error) {
+					folio_unlock(folio);
+					folio_put(folio);
+					return error;
+				}
+			}
+
+			/*
+			 * Make sure the next punch start is correctly bound to
+			 * the end of this data range, not the end of the folio.
+			 */
+			*punch_start_byte = min_t(loff_t, end_byte,
+					folio_next_index(folio) << PAGE_SHIFT);
+		}
+
+		/* move offset to start of next folio in range */
+		start_byte = folio_next_index(folio) << PAGE_SHIFT;
+		folio_unlock(folio);
+		folio_put(folio);
+	}
+	return 0;
+}
+
+/*
+ * Punch out all the delalloc blocks in the range given except for those that
+ * have dirty data still pending in the page cache - those are going to be
+ * written and so must still retain the delalloc backing for writeback.
+ *
+ * As we are scanning the page cache for data, we don't need to reimplement the
+ * wheel - mapping_seek_hole_data() does exactly what we need to identify the
+ * start and end of data ranges correctly even for sub-folio block sizes. This
+ * byte range based iteration is especially convenient because it means we
+ * don't have to care about variable size folios, nor where the start or end of
+ * the data range lies within a folio, if they lie within the same folio or even
+ * if there are multiple discontiguous data ranges within the folio.
+ *
+ * It should be noted that mapping_seek_hole_data() is not aware of EOF, and so
+ * can return data ranges that exist in the cache beyond EOF. e.g. a page fault
+ * spanning EOF will initialise the post-EOF data to zeroes and mark it up to
+ * date. A write page fault can then mark it dirty. If we then fail a write()
+ * beyond EOF into that up to date cached range, we allocate a delalloc block
+ * beyond EOF and then have to punch it out. Because the range is up to date,
+ * mapping_seek_hole_data() will return it, and we will skip the punch because
+ * the folio is dirty. THis is incorrect - we always need to punch out delalloc
+ * beyond EOF in this case as writeback will never write back and covert that
+ * delalloc block beyond EOF. Hence we limit the cached data scan range to EOF,
+ * resulting in always punching out the range from the EOF to the end of the
+ * range the iomap spans.
+ *
+ * Intervals are of the form [start_byte, end_byte) (i.e. open ended) because it
+ * matches the intervals returned by mapping_seek_hole_data(). i.e. SEEK_DATA
+ * returns the start of a data range (start_byte), and SEEK_HOLE(start_byte)
+ * returns the end of the data range (data_end). Using closed intervals would
+ * require sprinkling this code with magic "+ 1" and "- 1" arithmetic and expose
+ * the code to subtle off-by-one bugs....
+ */
+static int iomap_write_delalloc_release(struct inode *inode,
+		loff_t start_byte, loff_t end_byte,
+		int (*punch)(struct inode *inode, loff_t pos, loff_t length))
+{
+	loff_t punch_start_byte = start_byte;
+	loff_t scan_end_byte = min(i_size_read(inode), end_byte);
+	int error = 0;
+
+	/*
+	 * Lock the mapping to avoid races with page faults re-instantiating
+	 * folios and dirtying them via ->page_mkwrite whilst we walk the
+	 * cache and perform delalloc extent removal. Failing to do this can
+	 * leave dirty pages with no space reservation in the cache.
+	 */
+	filemap_invalidate_lock(inode->i_mapping);
+	while (start_byte < scan_end_byte) {
+		loff_t		data_end;
+
+		start_byte = mapping_seek_hole_data(inode->i_mapping,
+				start_byte, scan_end_byte, SEEK_DATA);
+		/*
+		 * If there is no more data to scan, all that is left is to
+		 * punch out the remaining range.
+		 */
+		if (start_byte == -ENXIO || start_byte == scan_end_byte)
+			break;
+		if (start_byte < 0) {
+			error = start_byte;
+			goto out_unlock;
+		}
+		WARN_ON_ONCE(start_byte < punch_start_byte);
+		WARN_ON_ONCE(start_byte > scan_end_byte);
+
+		/*
+		 * We find the end of this contiguous cached data range by
+		 * seeking from start_byte to the beginning of the next hole.
+		 */
+		data_end = mapping_seek_hole_data(inode->i_mapping, start_byte,
+				scan_end_byte, SEEK_HOLE);
+		if (data_end < 0) {
+			error = data_end;
+			goto out_unlock;
+		}
+		WARN_ON_ONCE(data_end <= start_byte);
+		WARN_ON_ONCE(data_end > scan_end_byte);
+
+		error = iomap_write_delalloc_scan(inode, &punch_start_byte,
+				start_byte, data_end, punch);
+		if (error)
+			goto out_unlock;
+
+		/* The next data search starts at the end of this one. */
+		start_byte = data_end;
+	}
+
+	if (punch_start_byte < end_byte)
+		error = punch(inode, punch_start_byte,
+				end_byte - punch_start_byte);
+out_unlock:
+	filemap_invalidate_unlock(inode->i_mapping);
+	return error;
+}
+
+/*
  * When a short write occurs, the filesystem may need to remove reserved space
  * that was allocated in ->iomap_begin from it's ->iomap_end method. For
  * filesystems that use delayed allocation, we need to punch out delalloc
@@ -837,8 +996,25 @@ EXPORT_SYMBOL_GPL(iomap_file_buffered_wr
  * allocated for this iomap.
  *
  * This function uses [start_byte, end_byte) intervals (i.e. open ended) to
- * simplify range iterations, but converts them back to {offset,len} tuples for
- * the punch callback.
+ * simplify range iterations.
+ *
+ * The punch() callback *must* only punch delalloc extents in the range passed
+ * to it. It must skip over all other types of extents in the range and leave
+ * them completely unchanged. It must do this punch atomically with respect to
+ * other extent modifications.
+ *
+ * The punch() callback may be called with a folio locked to prevent writeback
+ * extent allocation racing at the edge of the range we are currently punching.
+ * The locked folio may or may not cover the range being punched, so it is not
+ * safe for the punch() callback to lock folios itself.
+ *
+ * Lock order is:
+ *
+ * inode->i_rwsem (shared or exclusive)
+ *   inode->i_mapping->invalidate_lock (exclusive)
+ *     folio_lock()
+ *       ->punch
+ *         internal filesystem allocation lock
  */
 int iomap_file_buffered_write_punch_delalloc(struct inode *inode,
 		struct iomap *iomap, loff_t pos, loff_t length,
@@ -848,7 +1024,6 @@ int iomap_file_buffered_write_punch_dela
 	loff_t			start_byte;
 	loff_t			end_byte;
 	int			blocksize = i_blocksize(inode);
-	int			error = 0;
 
 	if (iomap->type != IOMAP_DELALLOC)
 		return 0;
@@ -872,18 +1047,8 @@ int iomap_file_buffered_write_punch_dela
 	if (start_byte >= end_byte)
 		return 0;
 
-	/*
-	 * Lock the mapping to avoid races with page faults re-instantiating
-	 * folios and dirtying them via ->page_mkwrite between the page cache
-	 * truncation and the delalloc extent removal. Failing to do this can
-	 * leave dirty pages with no space reservation in the cache.
-	 */
-	filemap_invalidate_lock(inode->i_mapping);
-	truncate_pagecache_range(inode, start_byte, end_byte - 1);
-	error = punch(inode, start_byte, end_byte - start_byte);
-	filemap_invalidate_unlock(inode->i_mapping);
-
-	return error;
+	return iomap_write_delalloc_release(inode, start_byte, end_byte,
+					punch);
 }
 EXPORT_SYMBOL_GPL(iomap_file_buffered_write_punch_delalloc);
 



