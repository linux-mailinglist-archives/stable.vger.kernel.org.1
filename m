Return-Path: <stable+bounces-10267-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B33FB827417
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 16:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 294A81F22CCB
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 15:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C663253E11;
	Mon,  8 Jan 2024 15:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EqVgpxTw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F50C53E10;
	Mon,  8 Jan 2024 15:41:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE66CC433C9;
	Mon,  8 Jan 2024 15:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704728514;
	bh=ILvNLhcywUs1OJOzYcpcS4F1+jvaAMz3fuCx+tOCAx0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EqVgpxTwAc7vFULHWU8BoYkU9mXVH66mMxweQxdGmUzrrj1e8LcAPhKtzO4PuwZ9U
	 1W4yKK7LHAat0yDyaAx+zGNCr/oBFnDHNzX602SE61gy1plmR8HNcNucAyj07kZ+5A
	 Qc4aivJF4+P8QV5++etNgqWlu/HYL+RF7NCR4I/E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Rohith Surabattula <rohiths.msft@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	David Howells <dhowells@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Steve French <sfrench@samba.org>,
	Shyam Prasad N <nspmangalore@gmail.com>,
	Dave Wysochanski <dwysocha@redhat.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	"Theodore Tso" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Xiubo Li <xiubli@redhat.com>,
	Jingbo Xu <jefflexu@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 101/150] mm: merge folio_has_private()/filemap_release_folio() call pairs
Date: Mon,  8 Jan 2024 16:35:52 +0100
Message-ID: <20240108153515.856925497@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108153511.214254205@linuxfoundation.org>
References: <20240108153511.214254205@linuxfoundation.org>
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

From: David Howells <dhowells@redhat.com>

[ Upstream commit 0201ebf274a306a6ebb95e5dc2d6a0a27c737cac ]

Patch series "mm, netfs, fscache: Stop read optimisation when folio
removed from pagecache", v7.

This fixes an optimisation in fscache whereby we don't read from the cache
for a particular file until we know that there's data there that we don't
have in the pagecache.  The problem is that I'm no longer using PG_fscache
(aka PG_private_2) to indicate that the page is cached and so I don't get
a notification when a cached page is dropped from the pagecache.

The first patch merges some folio_has_private() and
filemap_release_folio() pairs and introduces a helper,
folio_needs_release(), to indicate if a release is required.

The second patch is the actual fix.  Following Willy's suggestions[1], it
adds an AS_RELEASE_ALWAYS flag to an address_space that will make
filemap_release_folio() always call ->release_folio(), even if
PG_private/PG_private_2 aren't set.  folio_needs_release() is altered to
add a check for this.

This patch (of 2):

Make filemap_release_folio() check folio_has_private().  Then, in most
cases, where a call to folio_has_private() is immediately followed by a
call to filemap_release_folio(), we can get rid of the test in the pair.

There are a couple of sites in mm/vscan.c that this can't so easily be
done.  In shrink_folio_list(), there are actually three cases (something
different is done for incompletely invalidated buffers), but
filemap_release_folio() elides two of them.

In shrink_active_list(), we don't have have the folio lock yet, so the
check allows us to avoid locking the page unnecessarily.

A wrapper function to check if a folio needs release is provided for those
places that still need to do it in the mm/ directory.  This will acquire
additional parts to the condition in a future patch.

After this, the only remaining caller of folio_has_private() outside of
mm/ is a check in fuse.

Link: https://lkml.kernel.org/r/20230628104852.3391651-1-dhowells@redhat.com
Link: https://lkml.kernel.org/r/20230628104852.3391651-2-dhowells@redhat.com
Reported-by: Rohith Surabattula <rohiths.msft@gmail.com>
Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Steve French <sfrench@samba.org>
Cc: Shyam Prasad N <nspmangalore@gmail.com>
Cc: Rohith Surabattula <rohiths.msft@gmail.com>
Cc: Dave Wysochanski <dwysocha@redhat.com>
Cc: Dominique Martinet <asmadeus@codewreck.org>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>
Cc: Xiubo Li <xiubli@redhat.com>
Cc: Jingbo Xu <jefflexu@linux.alibaba.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 1898efcdbed3 ("block: update the stable_writes flag in bdev_add")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/move_extent.c | 12 ++++--------
 fs/splice.c           |  3 +--
 mm/filemap.c          |  2 ++
 mm/huge_memory.c      |  3 +--
 mm/internal.h         |  8 ++++++++
 mm/khugepaged.c       |  3 +--
 mm/memory-failure.c   |  8 +++-----
 mm/migrate.c          |  3 +--
 mm/truncate.c         |  6 ++----
 mm/vmscan.c           |  8 ++++----
 10 files changed, 27 insertions(+), 29 deletions(-)

diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index 8dbb87edf24c4..dedc9d445f243 100644
--- a/fs/ext4/move_extent.c
+++ b/fs/ext4/move_extent.c
@@ -339,10 +339,8 @@ move_extent_per_page(struct file *o_filp, struct inode *donor_inode,
 			ext4_double_up_write_data_sem(orig_inode, donor_inode);
 			goto data_copy;
 		}
-		if ((folio_has_private(folio[0]) &&
-		     !filemap_release_folio(folio[0], 0)) ||
-		    (folio_has_private(folio[1]) &&
-		     !filemap_release_folio(folio[1], 0))) {
+		if (!filemap_release_folio(folio[0], 0) ||
+		    !filemap_release_folio(folio[1], 0)) {
 			*err = -EBUSY;
 			goto drop_data_sem;
 		}
@@ -361,10 +359,8 @@ move_extent_per_page(struct file *o_filp, struct inode *donor_inode,
 
 	/* At this point all buffers in range are uptodate, old mapping layout
 	 * is no longer required, try to drop it now. */
-	if ((folio_has_private(folio[0]) &&
-		!filemap_release_folio(folio[0], 0)) ||
-	    (folio_has_private(folio[1]) &&
-		!filemap_release_folio(folio[1], 0))) {
+	if (!filemap_release_folio(folio[0], 0) ||
+	    !filemap_release_folio(folio[1], 0)) {
 		*err = -EBUSY;
 		goto unlock_folios;
 	}
diff --git a/fs/splice.c b/fs/splice.c
index c4ae54deac42c..d0230cf8ec571 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -65,8 +65,7 @@ static bool page_cache_pipe_buf_try_steal(struct pipe_inode_info *pipe,
 		 */
 		folio_wait_writeback(folio);
 
-		if (folio_has_private(folio) &&
-		    !filemap_release_folio(folio, GFP_KERNEL))
+		if (!filemap_release_folio(folio, GFP_KERNEL))
 			goto out_unlock;
 
 		/*
diff --git a/mm/filemap.c b/mm/filemap.c
index 10fe6430693bd..2809b1174f04e 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -4005,6 +4005,8 @@ bool filemap_release_folio(struct folio *folio, gfp_t gfp)
 	struct address_space * const mapping = folio->mapping;
 
 	BUG_ON(!folio_test_locked(folio));
+	if (!folio_needs_release(folio))
+		return true;
 	if (folio_test_writeback(folio))
 		return false;
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2753fb54cdf38..59577946735b1 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2694,8 +2694,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 		gfp = current_gfp_context(mapping_gfp_mask(mapping) &
 							GFP_RECLAIM_MASK);
 
-		if (folio_test_private(folio) &&
-				!filemap_release_folio(folio, gfp)) {
+		if (!filemap_release_folio(folio, gfp)) {
 			ret = -EBUSY;
 			goto out;
 		}
diff --git a/mm/internal.h b/mm/internal.h
index 6b7ef495b56d3..1fefb5181ab78 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -163,6 +163,14 @@ static inline void set_page_refcounted(struct page *page)
 	set_page_count(page, 1);
 }
 
+/*
+ * Return true if a folio needs ->release_folio() calling upon it.
+ */
+static inline bool folio_needs_release(struct folio *folio)
+{
+	return folio_has_private(folio);
+}
+
 extern unsigned long highest_memmap_pfn;
 
 /*
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 6fc7db587c453..65bd0b105266a 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1955,8 +1955,7 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 			goto out_unlock;
 		}
 
-		if (folio_has_private(folio) &&
-		    !filemap_release_folio(folio, GFP_KERNEL)) {
+		if (!filemap_release_folio(folio, GFP_KERNEL)) {
 			result = SCAN_PAGE_HAS_PRIVATE;
 			folio_putback_lru(folio);
 			goto out_unlock;
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 6355166a6bb28..5b846ed5dcbe9 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -830,14 +830,12 @@ static int truncate_error_page(struct page *p, unsigned long pfn,
 		struct folio *folio = page_folio(p);
 		int err = mapping->a_ops->error_remove_page(mapping, p);
 
-		if (err != 0) {
+		if (err != 0)
 			pr_info("%#lx: Failed to punch page: %d\n", pfn, err);
-		} else if (folio_has_private(folio) &&
-			   !filemap_release_folio(folio, GFP_NOIO)) {
+		else if (!filemap_release_folio(folio, GFP_NOIO))
 			pr_info("%#lx: failed to release buffers\n", pfn);
-		} else {
+		else
 			ret = MF_RECOVERED;
-		}
 	} else {
 		/*
 		 * If the file system doesn't support it just invalidate
diff --git a/mm/migrate.c b/mm/migrate.c
index 91bd69c61148e..c93dd6a31c31a 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -914,8 +914,7 @@ static int fallback_migrate_folio(struct address_space *mapping,
 	 * Buffers may be managed in a filesystem specific way.
 	 * We must have no buffers or drop them.
 	 */
-	if (folio_test_private(src) &&
-	    !filemap_release_folio(src, GFP_KERNEL))
+	if (!filemap_release_folio(src, GFP_KERNEL))
 		return mode == MIGRATE_SYNC ? -EAGAIN : -EBUSY;
 
 	return migrate_folio(mapping, dst, src, mode);
diff --git a/mm/truncate.c b/mm/truncate.c
index c0be77e5c0083..0d4dd233f5187 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -19,7 +19,6 @@
 #include <linux/highmem.h>
 #include <linux/pagevec.h>
 #include <linux/task_io_accounting_ops.h>
-#include <linux/buffer_head.h>	/* grr. try_to_release_page */
 #include <linux/shmem_fs.h>
 #include <linux/rmap.h>
 #include "internal.h"
@@ -276,7 +275,7 @@ static long mapping_evict_folio(struct address_space *mapping,
 	if (folio_ref_count(folio) >
 			folio_nr_pages(folio) + folio_has_private(folio) + 1)
 		return 0;
-	if (folio_has_private(folio) && !filemap_release_folio(folio, 0))
+	if (!filemap_release_folio(folio, 0))
 		return 0;
 
 	return remove_mapping(mapping, folio);
@@ -581,8 +580,7 @@ static int invalidate_complete_folio2(struct address_space *mapping,
 	if (folio->mapping != mapping)
 		return 0;
 
-	if (folio_has_private(folio) &&
-	    !filemap_release_folio(folio, GFP_KERNEL))
+	if (!filemap_release_folio(folio, GFP_KERNEL))
 		return 0;
 
 	spin_lock(&mapping->host->i_lock);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 3f090faa6377f..9f3cfb7caa48d 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1992,7 +1992,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 		 * (refcount == 1) it can be freed.  Otherwise, leave
 		 * the folio on the LRU so it is swappable.
 		 */
-		if (folio_has_private(folio)) {
+		if (folio_needs_release(folio)) {
 			if (!filemap_release_folio(folio, sc->gfp_mask))
 				goto activate_locked;
 			if (!mapping && folio_ref_count(folio) == 1) {
@@ -2618,9 +2618,9 @@ static void shrink_active_list(unsigned long nr_to_scan,
 		}
 
 		if (unlikely(buffer_heads_over_limit)) {
-			if (folio_test_private(folio) && folio_trylock(folio)) {
-				if (folio_test_private(folio))
-					filemap_release_folio(folio, 0);
+			if (folio_needs_release(folio) &&
+			    folio_trylock(folio)) {
+				filemap_release_folio(folio, 0);
 				folio_unlock(folio);
 			}
 		}
-- 
2.43.0




