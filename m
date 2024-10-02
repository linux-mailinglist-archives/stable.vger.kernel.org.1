Return-Path: <stable+bounces-78615-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA3B98D0D7
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 12:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65862284499
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 10:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A921E493F;
	Wed,  2 Oct 2024 10:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bWJGZeR/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F371E493E
	for <stable@vger.kernel.org>; Wed,  2 Oct 2024 10:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727863749; cv=none; b=PlikNMr8rz7XbNaHxJzFQsIF7vyweS3RIEgWsmgQEss1DyXEZ14hb1DL6Az8NcngVj4gxx65GgqWGbRg4rEpKj1t0jP0svOkSE552nnO7Rdlwd+n00IVTwE7ZXC4I3q0dqhLlgdqjprTQzkHpNEqaE8rX7lxZURXNIb1Hw/USSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727863749; c=relaxed/simple;
	bh=++BXNq5qbHrd6+ak5Q1Muah1LLsp76amA+YxLIJydd0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=SqrPP7gY9avJEip602p27czUhmHWONSKb89/o1Vh/Slr76CzaNUan0yIcf/3bQBTiXvkU/+h6uonqDlqSjgaBsQY+keWODoQp6KvdMUa6qmaZLmdlUku4EDSPZe/ra7pM7olGXajyyDGl1OcvIVEtSV9M9ieP5LYKtoiWAnIwXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bWJGZeR/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F2E5C4CECD;
	Wed,  2 Oct 2024 10:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727863748;
	bh=++BXNq5qbHrd6+ak5Q1Muah1LLsp76amA+YxLIJydd0=;
	h=Subject:To:Cc:From:Date:From;
	b=bWJGZeR/GMDape94WEpeJzZDqZQSsTQLP3NuFR3s5IA+llmw4Onr1JD4pHyhxSxZ+
	 PmjjJShDAoDyv8MKkr3RbpV6wLbgzoyiwndEBLTVCALg7ocUaSAG7HuBcpXL7hLHCv
	 HSeLKO51i2u3xHekEPm4tSCUY7q2bBUX4luBSPFQ=
Subject: FAILED: patch "[PATCH] mm/codetag: fix pgalloc_tag_split()" failed to apply to 6.11-stable tree
To: yuzhao@google.com,akpm@linux-foundation.org,kent.overstreet@linux.dev,muchun.song@linux.dev,stable@vger.kernel.org,surenb@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 02 Oct 2024 12:09:05 +0200
Message-ID: <2024100205-snowsuit-agony-4387@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.11-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.11.y
git checkout FETCH_HEAD
git cherry-pick -x 95599ef684d01136a8b77c16a7c853496786e173
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100205-snowsuit-agony-4387@gregkh' --subject-prefix 'PATCH 6.11.y' HEAD^..

Possible dependencies:

95599ef684d0 ("mm/codetag: fix pgalloc_tag_split()")
cf54f310d0d3 ("mm/hugetlb: use __GFP_COMP for gigantic folios")
c0f398c3b2cf ("mm/hugetlb_vmemmap: batch HVO work when demoting")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 95599ef684d01136a8b77c16a7c853496786e173 Mon Sep 17 00:00:00 2001
From: Yu Zhao <yuzhao@google.com>
Date: Thu, 5 Sep 2024 22:21:07 -0600
Subject: [PATCH] mm/codetag: fix pgalloc_tag_split()

The current assumption is that a large folio can only be split into
order-0 folios.  That is not the case for hugeTLB demotion, nor for THP
split: see commit c010d47f107f ("mm: thp: split huge page to any lower
order pages").

When a large folio is split into ones of a lower non-zero order, only the
new head pages should be tagged.  Tagging tail pages can cause imbalanced
"calls" counters, since only head pages are untagged by pgalloc_tag_sub()
and the "calls" counts on tail pages are leaked, e.g.,

  # echo 2048kB >/sys/kernel/mm/hugepages/hugepages-1048576kB/demote_size
  # echo 700 >/sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
  # time echo 700 >/sys/kernel/mm/hugepages/hugepages-1048576kB/demote
  # echo 0 >/sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
  # grep alloc_gigantic_folio /proc/allocinfo

Before this patch:
  0  549427200  mm/hugetlb.c:1549 func:alloc_gigantic_folio

  real  0m2.057s
  user  0m0.000s
  sys   0m2.051s

After this patch:
  0          0  mm/hugetlb.c:1549 func:alloc_gigantic_folio

  real  0m1.711s
  user  0m0.000s
  sys   0m1.704s

Not tagging tail pages also improves the splitting time, e.g., by about
15% when demoting 1GB hugeTLB folios to 2MB ones, as shown above.

Link: https://lkml.kernel.org/r/20240906042108.1150526-2-yuzhao@google.com
Fixes: be25d1d4e822 ("mm: create new codetag references during page splitting")
Signed-off-by: Yu Zhao <yuzhao@google.com>
Acked-by: Suren Baghdasaryan <surenb@google.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/include/linux/mm.h b/include/linux/mm.h
index b0ff06d18c71..6bb778cbaabf 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4084,4 +4084,34 @@ void vma_pgtable_walk_end(struct vm_area_struct *vma);
 
 int reserve_mem_find_by_name(const char *name, phys_addr_t *start, phys_addr_t *size);
 
+#ifdef CONFIG_MEM_ALLOC_PROFILING
+static inline void pgalloc_tag_split(struct folio *folio, int old_order, int new_order)
+{
+	int i;
+	struct alloc_tag *tag;
+	unsigned int nr_pages = 1 << new_order;
+
+	if (!mem_alloc_profiling_enabled())
+		return;
+
+	tag = pgalloc_tag_get(&folio->page);
+	if (!tag)
+		return;
+
+	for (i = nr_pages; i < (1 << old_order); i += nr_pages) {
+		union codetag_ref *ref = get_page_tag_ref(folio_page(folio, i));
+
+		if (ref) {
+			/* Set new reference to point to the original tag */
+			alloc_tag_ref_set(ref, tag);
+			put_page_tag_ref(ref);
+		}
+	}
+}
+#else /* !CONFIG_MEM_ALLOC_PROFILING */
+static inline void pgalloc_tag_split(struct folio *folio, int old_order, int new_order)
+{
+}
+#endif /* CONFIG_MEM_ALLOC_PROFILING */
+
 #endif /* _LINUX_MM_H */
diff --git a/include/linux/pgalloc_tag.h b/include/linux/pgalloc_tag.h
index 207f0c83c8e9..59a3deb792a8 100644
--- a/include/linux/pgalloc_tag.h
+++ b/include/linux/pgalloc_tag.h
@@ -80,36 +80,6 @@ static inline void pgalloc_tag_sub(struct page *page, unsigned int nr)
 	}
 }
 
-static inline void pgalloc_tag_split(struct page *page, unsigned int nr)
-{
-	int i;
-	struct page_ext *first_page_ext;
-	struct page_ext *page_ext;
-	union codetag_ref *ref;
-	struct alloc_tag *tag;
-
-	if (!mem_alloc_profiling_enabled())
-		return;
-
-	first_page_ext = page_ext = page_ext_get(page);
-	if (unlikely(!page_ext))
-		return;
-
-	ref = codetag_ref_from_page_ext(page_ext);
-	if (!ref->ct)
-		goto out;
-
-	tag = ct_to_alloc_tag(ref->ct);
-	page_ext = page_ext_next(page_ext);
-	for (i = 1; i < nr; i++) {
-		/* Set new reference to point to the original tag */
-		alloc_tag_ref_set(codetag_ref_from_page_ext(page_ext), tag);
-		page_ext = page_ext_next(page_ext);
-	}
-out:
-	page_ext_put(first_page_ext);
-}
-
 static inline struct alloc_tag *pgalloc_tag_get(struct page *page)
 {
 	struct alloc_tag *tag = NULL;
@@ -142,7 +112,6 @@ static inline void clear_page_tag_ref(struct page *page) {}
 static inline void pgalloc_tag_add(struct page *page, struct task_struct *task,
 				   unsigned int nr) {}
 static inline void pgalloc_tag_sub(struct page *page, unsigned int nr) {}
-static inline void pgalloc_tag_split(struct page *page, unsigned int nr) {}
 static inline struct alloc_tag *pgalloc_tag_get(struct page *page) { return NULL; }
 static inline void pgalloc_tag_sub_pages(struct alloc_tag *tag, unsigned int nr) {}
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index f15f7faf2a63..cc2872f12030 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3226,7 +3226,7 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 	/* Caller disabled irqs, so they are still disabled here */
 
 	split_page_owner(head, order, new_order);
-	pgalloc_tag_split(head, 1 << order);
+	pgalloc_tag_split(folio, order, new_order);
 
 	/* See comment in __split_huge_page_tail() */
 	if (folio_test_anon(folio)) {
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 3faf5aad142d..a8624c07d8bf 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3778,7 +3778,7 @@ static long demote_free_hugetlb_folios(struct hstate *src, struct hstate *dst,
 		list_del(&folio->lru);
 
 		split_page_owner(&folio->page, huge_page_order(src), huge_page_order(dst));
-		pgalloc_tag_split(&folio->page, 1 <<  huge_page_order(src));
+		pgalloc_tag_split(folio, huge_page_order(src), huge_page_order(dst));
 
 		for (i = 0; i < pages_per_huge_page(src); i += pages_per_huge_page(dst)) {
 			struct page *page = folio_page(folio, i);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 74f13f676985..874e006f3d1c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2776,7 +2776,7 @@ void split_page(struct page *page, unsigned int order)
 	for (i = 1; i < (1 << order); i++)
 		set_page_refcounted(page + i);
 	split_page_owner(page, order, 0);
-	pgalloc_tag_split(page, 1 << order);
+	pgalloc_tag_split(page_folio(page), order, 0);
 	split_page_memcg(page, order, 0);
 }
 EXPORT_SYMBOL_GPL(split_page);
@@ -4974,7 +4974,7 @@ static void *make_alloc_exact(unsigned long addr, unsigned int order,
 		struct page *last = page + nr;
 
 		split_page_owner(page, order, 0);
-		pgalloc_tag_split(page, 1 << order);
+		pgalloc_tag_split(page_folio(page), order, 0);
 		split_page_memcg(page, order, 0);
 		while (page < --last)
 			set_page_refcounted(last);


