Return-Path: <stable+bounces-41712-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5BA8B5931
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 14:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D59751F20F86
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 12:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B27A535C1;
	Mon, 29 Apr 2024 12:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="U04SVER+"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E805537EC
	for <stable@vger.kernel.org>; Mon, 29 Apr 2024 12:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714395329; cv=none; b=CPmv1vSyYVFS8oXx/eqRu7Y393sItgXkhiSMoOgNKIRXq9ato3Q+4z7qdIz0RERhKg5Qdm4uOJa3ODij2hw7mSVCXwQCzPOutE8h6N6FxblhgIKcX5hpcTYlHp6j/LMbTciYCPHC8VkYgLAFIx1tw4YbQQ+0KLuO6dWxCYgMkBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714395329; c=relaxed/simple;
	bh=EOmKlOeZhbkTLn4shySR4+4gyrEpkywWI85JiodNrj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VSFBpRnfimQmcK+bKSRhwjLqVlr+PMhpdPkedtKfmEVvdXXDaTLlKlZE9Gml82UGUsVEwoo94gF8U2acbIqbrX/25oweAc+akdZrh/ZeE8UeTfCxkzOE6jLkvTHJHsOrZwZ57SmAvH0kOMuAQdRVbksHcvvK5/f2dkkBxIlABeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=U04SVER+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=1r2ALBjWJzw+L27cXZmRo34ri17hNeAVGRyDVgLwmIU=; b=U04SVER+LcncaDh+SdyufzlEWM
	VA+gcZr3LHvl4xK8eOWigSaAO1N7SzCgeIy9sNGDlqdmUzWiP9Jr89WKADJ4+rrqV3KZr7Asl6Lf0
	Dvlnsj0+H5FJaLP8fEhg/6fvjvAITDuPI+PBzUYSkQDvc3rZ23Cr9f3gK7ed25ljCg/LRt/9as3f8
	agNZ2ZINt7etBxZZGKZ5BjipcYgbR6uc1ee9XNXAjL5xy4fMBnI/u8KiNeJlekOKc6qhmfitcSVvT
	x5nAIHOxlWM/A7A7M/i53hrUL/6eTge9I1IYRqEO+C3V+Bt56U21xY2OUYzOeNoVJSuee4rfHuJNc
	3So4VfuQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1QXS-0000000CSpd-1v4N;
	Mon, 29 Apr 2024 12:55:22 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: stable@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.8.y] mm: turn folio_test_hugetlb into a PageType
Date: Mon, 29 Apr 2024 13:55:19 +0100
Message-ID: <20240429125519.2970760-1-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <2024042907-unquote-thank-8de2@gregkh>
References: <2024042907-unquote-thank-8de2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current folio_test_hugetlb() can be fooled by a concurrent folio split
into returning true for a folio which has never belonged to hugetlbfs.
This can't happen if the caller holds a refcount on it, but we have a few
places (memory-failure, compaction, procfs) which do not and should not
take a speculative reference.

Since hugetlb pages do not use individual page mapcounts (they are always
fully mapped and use the entire_mapcount field to record the number of
mappings), the PageType field is available now that page_mapcount()
ignores the value in this field.

In compaction and with CONFIG_DEBUG_VM enabled, the current implementation
can result in an oops, as reported by Luis. This happens since 9c5ccf2db04b
("mm: remove HUGETLB_PAGE_DTOR") effectively added some VM_BUG_ON() checks
in the PageHuge() testing path.

[willy@infradead.org: update vmcoreinfo]
  Link: https://lkml.kernel.org/r/ZgGZUvsdhaT1Va-T@casper.infradead.org
Link: https://lkml.kernel.org/r/20240321142448.1645400-6-willy@infradead.org
Fixes: 9c5ccf2db04b ("mm: remove HUGETLB_PAGE_DTOR")
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reported-by: Luis Chamberlain <mcgrof@kernel.org>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218227
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit d99e3140a4d33e26066183ff727d8f02f56bec64)
---
 include/linux/page-flags.h     | 70 ++++++++++++++++------------------
 include/trace/events/mmflags.h |  1 +
 kernel/crash_core.c            |  5 +--
 mm/hugetlb.c                   | 22 ++---------
 4 files changed, 39 insertions(+), 59 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 0d86052ae5e5..68e9973cd62d 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -190,7 +190,6 @@ enum pageflags {
 
 	/* At least one page in this folio has the hwpoison flag set */
 	PG_has_hwpoisoned = PG_error,
-	PG_hugetlb = PG_active,
 	PG_large_rmappable = PG_workingset, /* anon or file-backed */
 };
 
@@ -850,29 +849,6 @@ TESTPAGEFLAG_FALSE(LargeRmappable, large_rmappable)
 
 #define PG_head_mask ((1UL << PG_head))
 
-#ifdef CONFIG_HUGETLB_PAGE
-int PageHuge(struct page *page);
-SETPAGEFLAG(HugeTLB, hugetlb, PF_SECOND)
-CLEARPAGEFLAG(HugeTLB, hugetlb, PF_SECOND)
-
-/**
- * folio_test_hugetlb - Determine if the folio belongs to hugetlbfs
- * @folio: The folio to test.
- *
- * Context: Any context.  Caller should have a reference on the folio to
- * prevent it from being turned into a tail page.
- * Return: True for hugetlbfs folios, false for anon folios or folios
- * belonging to other filesystems.
- */
-static inline bool folio_test_hugetlb(struct folio *folio)
-{
-	return folio_test_large(folio) &&
-		test_bit(PG_hugetlb, folio_flags(folio, 1));
-}
-#else
-TESTPAGEFLAG_FALSE(Huge, hugetlb)
-#endif
-
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 /*
  * PageHuge() only returns true for hugetlbfs pages, but not for
@@ -928,18 +904,6 @@ PAGEFLAG_FALSE(HasHWPoisoned, has_hwpoisoned)
 	TESTSCFLAG_FALSE(HasHWPoisoned, has_hwpoisoned)
 #endif
 
-/*
- * Check if a page is currently marked HWPoisoned. Note that this check is
- * best effort only and inherently racy: there is no way to synchronize with
- * failing hardware.
- */
-static inline bool is_page_hwpoison(struct page *page)
-{
-	if (PageHWPoison(page))
-		return true;
-	return PageHuge(page) && PageHWPoison(compound_head(page));
-}
-
 /*
  * For pages that are never mapped to userspace (and aren't PageSlab),
  * page_type may be used.  Because it is initialised to -1, we invert the
@@ -956,6 +920,7 @@ static inline bool is_page_hwpoison(struct page *page)
 #define PG_offline	0x00000100
 #define PG_table	0x00000200
 #define PG_guard	0x00000400
+#define PG_hugetlb	0x00000800
 
 #define PageType(page, flag)						\
 	((page->page_type & (PAGE_TYPE_BASE | flag)) == PAGE_TYPE_BASE)
@@ -1050,6 +1015,37 @@ PAGE_TYPE_OPS(Table, table, pgtable)
  */
 PAGE_TYPE_OPS(Guard, guard, guard)
 
+#ifdef CONFIG_HUGETLB_PAGE
+FOLIO_TYPE_OPS(hugetlb, hugetlb)
+#else
+FOLIO_TEST_FLAG_FALSE(hugetlb)
+#endif
+
+/**
+ * PageHuge - Determine if the page belongs to hugetlbfs
+ * @page: The page to test.
+ *
+ * Context: Any context.
+ * Return: True for hugetlbfs pages, false for anon pages or pages
+ * belonging to other filesystems.
+ */
+static inline bool PageHuge(const struct page *page)
+{
+	return folio_test_hugetlb(page_folio(page));
+}
+
+/*
+ * Check if a page is currently marked HWPoisoned. Note that this check is
+ * best effort only and inherently racy: there is no way to synchronize with
+ * failing hardware.
+ */
+static inline bool is_page_hwpoison(struct page *page)
+{
+	if (PageHWPoison(page))
+		return true;
+	return PageHuge(page) && PageHWPoison(compound_head(page));
+}
+
 extern bool is_free_buddy_page(struct page *page);
 
 PAGEFLAG(Isolated, isolated, PF_ANY);
@@ -1116,7 +1112,7 @@ static __always_inline void __ClearPageAnonExclusive(struct page *page)
  */
 #define PAGE_FLAGS_SECOND						\
 	(0xffUL /* order */		| 1UL << PG_has_hwpoisoned |	\
-	 1UL << PG_hugetlb		| 1UL << PG_large_rmappable)
+	 1UL << PG_large_rmappable)
 
 #define PAGE_FLAGS_PRIVATE				\
 	(1UL << PG_private | 1UL << PG_private_2)
diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index d801409b33cf..d55e53ac91bd 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -135,6 +135,7 @@ IF_HAVE_PG_ARCH_X(arch_3)
 #define DEF_PAGETYPE_NAME(_name) { PG_##_name, __stringify(_name) }
 
 #define __def_pagetype_names						\
+	DEF_PAGETYPE_NAME(hugetlb),					\
 	DEF_PAGETYPE_NAME(offline),					\
 	DEF_PAGETYPE_NAME(guard),					\
 	DEF_PAGETYPE_NAME(table),					\
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 40bd908e0a81..ebde3063b531 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -814,11 +814,10 @@ static int __init crash_save_vmcoreinfo_init(void)
 	VMCOREINFO_NUMBER(PG_head_mask);
 #define PAGE_BUDDY_MAPCOUNT_VALUE	(~PG_buddy)
 	VMCOREINFO_NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE);
-#ifdef CONFIG_HUGETLB_PAGE
-	VMCOREINFO_NUMBER(PG_hugetlb);
+#define PAGE_HUGETLB_MAPCOUNT_VALUE	(~PG_hugetlb)
+	VMCOREINFO_NUMBER(PAGE_HUGETLB_MAPCOUNT_VALUE);
 #define PAGE_OFFLINE_MAPCOUNT_VALUE	(~PG_offline)
 	VMCOREINFO_NUMBER(PAGE_OFFLINE_MAPCOUNT_VALUE);
-#endif
 
 #ifdef CONFIG_KALLSYMS
 	VMCOREINFO_SYMBOL(kallsyms_names);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index e5e3df1d3b87..fd7bc09eb5e0 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1623,7 +1623,7 @@ static inline void __clear_hugetlb_destructor(struct hstate *h,
 {
 	lockdep_assert_held(&hugetlb_lock);
 
-	folio_clear_hugetlb(folio);
+	__folio_clear_hugetlb(folio);
 }
 
 /*
@@ -1710,7 +1710,7 @@ static void add_hugetlb_folio(struct hstate *h, struct folio *folio,
 		h->surplus_huge_pages_node[nid]++;
 	}
 
-	folio_set_hugetlb(folio);
+	__folio_set_hugetlb(folio);
 	folio_change_private(folio, NULL);
 	/*
 	 * We have to set hugetlb_vmemmap_optimized again as above
@@ -2048,7 +2048,7 @@ static void __prep_account_new_huge_page(struct hstate *h, int nid)
 
 static void init_new_hugetlb_folio(struct hstate *h, struct folio *folio)
 {
-	folio_set_hugetlb(folio);
+	__folio_set_hugetlb(folio);
 	INIT_LIST_HEAD(&folio->lru);
 	hugetlb_set_folio_subpool(folio, NULL);
 	set_hugetlb_cgroup(folio, NULL);
@@ -2158,22 +2158,6 @@ static bool prep_compound_gigantic_folio_for_demote(struct folio *folio,
 	return __prep_compound_gigantic_folio(folio, order, true);
 }
 
-/*
- * PageHuge() only returns true for hugetlbfs pages, but not for normal or
- * transparent huge pages.  See the PageTransHuge() documentation for more
- * details.
- */
-int PageHuge(struct page *page)
-{
-	struct folio *folio;
-
-	if (!PageCompound(page))
-		return 0;
-	folio = page_folio(page);
-	return folio_test_hugetlb(folio);
-}
-EXPORT_SYMBOL_GPL(PageHuge);
-
 /*
  * Find and lock address space (mapping) in write mode.
  *
-- 
2.43.0


