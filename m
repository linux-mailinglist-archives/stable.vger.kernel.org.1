Return-Path: <stable+bounces-108820-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FD0A12078
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 11:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B6E8188C376
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 10:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91DBD23F278;
	Wed, 15 Jan 2025 10:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tc/2uUTp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FCC1E98E7;
	Wed, 15 Jan 2025 10:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736937911; cv=none; b=f6aB/WNAWBLOnR8ME+8Ru3UTg+gFjBAgP61WdmVIfkgBUmyrcGbfUqnn02g7zuEVSJwZ/9Nl5IjX0CwxUC8Syg6riEtC+1gT/HXShgUCP3vrIDLCbBsxYg6eR8w7g2p1OzSmAGAN5k20JaBNOO/LHUge20QVLsprwFQifDVufWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736937911; c=relaxed/simple;
	bh=Na5YFbdDExLffbKgmYKkeM8l0+CMYSO659lGMzqH8x0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rjrnXitXoZnf09o0anXpgFh3yp2VvF7PzqoMPtlqV5gv5cFHjDf3keHgGXeL1/9xvJ987JZwureoLoaXZVKbSnZb+MhTUPGgcEVgYhK0ui/DQYh6rLjUDXU4e5OB13+aK0wq9UsP0JXnVBXvGUmAJdWWPyOHtoi7OjoKL0iX/HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tc/2uUTp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ED0BC4CEE1;
	Wed, 15 Jan 2025 10:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736937911;
	bh=Na5YFbdDExLffbKgmYKkeM8l0+CMYSO659lGMzqH8x0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tc/2uUTpTi2K5MHSze0wAHSuOEmFpOxlkgJPv7lOQanFSHNyXzX0nm9BdgaBk4r1U
	 edXeXWKvzLChkZC/CmMWHU+I0K3CSaD4s33G1hq33Ca+Lh4crd0SaqejUrlZvsoSGz
	 7VnWA0wubd7oLQA7T4+kIIC0NtsTAPIUnjusS9JI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pankaj Raghav <p.raghav@samsung.com>,
	David Sterba <dsterba@suse.com>,
	Tejun Heo <tj@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 003/189] fs/writeback: convert wbc_account_cgroup_owner to take a folio
Date: Wed, 15 Jan 2025 11:34:59 +0100
Message-ID: <20250115103606.496290120@linuxfoundation.org>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250115103606.357764746@linuxfoundation.org>
References: <20250115103606.357764746@linuxfoundation.org>
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

From: Pankaj Raghav <p.raghav@samsung.com>

[ Upstream commit 30dac24e14b52e1787572d1d4e06eeabe8a63630 ]

Most of the callers of wbc_account_cgroup_owner() are converting a folio
to page before calling the function. wbc_account_cgroup_owner() is
converting the page back to a folio to call mem_cgroup_css_from_folio().

Convert wbc_account_cgroup_owner() to take a folio instead of a page,
and convert all callers to pass a folio directly except f2fs.

Convert the page to folio for all the callers from f2fs as they were the
only callers calling wbc_account_cgroup_owner() with a page. As f2fs is
already in the process of converting to folios, these call sites might
also soon be calling wbc_account_cgroup_owner() with a folio directly in
the future.

No functional changes. Only compile tested.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Link: https://lore.kernel.org/r/20240926140121.203821-1-kernel@pankajraghav.com
Acked-by: David Sterba <dsterba@suse.com>
Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Stable-dep-of: 51d20d1dacbe ("iomap: fix zero padding data issue in concurrent append writes")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/admin-guide/cgroup-v2.rst | 2 +-
 fs/btrfs/extent_io.c                    | 7 +++----
 fs/btrfs/inode.c                        | 2 +-
 fs/buffer.c                             | 4 ++--
 fs/ext4/page-io.c                       | 2 +-
 fs/f2fs/data.c                          | 9 ++++++---
 fs/fs-writeback.c                       | 8 +++-----
 fs/iomap/buffered-io.c                  | 2 +-
 fs/mpage.c                              | 2 +-
 include/linux/writeback.h               | 4 ++--
 10 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 6d02168d78be..2cb58daf3089 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2954,7 +2954,7 @@ following two functions.
 	a queue (device) has been associated with the bio and
 	before submission.
 
-  wbc_account_cgroup_owner(@wbc, @page, @bytes)
+  wbc_account_cgroup_owner(@wbc, @folio, @bytes)
 	Should be called for each data segment being written out.
 	While this function doesn't care exactly when it's called
 	during the writeback session, it's the easiest and most
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 872cca54cc6c..42c9899d9241 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -786,7 +786,7 @@ static void submit_extent_folio(struct btrfs_bio_ctrl *bio_ctrl,
 		}
 
 		if (bio_ctrl->wbc)
-			wbc_account_cgroup_owner(bio_ctrl->wbc, &folio->page,
+			wbc_account_cgroup_owner(bio_ctrl->wbc, folio,
 						 len);
 
 		size -= len;
@@ -1708,7 +1708,7 @@ static noinline_for_stack void write_one_eb(struct extent_buffer *eb,
 		ret = bio_add_folio(&bbio->bio, folio, eb->len,
 				    eb->start - folio_pos(folio));
 		ASSERT(ret);
-		wbc_account_cgroup_owner(wbc, folio_page(folio, 0), eb->len);
+		wbc_account_cgroup_owner(wbc, folio, eb->len);
 		folio_unlock(folio);
 	} else {
 		int num_folios = num_extent_folios(eb);
@@ -1722,8 +1722,7 @@ static noinline_for_stack void write_one_eb(struct extent_buffer *eb,
 			folio_start_writeback(folio);
 			ret = bio_add_folio(&bbio->bio, folio, eb->folio_size, 0);
 			ASSERT(ret);
-			wbc_account_cgroup_owner(wbc, folio_page(folio, 0),
-						 eb->folio_size);
+			wbc_account_cgroup_owner(wbc, folio, eb->folio_size);
 			wbc->nr_to_write -= folio_nr_pages(folio);
 			folio_unlock(folio);
 		}
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b5cfb85af937..a3c861b2a6d2 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1729,7 +1729,7 @@ static bool run_delalloc_compressed(struct btrfs_inode *inode,
 			 * need full accuracy.  Just account the whole thing
 			 * against the first page.
 			 */
-			wbc_account_cgroup_owner(wbc, &locked_folio->page,
+			wbc_account_cgroup_owner(wbc, locked_folio,
 						 cur_end - start);
 			async_chunk[i].locked_folio = locked_folio;
 			locked_folio = NULL;
diff --git a/fs/buffer.c b/fs/buffer.c
index 1fc9a50def0b..32bd0f4c4223 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2803,7 +2803,7 @@ static void submit_bh_wbc(blk_opf_t opf, struct buffer_head *bh,
 	bio->bi_iter.bi_sector = bh->b_blocknr * (bh->b_size >> 9);
 	bio->bi_write_hint = write_hint;
 
-	__bio_add_page(bio, bh->b_page, bh->b_size, bh_offset(bh));
+	bio_add_folio_nofail(bio, bh->b_folio, bh->b_size, bh_offset(bh));
 
 	bio->bi_end_io = end_bio_bh_io_sync;
 	bio->bi_private = bh;
@@ -2813,7 +2813,7 @@ static void submit_bh_wbc(blk_opf_t opf, struct buffer_head *bh,
 
 	if (wbc) {
 		wbc_init_bio(wbc, bio);
-		wbc_account_cgroup_owner(wbc, bh->b_page, bh->b_size);
+		wbc_account_cgroup_owner(wbc, bh->b_folio, bh->b_size);
 	}
 
 	submit_bio(bio);
diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index ad5543866d21..b7b9261fec3b 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -421,7 +421,7 @@ static void io_submit_add_bh(struct ext4_io_submit *io,
 		io_submit_init_bio(io, bh);
 	if (!bio_add_folio(io->io_bio, io_folio, bh->b_size, bh_offset(bh)))
 		goto submit_and_retry;
-	wbc_account_cgroup_owner(io->io_wbc, &folio->page, bh->b_size);
+	wbc_account_cgroup_owner(io->io_wbc, folio, bh->b_size);
 	io->io_next_block++;
 }
 
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index da0960d496ae..1b0050b8421d 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -711,7 +711,8 @@ int f2fs_submit_page_bio(struct f2fs_io_info *fio)
 	}
 
 	if (fio->io_wbc && !is_read_io(fio->op))
-		wbc_account_cgroup_owner(fio->io_wbc, fio->page, PAGE_SIZE);
+		wbc_account_cgroup_owner(fio->io_wbc, page_folio(fio->page),
+					 PAGE_SIZE);
 
 	inc_page_count(fio->sbi, is_read_io(fio->op) ?
 			__read_io_type(page) : WB_DATA_TYPE(fio->page, false));
@@ -911,7 +912,8 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
 	}
 
 	if (fio->io_wbc)
-		wbc_account_cgroup_owner(fio->io_wbc, fio->page, PAGE_SIZE);
+		wbc_account_cgroup_owner(fio->io_wbc, page_folio(fio->page),
+					 PAGE_SIZE);
 
 	inc_page_count(fio->sbi, WB_DATA_TYPE(page, false));
 
@@ -1011,7 +1013,8 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 	}
 
 	if (fio->io_wbc)
-		wbc_account_cgroup_owner(fio->io_wbc, fio->page, PAGE_SIZE);
+		wbc_account_cgroup_owner(fio->io_wbc, page_folio(fio->page),
+					 PAGE_SIZE);
 
 	io->last_block_in_bio = fio->new_blkaddr;
 
diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index d8bec3c1bb1f..2391b09f4ced 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -890,17 +890,16 @@ EXPORT_SYMBOL_GPL(wbc_detach_inode);
 /**
  * wbc_account_cgroup_owner - account writeback to update inode cgroup ownership
  * @wbc: writeback_control of the writeback in progress
- * @page: page being written out
+ * @folio: folio being written out
  * @bytes: number of bytes being written out
  *
- * @bytes from @page are about to written out during the writeback
+ * @bytes from @folio are about to written out during the writeback
  * controlled by @wbc.  Keep the book for foreign inode detection.  See
  * wbc_detach_inode().
  */
-void wbc_account_cgroup_owner(struct writeback_control *wbc, struct page *page,
+void wbc_account_cgroup_owner(struct writeback_control *wbc, struct folio *folio,
 			      size_t bytes)
 {
-	struct folio *folio;
 	struct cgroup_subsys_state *css;
 	int id;
 
@@ -913,7 +912,6 @@ void wbc_account_cgroup_owner(struct writeback_control *wbc, struct page *page,
 	if (!wbc->wb || wbc->no_cgroup_owner)
 		return;
 
-	folio = page_folio(page);
 	css = mem_cgroup_css_from_folio(folio);
 	/* dead cgroups shouldn't contribute to inode ownership arbitration */
 	if (!(css->flags & CSS_ONLINE))
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index ef0b68bccbb6..ce73d2a48c1e 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1784,7 +1784,7 @@ static int iomap_add_to_ioend(struct iomap_writepage_ctx *wpc,
 	if (ifs)
 		atomic_add(len, &ifs->write_bytes_pending);
 	wpc->ioend->io_size += len;
-	wbc_account_cgroup_owner(wbc, &folio->page, len);
+	wbc_account_cgroup_owner(wbc, folio, len);
 	return 0;
 }
 
diff --git a/fs/mpage.c b/fs/mpage.c
index b5b5ddf9d513..82aecf372743 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -606,7 +606,7 @@ static int __mpage_writepage(struct folio *folio, struct writeback_control *wbc,
 	 * the confused fail path above (OOM) will be very confused when
 	 * it finds all bh marked clean (i.e. it will not write anything)
 	 */
-	wbc_account_cgroup_owner(wbc, &folio->page, folio_size(folio));
+	wbc_account_cgroup_owner(wbc, folio, folio_size(folio));
 	length = first_unmapped << blkbits;
 	if (!bio_add_folio(bio, folio, length, 0)) {
 		bio = mpage_bio_submit_write(bio);
diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index d6db822e4bb3..641a057e0413 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -217,7 +217,7 @@ void wbc_attach_and_unlock_inode(struct writeback_control *wbc,
 				 struct inode *inode)
 	__releases(&inode->i_lock);
 void wbc_detach_inode(struct writeback_control *wbc);
-void wbc_account_cgroup_owner(struct writeback_control *wbc, struct page *page,
+void wbc_account_cgroup_owner(struct writeback_control *wbc, struct folio *folio,
 			      size_t bytes);
 int cgroup_writeback_by_id(u64 bdi_id, int memcg_id,
 			   enum wb_reason reason, struct wb_completion *done);
@@ -324,7 +324,7 @@ static inline void wbc_init_bio(struct writeback_control *wbc, struct bio *bio)
 }
 
 static inline void wbc_account_cgroup_owner(struct writeback_control *wbc,
-					    struct page *page, size_t bytes)
+					    struct folio *folio, size_t bytes)
 {
 }
 
-- 
2.39.5




