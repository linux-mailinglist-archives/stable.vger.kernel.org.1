Return-Path: <stable+bounces-42101-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8520D8B7168
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 12:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C146284B6A
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 10:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E207A12C801;
	Tue, 30 Apr 2024 10:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V8qFLAon"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3A912C550;
	Tue, 30 Apr 2024 10:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714474573; cv=none; b=jnOe0EdwhHa4tQDSR0tb4vD8L3sHsw+5AjWtBE2h03kQcerrZIrnWv+ZK5bsI623ltl4s7P+T0ueHXJ+2REdH/YD9ufv1/NCNw7RBOXJ9NQxu+vS5x63I6Wa9szO4IUJxc1i8sEoc8HMolurfNF4v8WbXLT6vQ+pCU/QJFNlXVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714474573; c=relaxed/simple;
	bh=Cfx8HrDeAFuxI007umRq8jxsPMCS+y3o+pjNu0rQZpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CQVuCyhqrOUA6qlwtUTtYKZZwAe4u4TWdzYwCRVha+Nhn7Q6ktIu5xeJWqArtOoowA0m2iwbV9su3HYltEfWwA07FvNz6BO8EY2MZAUGPn9j4VZwmsTYolbAWKDMZfWAD4fgyArALd/ihCqEkQjetWTeeV7wJfWkj15+KGd625Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V8qFLAon; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 290CCC2BBFC;
	Tue, 30 Apr 2024 10:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714474573;
	bh=Cfx8HrDeAFuxI007umRq8jxsPMCS+y3o+pjNu0rQZpo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V8qFLAon9tZJ/xPGx3JCZiU0e87JY01Fw8LikuqcgO9n70SJLI4B5PzJGtlVpvPDr
	 8wFrS0dwDn204vZtBlZsVsfyZpSi/he+a544ZSNgcE6uPISxIdORIsQYJ+PmeuxcDT
	 gtsvclnSlsARi55iIr+UIMp/QHfS/zB4RaZz5EOk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.8 198/228] mm: turn folio_test_hugetlb into a PageType
Date: Tue, 30 Apr 2024 12:39:36 +0200
Message-ID: <20240430103109.516145359@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430103103.806426847@linuxfoundation.org>
References: <20240430103103.806426847@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthew Wilcox (Oracle) <willy@infradead.org>

commit d99e3140a4d33e26066183ff727d8f02f56bec64 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/page-flags.h     |   70 +++++++++++++++++++----------------------
 include/trace/events/mmflags.h |    1 
 kernel/crash_core.c            |    5 +-
 mm/hugetlb.c                   |   22 +-----------
 4 files changed, 39 insertions(+), 59 deletions(-)

--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -190,7 +190,6 @@ enum pageflags {
 
 	/* At least one page in this folio has the hwpoison flag set */
 	PG_has_hwpoisoned = PG_error,
-	PG_hugetlb = PG_active,
 	PG_large_rmappable = PG_workingset, /* anon or file-backed */
 };
 
@@ -850,29 +849,6 @@ TESTPAGEFLAG_FALSE(LargeRmappable, large
 
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
@@ -929,18 +905,6 @@ PAGEFLAG_FALSE(HasHWPoisoned, has_hwpois
 #endif
 
 /*
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
-/*
  * For pages that are never mapped to userspace (and aren't PageSlab),
  * page_type may be used.  Because it is initialised to -1, we invert the
  * sense of the bit, so __SetPageFoo *clears* the bit used for PageFoo, and
@@ -956,6 +920,7 @@ static inline bool is_page_hwpoison(stru
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
@@ -1116,7 +1112,7 @@ static __always_inline void __ClearPageA
  */
 #define PAGE_FLAGS_SECOND						\
 	(0xffUL /* order */		| 1UL << PG_has_hwpoisoned |	\
-	 1UL << PG_hugetlb		| 1UL << PG_large_rmappable)
+	 1UL << PG_large_rmappable)
 
 #define PAGE_FLAGS_PRIVATE				\
 	(1UL << PG_private | 1UL << PG_private_2)
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -135,6 +135,7 @@ IF_HAVE_PG_ARCH_X(arch_3)
 #define DEF_PAGETYPE_NAME(_name) { PG_##_name, __stringify(_name) }
 
 #define __def_pagetype_names						\
+	DEF_PAGETYPE_NAME(hugetlb),					\
 	DEF_PAGETYPE_NAME(offline),					\
 	DEF_PAGETYPE_NAME(guard),					\
 	DEF_PAGETYPE_NAME(table),					\
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -814,11 +814,10 @@ static int __init crash_save_vmcoreinfo_
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
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1623,7 +1623,7 @@ static inline void __clear_hugetlb_destr
 {
 	lockdep_assert_held(&hugetlb_lock);
 
-	folio_clear_hugetlb(folio);
+	__folio_clear_hugetlb(folio);
 }
 
 /*
@@ -1710,7 +1710,7 @@ static void add_hugetlb_folio(struct hst
 		h->surplus_huge_pages_node[nid]++;
 	}
 
-	folio_set_hugetlb(folio);
+	__folio_set_hugetlb(folio);
 	folio_change_private(folio, NULL);
 	/*
 	 * We have to set hugetlb_vmemmap_optimized again as above
@@ -2048,7 +2048,7 @@ static void __prep_account_new_huge_page
 
 static void init_new_hugetlb_folio(struct hstate *h, struct folio *folio)
 {
-	folio_set_hugetlb(folio);
+	__folio_set_hugetlb(folio);
 	INIT_LIST_HEAD(&folio->lru);
 	hugetlb_set_folio_subpool(folio, NULL);
 	set_hugetlb_cgroup(folio, NULL);
@@ -2159,22 +2159,6 @@ static bool prep_compound_gigantic_folio
 }
 
 /*
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
-/*
  * Find and lock address space (mapping) in write mode.
  *
  * Upon entry, the page is locked which means that page_mapping() is



