Return-Path: <stable+bounces-88589-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B749B269F
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 07:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04D9F1F22B7E
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 06:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BB718E350;
	Mon, 28 Oct 2024 06:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ai3o8nzh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307652C697;
	Mon, 28 Oct 2024 06:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730097674; cv=none; b=Bt6nG55D4+EFvN1+LiP9ntgKWCmML3oLCF26TXBQQDaewwVvc9tki2DFPUpSlYAB+ddctAbRaxopSV5vXr2u51veYSs+aHvFzn5OraQzbfuIVNFWcstsnDh1eFrYmPk7ec3lRCTet/C6mz6Lqr0NiCJaTwLfb014fCHBsmVltrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730097674; c=relaxed/simple;
	bh=9zPtAc/IKV9guOPCQPiXMM7vrL+suxSkpEFGmKTam/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eX+BElslRUQE2c20CDyju8DQ+DmCXhxBqsUiCMktiTdTJ01oEifXFBNjkRMnsSkIi3YbmRqoWzAMisapvRY56WtPBn1NgtwpnLUOoBYdiUXuhvSrwSbIUYe+UpX97tySlxiyj+8aO5RNXegXCFa3t1PDwKCOm/3DbJeeiG8xh6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ai3o8nzh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73003C4CEC3;
	Mon, 28 Oct 2024 06:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730097673;
	bh=9zPtAc/IKV9guOPCQPiXMM7vrL+suxSkpEFGmKTam/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ai3o8nzhYvwYMXGyLWIe203UA8PAw8bUWUlxkGfw6Ijq2ZrYL9JVuA3PVqtMGCzj0
	 TTl4MWGEuGmHi1nhHTtix0pfiMAJus7M9pai2EbdeCm2+RiphsUveVhBZV0Y+YfzkQ
	 vrwQjaI3wp3t18LTPUmsRUQhFf24KF1RWK52xFB4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 096/208] khugepaged: remove hpage from collapse_file()
Date: Mon, 28 Oct 2024 07:24:36 +0100
Message-ID: <20241028062309.022865013@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028062306.649733554@linuxfoundation.org>
References: <20241028062306.649733554@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthew Wilcox (Oracle) <willy@infradead.org>

[ Upstream commit 610ff817b981921213ae51e5c5f38c76c6f0405e ]

Use new_folio throughout where we had been using hpage.

Link: https://lkml.kernel.org/r/20240403171838.1445826-6-willy@infradead.org
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 37f0b47c5143 ("mm: khugepaged: fix the arguments order in khugepaged_collapse_file trace point")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/trace/events/huge_memory.h |  6 +--
 mm/khugepaged.c                    | 77 +++++++++++++++---------------
 2 files changed, 42 insertions(+), 41 deletions(-)

diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
index 6e2ef1d4b0028..dc6eeef2d3dac 100644
--- a/include/trace/events/huge_memory.h
+++ b/include/trace/events/huge_memory.h
@@ -207,10 +207,10 @@ TRACE_EVENT(mm_khugepaged_scan_file,
 );
 
 TRACE_EVENT(mm_khugepaged_collapse_file,
-	TP_PROTO(struct mm_struct *mm, struct page *hpage, pgoff_t index,
+	TP_PROTO(struct mm_struct *mm, struct folio *new_folio, pgoff_t index,
 			bool is_shmem, unsigned long addr, struct file *file,
 			int nr, int result),
-	TP_ARGS(mm, hpage, index, addr, is_shmem, file, nr, result),
+	TP_ARGS(mm, new_folio, index, addr, is_shmem, file, nr, result),
 	TP_STRUCT__entry(
 		__field(struct mm_struct *, mm)
 		__field(unsigned long, hpfn)
@@ -224,7 +224,7 @@ TRACE_EVENT(mm_khugepaged_collapse_file,
 
 	TP_fast_assign(
 		__entry->mm = mm;
-		__entry->hpfn = hpage ? page_to_pfn(hpage) : -1;
+		__entry->hpfn = new_folio ? folio_pfn(new_folio) : -1;
 		__entry->index = index;
 		__entry->addr = addr;
 		__entry->is_shmem = is_shmem;
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index b197323450b5a..4b00592548f59 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1783,30 +1783,27 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 			 struct collapse_control *cc)
 {
 	struct address_space *mapping = file->f_mapping;
-	struct page *hpage;
 	struct page *page;
-	struct page *tmp;
+	struct page *tmp, *dst;
 	struct folio *folio, *new_folio;
 	pgoff_t index = 0, end = start + HPAGE_PMD_NR;
 	LIST_HEAD(pagelist);
 	XA_STATE_ORDER(xas, &mapping->i_pages, start, HPAGE_PMD_ORDER);
 	int nr_none = 0, result = SCAN_SUCCEED;
 	bool is_shmem = shmem_file(file);
-	int nr = 0;
 
 	VM_BUG_ON(!IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) && !is_shmem);
 	VM_BUG_ON(start & (HPAGE_PMD_NR - 1));
 
 	result = alloc_charge_folio(&new_folio, mm, cc);
-	hpage = &new_folio->page;
 	if (result != SCAN_SUCCEED)
 		goto out;
 
-	__SetPageLocked(hpage);
+	__folio_set_locked(new_folio);
 	if (is_shmem)
-		__SetPageSwapBacked(hpage);
-	hpage->index = start;
-	hpage->mapping = mapping;
+		__folio_set_swapbacked(new_folio);
+	new_folio->index = start;
+	new_folio->mapping = mapping;
 
 	/*
 	 * Ensure we have slots for all the pages in the range.  This is
@@ -2039,20 +2036,24 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 	 * The old pages are locked, so they won't change anymore.
 	 */
 	index = start;
+	dst = folio_page(new_folio, 0);
 	list_for_each_entry(page, &pagelist, lru) {
 		while (index < page->index) {
-			clear_highpage(hpage + (index % HPAGE_PMD_NR));
+			clear_highpage(dst);
 			index++;
+			dst++;
 		}
-		if (copy_mc_highpage(hpage + (page->index % HPAGE_PMD_NR), page) > 0) {
+		if (copy_mc_highpage(dst, page) > 0) {
 			result = SCAN_COPY_MC;
 			goto rollback;
 		}
 		index++;
+		dst++;
 	}
 	while (index < end) {
-		clear_highpage(hpage + (index % HPAGE_PMD_NR));
+		clear_highpage(dst);
 		index++;
+		dst++;
 	}
 
 	if (nr_none) {
@@ -2080,16 +2081,17 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 		}
 
 		/*
-		 * If userspace observed a missing page in a VMA with a MODE_MISSING
-		 * userfaultfd, then it might expect a UFFD_EVENT_PAGEFAULT for that
-		 * page. If so, we need to roll back to avoid suppressing such an
-		 * event. Since wp/minor userfaultfds don't give userspace any
-		 * guarantees that the kernel doesn't fill a missing page with a zero
-		 * page, so they don't matter here.
+		 * If userspace observed a missing page in a VMA with
+		 * a MODE_MISSING userfaultfd, then it might expect a
+		 * UFFD_EVENT_PAGEFAULT for that page. If so, we need to
+		 * roll back to avoid suppressing such an event. Since
+		 * wp/minor userfaultfds don't give userspace any
+		 * guarantees that the kernel doesn't fill a missing
+		 * page with a zero page, so they don't matter here.
 		 *
-		 * Any userfaultfds registered after this point will not be able to
-		 * observe any missing pages due to the previously inserted retry
-		 * entries.
+		 * Any userfaultfds registered after this point will
+		 * not be able to observe any missing pages due to the
+		 * previously inserted retry entries.
 		 */
 		vma_interval_tree_foreach(vma, &mapping->i_mmap, start, end) {
 			if (userfaultfd_missing(vma)) {
@@ -2114,33 +2116,32 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 		xas_lock_irq(&xas);
 	}
 
-	folio = page_folio(hpage);
-	nr = folio_nr_pages(folio);
 	if (is_shmem)
-		__lruvec_stat_mod_folio(folio, NR_SHMEM_THPS, nr);
+		__lruvec_stat_mod_folio(new_folio, NR_SHMEM_THPS, HPAGE_PMD_NR);
 	else
-		__lruvec_stat_mod_folio(folio, NR_FILE_THPS, nr);
+		__lruvec_stat_mod_folio(new_folio, NR_FILE_THPS, HPAGE_PMD_NR);
 
 	if (nr_none) {
-		__lruvec_stat_mod_folio(folio, NR_FILE_PAGES, nr_none);
+		__lruvec_stat_mod_folio(new_folio, NR_FILE_PAGES, nr_none);
 		/* nr_none is always 0 for non-shmem. */
-		__lruvec_stat_mod_folio(folio, NR_SHMEM, nr_none);
+		__lruvec_stat_mod_folio(new_folio, NR_SHMEM, nr_none);
 	}
 
 	/*
-	 * Mark hpage as uptodate before inserting it into the page cache so
-	 * that it isn't mistaken for an fallocated but unwritten page.
+	 * Mark new_folio as uptodate before inserting it into the
+	 * page cache so that it isn't mistaken for an fallocated but
+	 * unwritten page.
 	 */
-	folio_mark_uptodate(folio);
-	folio_ref_add(folio, HPAGE_PMD_NR - 1);
+	folio_mark_uptodate(new_folio);
+	folio_ref_add(new_folio, HPAGE_PMD_NR - 1);
 
 	if (is_shmem)
-		folio_mark_dirty(folio);
-	folio_add_lru(folio);
+		folio_mark_dirty(new_folio);
+	folio_add_lru(new_folio);
 
 	/* Join all the small entries into a single multi-index entry. */
 	xas_set_order(&xas, start, HPAGE_PMD_ORDER);
-	xas_store(&xas, folio);
+	xas_store(&xas, new_folio);
 	WARN_ON_ONCE(xas_error(&xas));
 	xas_unlock_irq(&xas);
 
@@ -2151,7 +2152,7 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 	retract_page_tables(mapping, start);
 	if (cc && !cc->is_khugepaged)
 		result = SCAN_PTE_MAPPED_HUGEPAGE;
-	folio_unlock(folio);
+	folio_unlock(new_folio);
 
 	/*
 	 * The collapse has succeeded, so free the old pages.
@@ -2196,13 +2197,13 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 		smp_mb();
 	}
 
-	hpage->mapping = NULL;
+	new_folio->mapping = NULL;
 
-	unlock_page(hpage);
-	put_page(hpage);
+	folio_unlock(new_folio);
+	folio_put(new_folio);
 out:
 	VM_BUG_ON(!list_empty(&pagelist));
-	trace_mm_khugepaged_collapse_file(mm, hpage, index, is_shmem, addr, file, nr, result);
+	trace_mm_khugepaged_collapse_file(mm, new_folio, index, is_shmem, addr, file, HPAGE_PMD_NR, result);
 	return result;
 }
 
-- 
2.43.0




