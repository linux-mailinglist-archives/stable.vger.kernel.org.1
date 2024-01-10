Return-Path: <stable+bounces-10093-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF09827265
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 16:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22DD11C2270C
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 15:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBACD4C3BB;
	Mon,  8 Jan 2024 15:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LCWb3PD3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54E847791;
	Mon,  8 Jan 2024 15:12:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A11EC433BB;
	Mon,  8 Jan 2024 15:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704726738;
	bh=5ujZDaaD+UWn4GgjodeOIIE3e1wZ3hJMSz+YHTzUG1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LCWb3PD3iYEc0v5X5qWxD8E+0jUl0pkkYvO53B2urqCB0VDWCr96UWpg+KzBg0Mdo
	 q59TgRsO/qgOMqvgZG0bVfbJwE9qwxJQivFc37LSKj7C+xV5XI56eNWtidrsCbncoz
	 tsCaQeIIpzRkEg9Go8Sa++tJJTPpTo4qclAWH/tA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jane Chu <jane.chu@oracle.com>,
	Naoya Horiguchi <naoya.horiguchi@nec.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 063/124] mm: convert DAX lock/unlock page to lock/unlock folio
Date: Mon,  8 Jan 2024 16:08:09 +0100
Message-ID: <20240108150605.872036709@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108150602.976232871@linuxfoundation.org>
References: <20240108150602.976232871@linuxfoundation.org>
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

[ Upstream commit 91e79d22be75fec88ae58d274a7c9e49d6215099 ]

The one caller of DAX lock/unlock page already calls compound_head(), so
use page_folio() instead, then use a folio throughout the DAX code to
remove uses of page->mapping and page->index.

[jane.chu@oracle.com: add comment to mf_generic_kill_procss(), simplify mf_generic_kill_procs:folio initialization]
  Link: https://lkml.kernel.org/r/20230908222336.186313-1-jane.chu@oracle.com
Link: https://lkml.kernel.org/r/20230822231314.349200-1-willy@infradead.org
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Jane Chu <jane.chu@oracle.com>
Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Jane Chu <jane.chu@oracle.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 376907f3a0b3 ("mm/memory-failure: pass the folio and the page to collect_procs()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/dax.c            | 24 ++++++++++++------------
 include/linux/dax.h | 10 +++++-----
 mm/memory-failure.c | 29 ++++++++++++++++-------------
 3 files changed, 33 insertions(+), 30 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 8fafecbe42b15..3380b43cb6bbb 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -412,23 +412,23 @@ static struct page *dax_busy_page(void *entry)
 	return NULL;
 }
 
-/*
- * dax_lock_page - Lock the DAX entry corresponding to a page
- * @page: The page whose entry we want to lock
+/**
+ * dax_lock_folio - Lock the DAX entry corresponding to a folio
+ * @folio: The folio whose entry we want to lock
  *
  * Context: Process context.
- * Return: A cookie to pass to dax_unlock_page() or 0 if the entry could
+ * Return: A cookie to pass to dax_unlock_folio() or 0 if the entry could
  * not be locked.
  */
-dax_entry_t dax_lock_page(struct page *page)
+dax_entry_t dax_lock_folio(struct folio *folio)
 {
 	XA_STATE(xas, NULL, 0);
 	void *entry;
 
-	/* Ensure page->mapping isn't freed while we look at it */
+	/* Ensure folio->mapping isn't freed while we look at it */
 	rcu_read_lock();
 	for (;;) {
-		struct address_space *mapping = READ_ONCE(page->mapping);
+		struct address_space *mapping = READ_ONCE(folio->mapping);
 
 		entry = NULL;
 		if (!mapping || !dax_mapping(mapping))
@@ -447,11 +447,11 @@ dax_entry_t dax_lock_page(struct page *page)
 
 		xas.xa = &mapping->i_pages;
 		xas_lock_irq(&xas);
-		if (mapping != page->mapping) {
+		if (mapping != folio->mapping) {
 			xas_unlock_irq(&xas);
 			continue;
 		}
-		xas_set(&xas, page->index);
+		xas_set(&xas, folio->index);
 		entry = xas_load(&xas);
 		if (dax_is_locked(entry)) {
 			rcu_read_unlock();
@@ -467,10 +467,10 @@ dax_entry_t dax_lock_page(struct page *page)
 	return (dax_entry_t)entry;
 }
 
-void dax_unlock_page(struct page *page, dax_entry_t cookie)
+void dax_unlock_folio(struct folio *folio, dax_entry_t cookie)
 {
-	struct address_space *mapping = page->mapping;
-	XA_STATE(xas, &mapping->i_pages, page->index);
+	struct address_space *mapping = folio->mapping;
+	XA_STATE(xas, &mapping->i_pages, folio->index);
 
 	if (S_ISCHR(mapping->host->i_mode))
 		return;
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 22cd9902345d7..b463502b16e17 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -159,8 +159,8 @@ int dax_writeback_mapping_range(struct address_space *mapping,
 
 struct page *dax_layout_busy_page(struct address_space *mapping);
 struct page *dax_layout_busy_page_range(struct address_space *mapping, loff_t start, loff_t end);
-dax_entry_t dax_lock_page(struct page *page);
-void dax_unlock_page(struct page *page, dax_entry_t cookie);
+dax_entry_t dax_lock_folio(struct folio *folio);
+void dax_unlock_folio(struct folio *folio, dax_entry_t cookie);
 dax_entry_t dax_lock_mapping_entry(struct address_space *mapping,
 		unsigned long index, struct page **page);
 void dax_unlock_mapping_entry(struct address_space *mapping,
@@ -182,14 +182,14 @@ static inline int dax_writeback_mapping_range(struct address_space *mapping,
 	return -EOPNOTSUPP;
 }
 
-static inline dax_entry_t dax_lock_page(struct page *page)
+static inline dax_entry_t dax_lock_folio(struct folio *folio)
 {
-	if (IS_DAX(page->mapping->host))
+	if (IS_DAX(folio->mapping->host))
 		return ~0UL;
 	return 0;
 }
 
-static inline void dax_unlock_page(struct page *page, dax_entry_t cookie)
+static inline void dax_unlock_folio(struct folio *folio, dax_entry_t cookie)
 {
 }
 
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 16e002e08cf8f..75eb1d6857e48 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1713,20 +1713,23 @@ static void unmap_and_kill(struct list_head *to_kill, unsigned long pfn,
 	kill_procs(to_kill, flags & MF_MUST_KILL, false, pfn, flags);
 }
 
+/*
+ * Only dev_pagemap pages get here, such as fsdax when the filesystem
+ * either do not claim or fails to claim a hwpoison event, or devdax.
+ * The fsdax pages are initialized per base page, and the devdax pages
+ * could be initialized either as base pages, or as compound pages with
+ * vmemmap optimization enabled. Devdax is simplistic in its dealing with
+ * hwpoison, such that, if a subpage of a compound page is poisoned,
+ * simply mark the compound head page is by far sufficient.
+ */
 static int mf_generic_kill_procs(unsigned long long pfn, int flags,
 		struct dev_pagemap *pgmap)
 {
-	struct page *page = pfn_to_page(pfn);
+	struct folio *folio = pfn_folio(pfn);
 	LIST_HEAD(to_kill);
 	dax_entry_t cookie;
 	int rc = 0;
 
-	/*
-	 * Pages instantiated by device-dax (not filesystem-dax)
-	 * may be compound pages.
-	 */
-	page = compound_head(page);
-
 	/*
 	 * Prevent the inode from being freed while we are interrogating
 	 * the address_space, typically this would be handled by
@@ -1734,11 +1737,11 @@ static int mf_generic_kill_procs(unsigned long long pfn, int flags,
 	 * also prevents changes to the mapping of this pfn until
 	 * poison signaling is complete.
 	 */
-	cookie = dax_lock_page(page);
+	cookie = dax_lock_folio(folio);
 	if (!cookie)
 		return -EBUSY;
 
-	if (hwpoison_filter(page)) {
+	if (hwpoison_filter(&folio->page)) {
 		rc = -EOPNOTSUPP;
 		goto unlock;
 	}
@@ -1760,7 +1763,7 @@ static int mf_generic_kill_procs(unsigned long long pfn, int flags,
 	 * Use this flag as an indication that the dax page has been
 	 * remapped UC to prevent speculative consumption of poison.
 	 */
-	SetPageHWPoison(page);
+	SetPageHWPoison(&folio->page);
 
 	/*
 	 * Unlike System-RAM there is no possibility to swap in a
@@ -1769,11 +1772,11 @@ static int mf_generic_kill_procs(unsigned long long pfn, int flags,
 	 * SIGBUS (i.e. MF_MUST_KILL)
 	 */
 	flags |= MF_ACTION_REQUIRED | MF_MUST_KILL;
-	collect_procs(page, &to_kill, true);
+	collect_procs(&folio->page, &to_kill, true);
 
-	unmap_and_kill(&to_kill, pfn, page->mapping, page->index, flags);
+	unmap_and_kill(&to_kill, pfn, folio->mapping, folio->index, flags);
 unlock:
-	dax_unlock_page(page, cookie);
+	dax_unlock_folio(folio, cookie);
 	return rc;
 }
 
-- 
2.43.0




