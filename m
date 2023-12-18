Return-Path: <stable+bounces-7242-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 146E8817193
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 14:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AF001C24258
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 13:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E9C129EC8;
	Mon, 18 Dec 2023 13:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DTyqitNw"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230641D12B
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 13:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=1MBkPk64KnUCtWs6hUkkJI8+9eArZ9bghM4uWRzSldU=; b=DTyqitNwZmgyU2BBv/AwwA8oMg
	ZgC3wsQ43DD+kqvXtCR5Mw4En2zuTqcy1KZxYHH4LNVPWStRUiyoo7eBhTwUQ/fn4orOuCjqlrejK
	Y2UBE/yQNkOT8GAgD61LO6c7bPzyIZ9Fxd0uKwJyDK9idTV+qcMyySXDJ7+/0kSvfjmrBfzUd77/P
	wrH1D7+sGBi9HLL/1iJPkXwCg8i7KesTOu9gR22shbfGJKsOiN/VvfQRucDA9vwJ8T72D+KtOEHcG
	V/kFUiHUCjmULvQ+Yl4gPi7nC8MQksB6Og0Pd6jz7v/jJStFJ5Ipk/xU8HFoHHoz2Ejvmv/Ai4cDp
	Vai8syIg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rFE8l-00DtCM-Br; Mon, 18 Dec 2023 13:58:39 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mm@kvack.org,
	Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
	Dan Williams <dan.j.williams@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/3] mm/memory-failure: Pass the folio and the page to collect_procs()
Date: Mon, 18 Dec 2023 13:58:35 +0000
Message-Id: <20231218135837.3310403-2-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231218135837.3310403-1-willy@infradead.org>
References: <20231218135837.3310403-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both collect_procs_anon() and collect_procs_file() iterate over the VMA
interval trees looking for a single pgoff, so it is wrong to look for
the pgoff of the head page as is currently done.  However, it is also
wrong to look at page->mapping of the precise page as this is invalid
for tail pages.  Clear up the confusion by passing both the folio and
the precise page to collect_procs().

Fixes: 415c64c1453a ("mm/memory-failure: split thp earlier in memory error handling")
Cc: stable@vger.kernel.org
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/memory-failure.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 660c21859118..6953bda11e6e 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -595,10 +595,9 @@ struct task_struct *task_early_kill(struct task_struct *tsk, int force_early)
 /*
  * Collect processes when the error hit an anonymous page.
  */
-static void collect_procs_anon(struct page *page, struct list_head *to_kill,
-				int force_early)
+static void collect_procs_anon(struct folio *folio, struct page *page,
+		struct list_head *to_kill, int force_early)
 {
-	struct folio *folio = page_folio(page);
 	struct vm_area_struct *vma;
 	struct task_struct *tsk;
 	struct anon_vma *av;
@@ -633,12 +632,12 @@ static void collect_procs_anon(struct page *page, struct list_head *to_kill,
 /*
  * Collect processes when the error hit a file mapped page.
  */
-static void collect_procs_file(struct page *page, struct list_head *to_kill,
-				int force_early)
+static void collect_procs_file(struct folio *folio, struct page *page,
+		struct list_head *to_kill, int force_early)
 {
 	struct vm_area_struct *vma;
 	struct task_struct *tsk;
-	struct address_space *mapping = page->mapping;
+	struct address_space *mapping = folio->mapping;
 	pgoff_t pgoff;
 
 	i_mmap_lock_read(mapping);
@@ -704,17 +703,17 @@ static void collect_procs_fsdax(struct page *page,
 /*
  * Collect the processes who have the corrupted page mapped to kill.
  */
-static void collect_procs(struct page *page, struct list_head *tokill,
-				int force_early)
+static void collect_procs(struct folio *folio, struct page *page,
+		struct list_head *tokill, int force_early)
 {
-	if (!page->mapping)
+	if (!folio->mapping)
 		return;
 	if (unlikely(PageKsm(page)))
 		collect_procs_ksm(page, tokill, force_early);
 	else if (PageAnon(page))
-		collect_procs_anon(page, tokill, force_early);
+		collect_procs_anon(folio, page, tokill, force_early);
 	else
-		collect_procs_file(page, tokill, force_early);
+		collect_procs_file(folio, page, tokill, force_early);
 }
 
 struct hwpoison_walk {
@@ -1602,7 +1601,7 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
 	 * mapped in dirty form.  This has to be done before try_to_unmap,
 	 * because ttu takes the rmap data structures down.
 	 */
-	collect_procs(hpage, &tokill, flags & MF_ACTION_REQUIRED);
+	collect_procs(folio, p, &tokill, flags & MF_ACTION_REQUIRED);
 
 	if (PageHuge(hpage) && !PageAnon(hpage)) {
 		/*
@@ -1772,7 +1771,7 @@ static int mf_generic_kill_procs(unsigned long long pfn, int flags,
 	 * SIGBUS (i.e. MF_MUST_KILL)
 	 */
 	flags |= MF_ACTION_REQUIRED | MF_MUST_KILL;
-	collect_procs(&folio->page, &to_kill, true);
+	collect_procs(folio, &folio->page, &to_kill, true);
 
 	unmap_and_kill(&to_kill, pfn, folio->mapping, folio->index, flags);
 unlock:
-- 
2.42.0


